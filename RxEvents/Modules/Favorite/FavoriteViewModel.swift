//
//  FavoriteViewModel.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import RxCocoa
import RxSwift

struct FavoriteViewModel {
    
    //MARK: - Properties
    
    let objects = PublishRelay<[EventObject]>()
    let favorites = PublishRelay<Set<EventItem>>()
    
    //MARK: - Private properties
    
    private let favoriteProvider: FavoriteProviderProtocol
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    init(favoriteProvider: FavoriteProviderProtocol) {
        self.favoriteProvider = favoriteProvider
        
        bindings()
        self.favoriteProvider.updateValuesFromStorage()
    }
    
    //MARK: - Methods

    func refresh() {
            favoriteProvider.updateFavoritesFromStorage()
        }
    
    func toggle(event: EventItem) {
        favoriteProvider.setFavorite(event: event)
    }

    private func bindings() {
        favoriteProvider.favorites
            .bind(to: favorites)
            .disposed(by: disposeBag)
        
        favorites
            .map { $0.map { EventObject(event: $0, isFavorite: true) }.sorted(by: >) }
            .bind(to: objects)
            .disposed(by: disposeBag)
    }
}
