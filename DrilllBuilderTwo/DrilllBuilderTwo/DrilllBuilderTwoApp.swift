//
//  DrilllBuilderTwoApp.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/11/24.
//

import SwiftUI

@main
struct DrillBuilderTwoApp: App {
    @StateObject private var drillStore = DrillStore() // Initialize DrillStore

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(drillStore) // Provide DrillStore to all views
        }
    }
}
