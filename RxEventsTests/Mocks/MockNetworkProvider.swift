//
//  MockNetworkProvider.swift
//  RxEventsTests
//
//  Created by user on 10/27/20.
//

@testable import RxEvents
import Foundation



class MockNetworkProvider: NetworkProviderProtocol {
    
    var requestWasCalled = false
    var isRequestSuccess = false
    var isRequestFailure = false
    
    func request(url: String, completionHandler: @escaping (Result<EventsEntity, NetworkingError>) -> Void) {
        let testEntity = EventsEntity(events: EventList(event: []))
        
        switch url {
        case "Foo":
            completionHandler(.success(testEntity))
            isRequestSuccess.toggle()
        case "Bar":
            completionHandler(.failure(.incorrectURL))
            isRequestFailure.toggle()
        case "Baz":
            completionHandler(.failure(.invalidResponse))
            isRequestFailure.toggle()
        case "Qux":
            completionHandler(.failure(.invalidResponse))
            isRequestFailure.toggle()
        default:
            break
        }
       
        requestWasCalled.toggle()
    }
    
}
