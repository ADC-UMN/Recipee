//
//  AddRecipe.swift
//  Recipee
//
//  Created by Khan Winter on 9/28/21.
//

import SwiftUI
import Combine

struct AddRecipeView: View {
    @Environment(\.presentationMode) var presentationMode
    
    private var isNewRecipe = false
    @ObservedObject var recipe: Recipe
    
    @State var showImagePicker: Bool = false
    
    /// Initialize the `AddRecipe` view
    /// - Parameter recipe: optional recipe object, if nil will create a new recipe when saved. If not nil it will update the recipe passed to it.
    init(_ recipe: Recipe? = nil) {
        if recipe != nil {
            isNewRecipe = false
            self.recipe = recipe!
        } else {
            isNewRecipe = true
            self.recipe = Recipe(name: "", notes: "", ingredients: [])
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // ===============
                // Image View
                // ===============
                if let image = recipe.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: nil, height: 150, alignment: .center)
                        .clipped()
                        .ignoresSafeArea()
                } else {
                    Label("Add Image", systemImage: "camera")
                        .frame(maxWidth: .infinity, minHeight: 75)
                        .background(Color.gray)
                        .onTapGesture {
                            showImagePicker.toggle()
                        }
                }
                
                // ===============
                // Name and Done Button
                // ===============
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        TextField("Recipe Name", text: $recipe.name)
                            .font(.largeTitle.bold())
                        Spacer()
                        Button {
                            // ===============
                            // Save the recipe
                            // ===============
                            // This is ~not~ a new recipe, so we find it in the shared persistence
                            // then update it with the new values
                            if isNewRecipe {
                                // This ~is~ a new recipe, insert the new recipe at the begining of the
                                // shared persistence array.
                                PersistenceController.shared.recipes.insert(recipe, at: 0)
                            } else {
                                // Find the index of the recipe in the saved list, and replace it with the new recipe
                                guard let index = PersistenceController.shared.recipes.firstIndex(of: recipe) else {
                                    return
                                }
                                PersistenceController.shared.recipes[index] = recipe
                            }
                            
                            // After we make our updates, we've gotta save the recipes
                            PersistenceController.shared.save()
                            
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Done")
                                .foregroundColor(Color(UIColor.white))
                                .padding(8)
                                .background(Color(UIColor.systemBlue))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }
                    Divider()
                    ZStack(alignment: .leading) {
                        Text("Notes")
                            .italic()
                            .foregroundColor(.secondary)
                            .padding(.leading, 4)
                        
                        TextEditor(text: $recipe.notes)
                            .opacity(recipe.notes.isEmpty ? 0.5 : 1)
                    }
                    Divider()
                }
                .padding(.horizontal)
                
                // ===============
                // Ingredients List
                // ===============
                AddIngredientsList(ingredients: $recipe.ingredients, addIngredient: {
                    addIngredient()
                }, removeIngredient: { index in
                    removeIngredient(index: index)
                })
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showImagePicker, onDismiss: nil) {
            ImagePicker(sourceType: .photoLibrary) { image in
                recipe.image = image
            }
        }
    }
    
    /// Adds an ingredient to the `ingredients` state variable
    func addIngredient() {
        recipe.ingredients.append(Ingredient(name: "New Ingredient", amount: 0, amountType: .cups))
    }
    
    func removeIngredient(index: Int) {
        recipe.ingredients.remove(at: index)
    }
}

struct AddRecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(PersistenceController.testRecipe)
    }
}
