//
//  Batch.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/23/24.
//

import SwiftUI

import SwiftUI

import SwiftUI

struct Batch: Identifiable, Codable {
    let id: UUID = UUID()
    var name: String
    var targets: [Target]
}
