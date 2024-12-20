//
//  Zone.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/18/24.
//

import SwiftUI
struct Zone: Identifiable, Codable {
    let id: UUID = UUID()
    var origin: CGPoint
    var size: CGSize
}
