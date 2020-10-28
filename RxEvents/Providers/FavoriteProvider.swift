//
//  FavoriteProvider.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import Foundation
import RxSwift

protocol FavoriteProviderProtocol {
    var events: PublishSubject<[EventItem]> { get }
    var favorites: PublishSubject<Set<EventItem>> { get }

    func setFavorite(event: EventItem)
    func updateEvents(events: [EventItem])
    func updateValuesFromStorage()
    func updateFavoritesFromStorage()
}


class FavoriteProvider: FavoriteProviderProtocol {
    enum Keys: String {
        case events = "events"
        case favorite = "favorite"
    }
    
    let events = PublishSubject<[EventItem]>()
    let favorites = PublishSubject<Set<EventItem>>()

    //MARK: - Storage
    
    @Storage(key: Keys.events.rawValue, defaultValue: [])
    static var storageEvents: [EventItem]
    
    
    @Storage(key: Keys.favorite.rawValue, defaultValue: [])
    static var storageFavorites: Set<EventItem>

    //MARK: - Methods
        
    func setFavorite(event: EventItem) {
        if FavoriteProvider.storageFavorites.contains(event) {
            FavoriteProvider.storageFavorites.remove(event)
        } else {
            FavoriteProvider.storageFavorites.insert(event)
        }
        favorites.onNext(FavoriteProvider.storageFavorites)
    }
        
    func updateEvents(events: [EventItem]) {
        FavoriteProvider.storageEvents = events
        self.events.onNext(FavoriteProvider.storageEvents)
        self.favorites.onNext(FavoriteProvider.storageFavorites)
    }
    
    func updateValuesFromStorage() {
        events.onNext(FavoriteProvider.storageEvents)
        favorites.onNext(FavoriteProvider.storageFavorites)
    }
    
    func updateFavoritesFromStorage() {
            favorites.onNext(FavoriteProvider.storageFavorites)
        }
}

