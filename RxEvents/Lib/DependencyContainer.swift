//
//  DependencyContainer.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import Foundation

protocol ViewControllerFactory {
    func makeMainTabBarController() -> BaseTabBarController
    func makeEventsViewController() -> EventsViewController
    func makeFavoriteViewController() -> FavoriteViewController
}

protocol ViewModelFactory {
    func makeEventsViewModel() -> EventsViewModel
    func makeFavoriteViewModel() -> FavoriteViewModel
}

protocol HelpersFactory {
    func makeFavoriteProvider() -> FavoriteProviderProtocol
    func makeNetworkProvider() -> NetworkProvider
}

class DependencyContainer {
    
    private lazy var eventsViewModel = EventsViewModel(networkProvider: networkProvider, favoriteProvider: favoriteProvider)
    private lazy var favoriteViewModel = FavoriteViewModel(favoriteProvider: favoriteProvider)
    private lazy var favoriteProvider = FavoriteProvider()
    private lazy var networkProvider = NetworkProvider()
}


//MARK: - ViewControllerFactory

extension DependencyContainer: ViewControllerFactory {
    
    func makeMainTabBarController() -> BaseTabBarController {
        return BaseTabBarController()
    }
    
    func makeEventsViewController() -> EventsViewController {
        return EventsViewController(factory: self)
    }
    
    func makeFavoriteViewController() -> FavoriteViewController {
        return FavoriteViewController(factory: self)
    }
    
}

//MARK: - ViewModelFactory

extension DependencyContainer: ViewModelFactory {
    func makeEventsViewModel() -> EventsViewModel {
        return eventsViewModel
    }
    
    func makeFavoriteViewModel() -> FavoriteViewModel {
        return favoriteViewModel
    }
}

//MARK: - HelpersFactory

extension DependencyContainer: HelpersFactory {
    func makeFavoriteProvider() -> FavoriteProviderProtocol {
        return favoriteProvider
    }
            
    func makeNetworkProvider() -> NetworkProvider {
        return networkProvider
    }
}

