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
    @State var showAddView: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                Spacer()
                LazyVStack(spacing: 10) {
                    ForEach(persistenceController.recipes) { recipe in
                        // ===============
                        // Recipe Cells
                        // ===============
                        NavigationLink {
                            RecipeDetailView(recipe: recipe)
                                .ignoresSafeArea(.all, edges: .top)
                        } label: {
                            RecipeCell(recipe: recipe)
                                .foregroundColor(Color(UIColor.label))
                        }
                        .contextMenu {
                            Button {
                                persistenceController.deleteRecipe(recipe)
                            } label: {
                                Label("Delete \(recipe.name)", systemImage: "trash")
                            }
                        }
                    }
                }
                Spacer(minLength: 48)
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .padding(.horizontal)
            .navigationTitle("Recipee")
            .toolbar {
                // ===============
                // Top Buttons
                // ===============
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showAddView.toggle()
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddView) {
                // Update the view for any new data after the add view is dismissed
                persistenceController.objectWillChange.send()
            } content: {
                AddRecipeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
