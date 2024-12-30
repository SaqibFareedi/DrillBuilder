//
//  Pattern.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/30/24.
//
import SwiftUI
struct Pattern: Identifiable, Codable {
    let id: UUID = UUID()
    var name: String
    var sequence: [Target] // The sequence of targets in the pattern
    var repeatCount: Int // Number of times to repeat the pattern
}
