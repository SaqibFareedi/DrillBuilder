//
//  Drill.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/18/24.
//

import SwiftUI
struct Drill: Identifiable, Codable{
    let id: UUID
    var name: String
    var targets: [Target]
    var zones: [Zone]

    init(name: String, targets: [Target], zones: [Zone]) {
        self.id = UUID()
        self.name = name
        self.targets = targets
        self.zones = zones
    }
}
