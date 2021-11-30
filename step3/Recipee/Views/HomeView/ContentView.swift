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
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(persistenceController: PersistenceController.preview)
    }
}
