//
//  ContentView.swift
//  Recipee
//
//  Created by Khan Winter on 9/28/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var persistenceController: PersistenceController = PersistenceController.shared

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(persistenceController.recipes) { recipe in
                        RecipeCell(recipe: recipe)
                            .cornerRadius(15)
                            .padding()
                            .clipped()
                    }
                }
            }.navigationTitle("Recipee")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(persistenceController: PersistenceController.preview)
    }
}
