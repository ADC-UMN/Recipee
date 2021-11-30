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

    @Published var recipes: [Recipe] = []
    
    /// The file URL to save the recipes to
    private let saveDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("recipes.data")
    
    // MARK: - Init
    
    init() {
        fetchAllSavedRecipes()
    }
    
    // MARK: - Methods
    
    /// Fetches all recipes from the `saveDirectory` file, and fills the `recipe` property with them.
    func fetchAllSavedRecipes() {
        // Check first if the save file exists
        // If it doesn't make a new, empty one.
        if !FileManager.default.fileExists(atPath: saveDirectory.path) {
            save()
        }
        
        do {
            // Get the data from the save file
            let data = try Data(contentsOf: saveDirectory)
            let decoder = JSONDecoder()
            // Decode the data into the recipe array
            recipes = try decoder.decode([Recipe].self, from: data)
        } catch {
            // If something went wrong getting the data or decoding it,
            // we'll get it here and print it.
            print("Something went wrong fetching the saved recipes:", error)
        }
    }
    
    /// Save the `recipes` array to the `saveDirectory` file.
    func save() {
        do {
            let encoder = JSONEncoder()
            // Encode the recipes to JSON data
            let data = try encoder.encode(recipes)
            // Save that data to disk
            try data.write(to: saveDirectory)
        } catch {
            // If something went wrong encoding the recipes to data,
            // or if something went wrong saving the data to disk we'll have that error here.
            print("Something went wrong saving the recipes:", error)
        }
    }
    
    /// Deletes the given recipe and saves the recipes to file.
    /// - Parameter r: The recipe to delete.
    func deleteRecipe(_ r: Recipe) {
        // Find the index of the recipe in the `recipes` array.
        if let index = recipes.firstIndex(where: { recipe in
            recipe.id == r.id
        }) {
            // If we find it, remove it
            recipes.remove(at: index)
        }
        
        // Try to delete the recipe's image to save storage space
        do {
            try r.deleteImage()
        } catch {
            print("Something went wrong deleting the recipe's image", error)
        }
        
        // Save the recipes to disk.
        save()
    }
    
    func getSavedRecipe(for id: String) -> Recipe? {
        if let index = recipes.firstIndex(where: { recipe in
            recipe.id == id
        }) {
            return recipes[index]
        } else {
            return nil
        }
    }
}

// MARK: - Sample Data

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
