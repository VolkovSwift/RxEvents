//
//  Event.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import Foundation
import UIKit

struct EventItem: Codable, Hashable {
    var id: String
    var title: String
    var startTime: String
    var url: String
}

struct EventList: Codable {
    let event: [EventItem]
}

struct EventsEntity: Codable {
    let events: EventList
}

extension EventItem: Equatable {
    static func == (lhs: EventItem, rhs: EventItem) -> Bool {
        return lhs.id == rhs.id
    }
}

extension EventItem: Comparable {
    static func < (lhs: EventItem, rhs: EventItem) -> Bool {
        return lhs.id < rhs.id
    }
}
