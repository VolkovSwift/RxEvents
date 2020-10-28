//
//  EventsViewModel.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import RxCocoa
import RxSwift

struct EventsViewModel {
    
    //MARK: - Properties
    
    let objects = PublishRelay<[EventObject]>()
    let events = PublishRelay<[EventItem]>()
    let favorites = PublishRelay<Set<EventItem>>()
    
    let loading = BehaviorRelay<Bool>(value: true)
    let error = PublishRelay<String>()
    let refreshObjects = PublishRelay<Void>()
    let timer = Observable<Void>.just(())
    
    //MARK: - Private Properties
    
    private let networkProvider: NetworkProviderProtocol
    private let favoriteProvider: FavoriteProviderProtocol
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    init(networkProvider: NetworkProviderProtocol, favoriteProvider: FavoriteProviderProtocol) {
        self.networkProvider = networkProvider
        self.favoriteProvider = favoriteProvider
        
        bindings()
        
        self.favoriteProvider.updateValuesFromStorage()
        refreshObjects.accept(())
        loading.accept(true)
    }
    
    //MARK: - Methods
    
    func toggle(event: EventItem) {
        favoriteProvider.setFavorite(event: event)
    }

    func bindings() {
        favoriteProvider.events
            .bind(to: events)
            .disposed(by: disposeBag)

        favoriteProvider.favorites
            .bind(to: favorites)
            .disposed(by: disposeBag)
        
        refreshObjects.subscribe(onNext: { _ in
            requestItems(url: URLPath.base.rawValue)
        }).disposed(by: disposeBag)
                   
        timer.bind(to: refreshObjects)
            .disposed(by: disposeBag)
        
        
        Observable
            .combineLatest(events, favorites) { events, favorites in
                events.map {EventObject(event: $0, isFavorite: favorites.contains($0)) }.sorted(by: >)
            }
            .bind(to: objects)
            .disposed(by: disposeBag)
    }
    
    func requestItems(url: String) {
        networkProvider.request(url: url) { result in
            switch result {
            case let .success(events):
                favoriteProvider.updateEvents(events: events.events.event)
            case let .failure(error):
                self.error.accept(error.localizedDescription)
            }
            loading.accept(false)
        }
    }
}


