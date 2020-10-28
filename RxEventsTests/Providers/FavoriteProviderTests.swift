//
//  FavoriteProviderTests.swift
//  RxEventsTests
//
//  Created by Uladzislau Volkau on 10/28/20.
//

@testable import RxEvents
import XCTest
import RxTest
import RxSwift

class FavoriteProviderTests: XCTestCase {
    var sut: FavoriteProvider!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
        override func setUp() {
            super.setUp()
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            sut = FavoriteProvider()
            scheduler = TestScheduler(initialClock: 0)
            disposeBag = DisposeBag()
        }
    
        override func tearDown() {
            sut = nil
            scheduler = nil
            disposeBag = nil
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            super.tearDown()
        }
    
        func testModuleNotNil() {
            XCTAssertNotNil(sut, "sut is not nil")
            XCTAssertNotNil(scheduler, "scheduler is not nil")
        }
    
    func testSetFavoriteFunction() {
        let testEvent = EventItem(id: "Foo", title: "Bar", startTime: "Baz", url: "Qux")
                
        let action = scheduler.createObserver(Set<EventItem>.self)
        
        sut.favorites
            .bind(to: action)
            .disposed(by: disposeBag)
        
        sut.setFavorite(event: testEvent)
        sut.setFavorite(event: testEvent)

        scheduler.start()
    
        XCTAssertEqual(action.events, [.next(0, Set([testEvent])), .next(0, [])])
    }
    

    func testUpdateEventsFunction() {
        let testEvent = EventItem(id: "Foo", title: "Bar", startTime: "Baz", url: "Qux")
                
        let action = scheduler.createObserver([EventItem].self)
        
        sut.events
            .bind(to: action)
            .disposed(by: disposeBag)
        
        sut.updateEvents(events: [testEvent])

        scheduler.start()
    
        XCTAssertEqual(action.events, [.next(0, [testEvent])])
    }
    
    func testUpdateValuesFromStorage() {
        let testEvent = EventItem(id: "Foo", title: "Bar", startTime: "Baz", url: "Qux")
        
        let action = scheduler.createObserver([EventItem].self)
            
        sut.updateEvents(events: [testEvent])
        
        sut.events
            .bind(to: action)
            .disposed(by: disposeBag)
        
        sut.updateValuesFromStorage()

        scheduler.start()
    
        XCTAssertEqual(action.events, [.next(0, [testEvent])])
    }
    
    func testUpdateFavoritesFromStorage() {
        let testEvent = EventItem(id: "Foo", title: "Bar", startTime: "Baz", url: "Qux")
        
        let action = scheduler.createObserver(Set<EventItem>.self)
    
        sut.setFavorite(event: testEvent)
        
        sut.favorites
            .bind(to: action)
            .disposed(by: disposeBag)
        
        sut.updateFavoritesFromStorage()

        scheduler.start()
    
        XCTAssertEqual(action.events, [.next(0, Set([testEvent]))])
    }

}
