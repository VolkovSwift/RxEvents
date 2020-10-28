//
//  MockFavoriteProvider.swift
//  RxEventsTests
//
//  Created by user on 10/27/20.
//
@testable import RxEvents
import Foundation
import RxSwift
import RxCocoa

class MockFavoriteProvider: FavoriteProviderProtocol {
    
    let events = PublishSubject<[EventItem]>()
    let favorites = PublishSubject<Set<EventItem>>()
        
    let event = EventItem(id: "testId", title: "testTitle", startTime: "testTime", url: "testUrl")
    var setFavoriteWasCalled = false
    var updateEventsWasCalled = false
    var updateValuesFromStorageWasCalled = false
    var updateFavoritesFromStorageWasCalled = false
    
    
    func setFavorite(event: EventItem) {
        setFavoriteWasCalled.toggle()
        events.onNext([event])
    }
    
    func updateEvents(events: [EventItem]) {
        updateEventsWasCalled.toggle()
    }
    
    func updateValuesFromStorage() {
        updateValuesFromStorageWasCalled.toggle()
    }
    
    func updateFavoritesFromStorage() {
        updateFavoritesFromStorageWasCalled.toggle()
    }
    
    func setFavorite(event: EventItem, completionHandler: @escaping (Result<Set<EventItem>, NetworkingError>) -> Void) {
        completionHandler(.failure(.decodingError))
    }
    
            
    func updateEvents(events: [EventItem], completionHandler: @escaping (Result<[EventItem], NetworkingError>) -> Void) {
        completionHandler(.failure(.decodingError))
    }
    
    func makeListOfObjects() -> [EventObject] {
        
        let eventObject = EventObject(event: event, isFavorite: true)
        return [eventObject]
    }
    
    func getEvents() -> [EventItem] {
        return [event]
    }
    
    func getFavorite() -> Set<EventItem> {
        let set: Set<EventItem> = [event]
        return set
    }
    
    
}
