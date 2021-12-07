//
//  RecipeCell.swift
//  Recipee
//
//  Created by Khan Winter on 11/30/21.
//

import SwiftUI

struct RecipeCell: View {
    let recipe: Recipe
    
    var body: some View {
        ZStack(alignment: .leading) {
            if recipe.image != nil {
                GeometryReader { reader in
                    Image(uiImage: recipe.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: reader.size.width, height: reader.size.height)
                }
            } else {
                Rectangle()
                    .fill(Color.orange)
            }
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, 4)
                Text("\(recipe.ingredients.count) ingredients")
                    .font(.caption)
                Spacer()
            }
            .padding()
            .background(
                VisualEffectView(style: .light) 
            )
        }
    }
}

struct RecipeCell_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCell(recipe: PersistenceController.testRecipe)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
