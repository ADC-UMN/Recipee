//
//  RecipeDetail.swift
//  Recipee
//
//  Created by Khan Winter on 9/28/21.
//

import SwiftUI

struct RecipeDetailView: View {
    @State var recipe: Recipe
    
    @Environment(\.presentationMode) var presentationMode
    @State var isShowingEditView: Bool = false
    
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
                        Text(recipe.name)
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        Button {
                            isShowingEditView.toggle()
                        } label: {
                            Image(systemName: "pencil")
                                .foregroundColor(Color(UIColor.label))
                                .padding(8)
                                .background(Color(UIColor.lightGray).opacity(0.5))
                                .clipShape(Circle())
                        }
                        Button {
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
                    Text(recipe.notes)
                        .font((recipe.notes.isEmpty) ? .footnote.italic() : .footnote)
                    Divider()
                    ForEach(recipe.ingredients) { ingredient in
                        HStack {
                            Text(ingredient.name)
                            Spacer()
                            Text("\(ingredient.amount) \(ingredient.amountType.rawValue)")
                                .font(.caption)
                        }.padding(.vertical, 4)
                        Divider()
                            .padding(.leading)
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .sheet(isPresented: $isShowingEditView) {
                if PersistenceController.shared.getSavedRecipe(for: recipe.id) != nil {
                    recipe = PersistenceController.shared.getSavedRecipe(for: recipe.id)!
                }
                recipe.objectWillChange.send()
            } content: {
                AddRecipeView(recipe)
            }
        }
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: PersistenceController.testRecipe)
    }
}
