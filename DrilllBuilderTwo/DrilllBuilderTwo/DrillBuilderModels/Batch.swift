//
//  Batch.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/23/24.
//

import SwiftUI

import SwiftUI

struct Batch: Identifiable {
    let id = UUID() // Unique identifier
    var label: String // Name of the batch
    var targets: [Target] // Targets included in the batch
    var repeatCount: Int // Number of times to repeat this batch
}
