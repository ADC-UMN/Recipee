//
//  Recipe.swift
//  Recipee
//
//  Created by Khan Winter on 10/5/21.
//

import Foundation
import Combine
import UIKit

class Recipe: ObservableObject, Codable, Identifiable, Equatable {
    init(id: String = UUID().uuidString, createdAt: Date = Date(), name: String, notes: String, ingredients: [Ingredient]) {
        self.id = id
        self.createdAt = createdAt
        self.name = name
        self.notes = notes
        self.ingredients = ingredients
    }
    
    var id: String
    var createdAt: Date
    
    @Published var name: String
    @Published var notes: String
    
    @Published var ingredients: [Ingredient]
    
    // MARK: - Codable Conformance
    
    enum CodingKeys: CodingKey {
        case id, createdAt, name, notes, ingredients
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(name, forKey: .name)
        try container.encode(notes, forKey: .notes)
        try container.encode(ingredients, forKey: .ingredients)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        name = try container.decode(String.self, forKey: .name)
        notes = try container.decode(String.self, forKey: .notes)
        ingredients = try container.decode([Ingredient].self, forKey: .ingredients)
    }
    
    static func ==(lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Recipe {
    
    /// The URL of the image file, if it exists
    /// this property is computed, so it will be initialized the first time it is accessed.
    var imageURL: URL {
        get {
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(id).png")
        }
    }
    
    var image: UIImage? {
        get {
            if id == "recipe1" || id == "recipe2" || id == "recipe3" || id == "recipe0" {
                return UIImage(named: id)
            }
            
            return UIImage(contentsOfFile: imageURL.path)
        }
        set {
            if let data = newValue?.pngData() {
                let fm = FileManager.default
                let baseURL = fm.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let imageURL = baseURL.appendingPathComponent("\(id).png")
                
                do {
                    try data.write(to: imageURL)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    /// Deletes the image file for this recipe, throws an error if it happens
    ///
    /// This method will return immediately if the image file does not exist, and will
    /// not throw an error for that reason.
    func deleteImage() throws {
        // Check if the image file exists
        if FileManager.default.fileExists(atPath: imageURL.path) {
            try FileManager.default.removeItem(at: imageURL)
        }
    }
    
}
