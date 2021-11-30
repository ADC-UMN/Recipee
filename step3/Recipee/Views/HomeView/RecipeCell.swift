//
//  RecipeCell.swift
//  Recipee
//
//  Created by Khan Winter on 9/28/21.
//

import SwiftUI

struct RecipeCell: View {
    var recipe: Recipe
    
    var body: some View {
        Text(recipe.name)
    }
}

struct RecipeCell_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCell(recipe: PersistenceController.testRecipe)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
