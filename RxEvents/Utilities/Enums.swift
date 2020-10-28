//
//  Enums.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import Foundation
import UIKit

enum NetworkingError: String, Error {
    case incorrectURL = "Incorrect URL"
    case decodingError = "Decoding Error"
    case unableToComplete = "Unable To Complete"
    case invalidResponse = "Invalid Response"
    case invalidData = "Invalid Data"
}

enum URLPath: String {
    case base = "http://api.eventful.com/json/events/search?app_key=CKKnt488bNT6HK2c&keywords=books&location=San+Diego&date=Future"
}

enum Images: String {
    case events, favorite, emptyStar, filledStar
    
    var image: UIImage {
        return UIImage(named: "\(self.rawValue).png") ?? UIImage()
    }
}
