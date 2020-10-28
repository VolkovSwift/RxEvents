//
//  FavoriteProvider.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import Foundation
import RxSwift

class FavoriteProvider {
    
    let swapFavoriteMark = PublishSubject<Event>()
    
    let favoriteRefreshed = BehaviorSubject<Void>(value: ())
    
    private var favoriteSet: [Event] = []
    
    private var fetchedEvents: [Event] = []
    
    private var objects: [EventObject] = []
    
    func setFavorite(event: Event) {
        if favoriteSet.contains(event) {
            favoriteSet = favoriteSet.filter {$0 != event}
        } else {
            favoriteSet.append(event)
        }
        print(favoriteSet.count)
        favoriteRefreshed.onNext(())
    }
    
    func returnFavorite() -> [Event] {
        favoriteSet
    }
    
    func handleFetchedEvents(events: [Event]) {
        for event in events {
            fetchedEvents.append(event)
        }
    }
    
    func makeListOfObjects() -> [EventObject] {
        
        for event in fetchedEvents {
            if favoriteSet.contains(event) {
                objects.append(EventObject(event: event, isFavorite: true))
            } else {
                objects.append(EventObject(event: event, isFavorite: false))
            }
        }
        return objects
    }
}
