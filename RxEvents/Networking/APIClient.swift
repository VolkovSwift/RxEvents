//
//  APIClient.swift
//  RxEvents
//
//  Created by user on 10/24/20.
//

import Foundation


import RxCocoa
import RxSwift

final class APIClient {
    // MARK: - Private properties

    private let networkManager: NetworkManager
    private let url = "http://api.eventful.com/json/events/search?app_key=CKKnt488bNT6HK2c&keywords=books&location=San+Diego&date=Future"

    // MARK: - Init

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    // MARK: - Methods

    func getEventsEntity() -> Observable<EventsEntity> {
        return networkManager.request(url: url)
    }
}
