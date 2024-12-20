//
//  TargetListView.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/11/24.
//

import SwiftUI

struct TargetListView: View {
    @Binding var targets: [Target]

    var body: some View {
        List {
            ForEach(targets) { target in
                Text("Target - x: \(Int(target.point.x)), y: \(Int(target.point.y))")
            }
            .onDelete(perform: deleteTarget) // Enable swipe-to-delete
        }
    }

    private func deleteTarget(at offsets: IndexSet) {
        // Remove the target(s) from the list
        targets.remove(atOffsets: offsets)
    }
}
