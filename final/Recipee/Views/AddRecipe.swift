//
//  AddRecipe.swift
//  Recipee
//
//  Created by Khan Winter on 9/28/21.
//

import SwiftUI

struct AddRecipe: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    var recipe: Recipe!
    
    @State var name: String = ""
    @State var notes: String = ""
    @State var ingredients: [Ingredient] = []
    
    init(_ recipe: Recipe? = nil) {
        if recipe != nil {
            self.recipe = recipe!
            name = recipe?.name ?? ""
            notes = recipe?.notes ?? ""
            ingredients = (recipe?.ingredients?.array as? [Ingredient]) ?? []
        } else {
            self.recipe = Recipe(context: viewContext)
        }
    }
    
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
                        TextField("Recipe Name", text: $name)
                            .font(.largeTitle.bold())
                        Spacer()
                        Button {
                            print("saving!")
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
                        
                        TextEditor(text: $notes)
                            .opacity(notes.isEmpty ? 0.5 : 1)
                    }
                    ForEach(ingredients.indices) { index in
                        HStack {
                            TextField("Ingredient Name", text: $ingredients[index].name ?? "No Name")
                            Spacer()
                            TextField("", value: $ingredients[index].amount, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                            Menu {
                                Button {
                                    print("Bruh")
                                } label: {
                                    Text("Bruh")
                                }
                            } label: {
                                Text(ingredients[index].amount_measure ?? "Cups")
                            }

                        }
                    }
                    Divider()
                    Button {
                        addIngredient()
                    } label: {
                        HStack {
                            Spacer()
                            Label("Add Ingedient", systemImage: "plus")
                            Spacer()
                        }
                    }

                }
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
        }.ignoresSafeArea()
    }
    
    func addIngredient() {
        let ingredient = Ingredient(context: viewContext)
        ingredient.name = "New Ingredient"
        recipe.addToIngredients(ingredient)
        ingredients.append(ingredient)
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
}

struct AddRecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipe(PersistenceController.testRecipe)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
