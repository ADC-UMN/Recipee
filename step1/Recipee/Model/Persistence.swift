//
//  Persistence.swift
//  Recipee
//
//  Created by Khan Winter on 9/28/21.
//

import Combine
import CoreData

// MARK: - Persistence Controller

class PersistenceController: ObservableObject {
    
    // MARK: - Properties
    
    static let shared = PersistenceController()
    
    /// Observable array of saved recipes
    @Published var recipes: [Recipe] = []
    
    /// The file URL to save the recipes to
    private let saveDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("recipes.data")
    
    // MARK: - Init
    
    init() {
        
    }
    
    // MARK: - Methods
    
    /// Fetches all recipes from the `saveDirectory` file, and fills the `recipe` property with them.
    func fetchAllSavedRecipes() {
        
    }
    
    /// Save the `recipes` array to the `saveDirectory` file.
    func save() {
    }
    
    /// Deletes the given recipe and saves the recipes to file.
    /// - Parameter r: The recipe to delete.
    func deleteRecipe(_ r: Recipe) {
        
    }
    
    /// Gets a recipe if it exists and returns it.
    /// - Parameter id: The ID of the recipe
    /// - Returns: The recipe, if it exists, otherwise `nil`.
    func getSavedRecipe(for id: String) -> Recipe? {
        
    }
}


// MARK: - Sample Data
// Ignore the code below this line, we'll explain it later when we start building the UI.

extension PersistenceController {
    
    /// For use in `SwiftUI` previews, filled with some data.
    static var preview: PersistenceController = {
        var controller = PersistenceController()
        
        // Make 10 recipes with 10 ingredients
        for i in 0..<10 {
            let recipe = Recipe(id: "recipe\(i)", name: "Recipe \(i)", notes: "Really long text here that hopefully should wrap around multiple lines of stuff so yeah English is a pretry great language and what do you think of the American Economy?", ingredients: [])
            
            for l in 0..<10 {
                let ingredient = Ingredient(name: randomName(),
                                            amount: Int.random(in: 1...16),
                                            amountType: AmountType.allCases.randomElement()!)
                
                recipe.ingredients.append(ingredient)
            }
            
            controller.recipes.append(recipe)
        }
        
        return controller
    }()
    
    /// A test recipe for use in `SwiftUI` previews and tests
    static var testRecipe: Recipe = {
        let r = Recipe(id: "recipe1", name: "Test Recipe", notes: "Really long text here that hopefully should wrap around multiple lines of stuff so yeah English is a pretry great language and what do you think of the American Economy?", ingredients: [])
        
        // Add 10 ingredients to the recipe
        for l in 0..<10 {
            let ingredient = Ingredient(name: randomName(),
                                        amount: Int.random(in: 1...16),
                                        amountType:  AmountType.allCases.randomElement()!)
            
            r.ingredients.append(ingredient)
        }
        
        return r
    }()
    
    /// Gets a random ingredient name for use in the `preview` and `testRecipe` testing objects.
    /// - Returns: Returns a random name from the preset list of names.
    private static func randomName() -> String {
        ["Salt", "Pepper", "Beef", "Pork", "Lettuce", "Basil", "Parmesean", "Cheese", "BBQ Sauce", "Frozen Fruit", "Yogurt", "Sugar", "Brown Sugar", "Beans", "Ketchup", "Mustard"].randomElement()!
    }
}
