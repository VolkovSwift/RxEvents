//
//  EventHelper.swift
//  RxEvents
//
//  Created by user on 10/24/20.
//

import Foundation
import RxSwift
import RxCocoa

final class EventHelper {
        
    let eventsData: Observable<[Event]>
    let connectionError: Observable<Error>
    
    
    private let apiClient: APIClient
    private let disposeBag = DisposeBag()
    
    
    init(apiClient: APIClient) {
        
        self.apiClient = apiClient
        
        let connectionError = PublishSubject<Error>()
        
        let eventsData = apiClient.getEventsEntity()
            .map { $0.events.event}
            .catchError { error -> Observable<[Event]> in
                connectionError.on(.next(error))
                return Observable.of([])
            }
        
        
                
        self.eventsData = eventsData
        self.connectionError = connectionError.asObservable()
    }
}
