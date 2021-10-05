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
        ZStack(alignment: .leading) {
            if let image = recipe.image {
                GeometryReader { reader in
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: reader.size.width, height: reader.size.height)
                    
                }
            } else {
                Rectangle()
                    .fill(
                        LinearGradient(colors: [.orange.opacity(0.6), .orange],
                                       startPoint: .top,
                                       endPoint: .bottomTrailing)
                    )
            }
            
            VStack(alignment: .leading) {
                Text(recipe.name ?? "NO NAME FOUND")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, 4)
                Text("\(recipe.ingredients?.count ?? 0) Ingredients")
                    .font(.caption)
                Spacer()
            }
            .padding()
            .background(
                VisualEffectView(style: .light)
                    .cornerRadius(20, corners: [.topRight, .bottomRight])
            )
        }.cornerRadius(15)
    }
}

struct RecipeCell_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCell(recipe: PersistenceController.testRecipe)
            .previewLayout(.fixed(width: 300, height: 100))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
