//
//  RecipeeApp.swift
//  Recipee
//
//  Created by Khan Winter on 9/28/21.
//

import SwiftUI

@main
struct RecipeeApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    init() {
        PersistenceController.shared.fetchAllSavedRecipes()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                PersistenceController.shared.fetchAllSavedRecipes()
            case .inactive:
                PersistenceController.shared.save()
            case .background:
                PersistenceController.shared.save()
            @unknown default:
                break
            }
        }
    }
}
