//
//  RecipeeApp.swift
//  Recipee
//
//  Created by Khan Winter on 9/28/21.
//

import SwiftUI

@main
struct RecipeeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
