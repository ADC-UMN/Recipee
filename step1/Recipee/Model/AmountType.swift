//
//  AmountType.swift
//  Recipee
//
//  Created by Khan Winter on 10/5/21.
//

import Foundation

enum AmountType: String, CaseIterable, Codable, Equatable {
    case cups = "Cups"
    case pints = "Pints"
    case quarts = "Quarts"
    case gallons = "Gallons"
    case pounds = "Lbs"
    case tableSpoons = "Tbps"
    case teaSpoons = "Tsp"
    case ounce = "Oz"
    case pinch = "Pinch"
    case dash = "Dash"
    case `none` = "None"
}
