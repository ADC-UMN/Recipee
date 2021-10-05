//
//  ContentView.swift
//  Recipee
//
//  Created by Khan Winter on 9/28/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.createdAt, ascending: true)],
        animation: .default)
    private var recipes: FetchedResults<Recipe>
    
    @State var showAddView: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                Spacer()
                LazyVStack(spacing: 10) {
                    ForEach(recipes) { recipe in
                        NavigationLink {
                            RecipeDetail(recipe: recipe)
                        } label: {
                            RecipeCell(recipe: recipe)
                                .foregroundColor(Color(UIColor.label))
                        }

                    }
                }
                Spacer(minLength: 48)
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .padding(.horizontal)
            .navigationTitle("Recipee")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showAddView.toggle()
                    } label: {
                        Label("Add", systemImage: "plus")
                    }

                }
            }
            .sheet(isPresented: $showAddView) {
                print("Dismissed!")
            } content: {
                AddRecipe()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
