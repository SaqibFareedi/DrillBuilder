//
//  DrillStore.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/18/24.
//

import SwiftUI
class DrillStore: ObservableObject {
    @Published var drills: [Drill] = [] // List of all drills

    func addDrill(_ drill: Drill) {
        drills.append(drill)
        print("Drill added: \(drill.name)")
    }

    func updateDrill(_ updatedDrill: Drill) {
        if let index = drills.firstIndex(where: { $0.name == updatedDrill.name }) {
            drills[index] = updatedDrill
        }
    }
}
