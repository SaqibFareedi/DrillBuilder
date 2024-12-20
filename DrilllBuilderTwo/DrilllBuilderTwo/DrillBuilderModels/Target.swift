//
//  SwiftUIView.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/11/24.
//
import SwiftUI
struct Target: Identifiable, Codable {
    var id: UUID = UUID() // Unique identifier for the target
    var point: CGPoint // Position of the dot
    var configuration: TargetConfiguration // Configuration for the dot
    var name: String = "Dot" // Default name for the dot
}
