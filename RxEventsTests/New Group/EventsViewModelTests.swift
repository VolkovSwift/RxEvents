//
//  EventsViewModelTests.swift
//  RxEventsTests
//
//  Created by Uladzislau Volkau on 10/26/20.
//
@testable import RxEvents
import XCTest
import RxTest
import RxSwift

class EventsViewModelTests: XCTestCase {
    var sut: EventsViewModel!
    var scheduler: TestScheduler!
    var networkProvider: MockNetworkProvider!
    var favoriteProvider: MockFavoriteProvider!
    var testItems: [EventObject]!
    var disposeBag: DisposeBag!
    
    
    override func setUp() {
        super.setUp()
        networkProvider = MockNetworkProvider()
        favoriteProvider = MockFavoriteProvider()
        sut = EventsViewModel(networkProvider: networkProvider,favoriteProvider: favoriteProvider)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        super.tearDown()
        scheduler = nil
        networkProvider = nil
        favoriteProvider = nil
        sut = nil
        testItems = nil
        disposeBag = nil
    }

    
    func testToggle() {
        let testEvent = EventItem(id: "Foo", title: "Bar", startTime: "Baz", url: "Qux")
        sut.toggle(event: testEvent)
        XCTAssertTrue(favoriteProvider.setFavoriteWasCalled)
    }
    
    func testRequestItemsWasCalled() {
        sut.requestItems(url: "Foo")
        XCTAssertTrue(networkProvider.requestWasCalled)
    }
    
    func testBingings_events() {
        let testEvent = EventItem(id: "Foo", title: "Bar", startTime: "Baz", url: "Qux")
        
        let action = scheduler.createObserver([EventItem].self)
        
        sut.events
            .bind(to: action)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, [testEvent])])
            .bind(to: favoriteProvider.events)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(action.events, [.next(10, [testEvent])])
        
    }
    
    func testBingings_favorites() {
        let testEvent: Set<EventItem> = [EventItem(id: "Foo", title: "Bar", startTime: "Baz", url: "Qux")]
        
        let action = scheduler.createObserver(Set<EventItem>.self)
        
        sut.favorites
            .bind(to: action)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, testEvent)])
            .bind(to: favoriteProvider.favorites)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(action.events, [.next(10, testEvent)])
        
    }
    
    func testBingings_objects() {
        let testEvent = EventItem(id: "Foo", title: "Bar", startTime: "Baz", url: "Qux")
        let testEvent1 = EventItem(id: "Foo1", title: "Bar1", startTime: "Baz1", url: "Qux1")
        let testEvent2 = EventItem(id: "Foo2", title: "Bar2", startTime: "Baz2", url: "Qux2")
        let objects = [EventObject(event: testEvent, isFavorite: true), EventObject(event: testEvent1, isFavorite: false), EventObject(event: testEvent2, isFavorite: false)]
        
        let action = scheduler.createObserver([EventObject].self)
        
        
        sut.objects
            .bind(to: action)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(20, [testEvent])])
            .bind(to: favoriteProvider.favorites)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, [testEvent, testEvent1, testEvent2])])
            .bind(to: favoriteProvider.events)
            .disposed(by: disposeBag)
        
        
        scheduler.start()
        
        XCTAssertEqual(action.events, [.next(20, objects.sorted(by: >))])
        
    }
    
    func testRequestWithCorrectURL() {
        sut.requestItems(url: "Foo")
        XCTAssertTrue(networkProvider.isRequestSuccess)
    }
    
    
    func testRequestWithIncorrectURL() {
        sut.requestItems(url: "Bar")
        XCTAssertTrue(networkProvider.isRequestFailure)
    }
}
