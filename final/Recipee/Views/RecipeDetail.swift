//
//  RecipeDetail.swift
//  Recipee
//
//  Created by Khan Winter on 9/28/21.
//

import SwiftUI
import CoreData

struct RecipeDetail: View {
    var recipe: Recipe
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let image = recipe.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: nil, height: 150, alignment: .center)
                        .clipped()
                        .ignoresSafeArea()
                } else {
                    Spacer(minLength: 75)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(recipe.name ?? "NO NAME FOUND")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        Button {
                            print("Edit")
                        } label: {
                            Image(systemName: "pencil")
                                .foregroundColor(Color(UIColor.label))
                                .padding(8)
                                .background(Color(UIColor.lightGray).opacity(0.5))
                                .clipShape(Circle())
                        }
                        Button {
                            print("Close")
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "multiply")
                                .foregroundColor(Color(UIColor.label))
                                .padding(8)
                                .background(Color(UIColor.lightGray).opacity(0.5))
                                .clipShape(Circle())
                        }
                    }
                    Divider()
                    Text(recipe.notes ?? "No Notes")
                        .font((recipe.notes == nil || recipe.notes?.isEmpty ?? true) ? .footnote.italic() : .footnote)
                    Divider()
                    ForEach(recipe.ingredients!.array as! [Ingredient]) { ingredient in
                        HStack {
                            Text(ingredient.name ?? "No Name Found")
                            Spacer()
                            if ingredient.amount_measure != nil {
                                Text("\(ingredient.amount) \(ingredient.amount_measure!)")
                                    .font(.caption)
                            } else {
                                Text("x\(ingredient.amount)")
                                    .font(.caption)
                            }
                        }.padding(.vertical, 4)
                        Divider()
                            .padding(.leading)
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
        }.ignoresSafeArea()
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: PersistenceController.testRecipe)
    }
}
