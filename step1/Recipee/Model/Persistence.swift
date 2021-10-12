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
    
    func getSavedRecipe(for id: String) -> Recipe? {
        return nil
    }
}
