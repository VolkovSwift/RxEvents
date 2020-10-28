//
//  RxEventsUITests.swift
//  RxEventsUITests
//
//  Created by user on 10/24/20.
//

import XCTest

class RxEventsUITests: XCTestCase {

    func testTabBarTap() throws {
        let app = XCUIApplication()
        app.launch()

        let tabBarsQuery = app.tabBars
                tabBarsQuery.buttons["Favorite"].tap()
                tabBarsQuery.buttons["Events"].tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
