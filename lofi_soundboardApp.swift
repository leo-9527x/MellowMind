//
//  lofi_soundboardApp.swift
//  lofi-soundboard
//
//  Created by Wahid Kamruddin on 7/27/23.
//

import SwiftUI

@main
struct lofi_soundboardApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
