//
//  Recipe.swift
//  Recipee
//
//  Created by Khan Winter on 10/5/21.
//

import Foundation

class Recipe {
    init(id: String = UUID().uuidString, createdAt: Date = Date(), name: String, notes: String, ingredients: [Ingredient]) {
        self.id = id
        self.createdAt = createdAt
        self.name = name
        self.notes = notes
        self.ingredients = ingredients
    }
    
    var id: String
    var createdAt: Date
    
    var name: String
    var notes: String
    
    var ingredients: [Ingredient]
}
