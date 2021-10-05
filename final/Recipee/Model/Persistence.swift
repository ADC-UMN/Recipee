//
//  Persistence.swift
//  Recipee
//
//  Created by Khan Winter on 9/28/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let newItem = Recipe(context: viewContext)
            newItem.createdAt = Date()
            newItem.id = "recipe\(i)"
            newItem.name = "Recipe \(i)"
            newItem.notes = "Really long text here that hopefully should wrap around multiple lines of stuff so yeah English is a pretry great language and what do you think of the American Economy?"
            
            for l in 0..<10 {
                let ingredient = Ingredient(context: viewContext)
                
                ingredient.name = ["Salt", "Pepper", "Beef", "Pork", "Lettuce", "Basil", "Parmesean", "Cheese", "BBQ Sauce", "Frozen Fruit", "Yogurt", "Sugar", "Brown Sugar", "Beans", "Ketchup", "Mustard"].randomElement()
                
                ingredient.amount = Int16.random(in: 1...16)
                ingredient.amount_measure = ["Cups", "Lbs", "Tbps", "Tsp", "Oz"].randomElement()
                
                newItem.addToIngredients(ingredient)
            }
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    static var testRecipe: Recipe = {
        let r = Recipe(context: Self.preview.container.viewContext)
        r.id = "recipe1"
        r.name = "Test Recipe"
        r.notes = "Really long text here that hopefully should wrap around multiple lines of stuff so yeah English is a pretry great language and what do you think of the American Economy?"
        r.createdAt = Date()
        
        for l in 0..<10 {
            let ingredient = Ingredient(context: Self.preview.container.viewContext)
            
            ingredient.name = ["Salt", "Pepper", "Beef", "Pork", "Lettuce", "Basil", "Parmesean", "Cheese", "BBQ Sauce", "Frozen Fruit", "Yogurt", "Sugar", "Brown Sugar", "Beans", "Ketchup", "Mustard"].randomElement()
            
            ingredient.amount = Int16.random(in: 1...16)
            ingredient.amount_measure = ["Cups", "Lbs", "Tbps", "Tsp", "Oz"].randomElement()
            
            r.addToIngredients(ingredient)
        }
        
        return r
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Recipee")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
