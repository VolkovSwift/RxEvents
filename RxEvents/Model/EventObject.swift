//
//  EventObject.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import UIKit

struct EventObject {
    let event: EventItem
    var isFavorite: Bool
    var image: UIImage {
        if isFavorite {
            return Images.filledStar.image
        } else {
            return Images.emptyStar.image
        }
    }
}

extension EventObject: Comparable {
    static func < (lhs: EventObject, rhs: EventObject) -> Bool {
        return lhs.event < rhs.event
    }
}
