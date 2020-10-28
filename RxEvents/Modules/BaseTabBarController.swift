//
//  BaseTabBarController.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import UIKit

final class BaseTabBarController: UITabBarController {
    
    //MARK: - Private Properties
    
    private let container = DependencyContainer()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor.main
        viewControllers = [
            createEventsScreen(), createFavoriteScreen()
        ]
    }
    
    //MARK: - Private Methods

    private func createEventsScreen() -> UIViewController {
        let vc = container.makeEventsViewController()
        vc.tabBarItem = UITabBarItem(title: "Events", image: Images.events.image, tag: 0)
        return vc
    }

    private func createFavoriteScreen() -> UIViewController {
        let vc = container.makeFavoriteViewController()
        vc.tabBarItem = UITabBarItem(title: "Favorite", image: Images.favorite.image, tag: 1)
        return vc
    }
}
