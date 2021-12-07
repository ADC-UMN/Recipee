//
//  Ingredient.swift
//  Recipee
//
//  Created by Khan Winter on 10/5/21.
//

import Foundation
import Combine

class Ingredient: ObservableObject, Codable, Identifiable {
    init(name: String, amount: Int, amountType: AmountType) {
        self.name = name
        self.amount = amount
        self.amountType = amountType
    }
    
    var id: UUID = UUID()
    var name: String
    var amount: Int
    var amountType: AmountType
}
