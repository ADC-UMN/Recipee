//
//  AddIngredientList.swift
//  Recipee
//
//  Created by Khan Winter on 10/5/21.
//

import SwiftUI

struct AddIngredientsList: View {
    @Binding var ingredients: [Ingredient]
    var addIngredient: (() -> Void)? = nil
    var removeIngredient: ((Int) -> Void)? = nil
    
    var body: some View {
        VStack {
            // ===============
            // Ingredient list
            // ===============
            ForEach($ingredients) { ingredient in
                HStack {
                    TextField("Ingredient Name", text: ingredient.name)
                    
                    Spacer()
                    
                    TextField("Amount", value: ingredient.amount, formatter: NumberFormatter())
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                    Picker(ingredient.amountType.wrappedValue.rawValue, selection: ingredient.amountType) {
                        ForEach(AmountType.allCases, id: \.self.rawValue) { amountType in
                            Text(amountType.rawValue)
                        }
                    }
                }
                .contextMenu {
                    Button {
//                        removeIngredient?(index)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }

                }
            }
            Divider()
            // ===============
            // Add Ingredient Button
            // ===============
            Button {
                addIngredient?()
            } label: {
                HStack {
                    Spacer()
                    Label("Add Ingedient", systemImage: "plus")
                    Spacer()
                }
            }
        }
    }
}

struct AddIngredientsList_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredientsList(ingredients: Binding.constant(PersistenceController.testRecipe.ingredients))
            .padding(.horizontal)
    }
}
