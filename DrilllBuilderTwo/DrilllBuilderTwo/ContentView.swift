//
//  ContentView.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var drillStore = DrillStore()
    var body: some View {
        DrillBuilderView()
            .environmentObject(drillStore)
    }
    
}

#Preview {
    ContentView()
}
