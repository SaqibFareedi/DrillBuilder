//
//  SaveDrillPopup.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/20/24.
//

import SwiftUI

import SwiftUI

struct SaveDrillPopup: View {
    @EnvironmentObject var drillStore: DrillStore
    @State private var drillName: String = ""
    var targets: [Target]
    var zones: [Zone]
    @Binding var isPresented: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Save Drill")
                .font(.headline)

            TextField("Enter Drill Name", text: $drillName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("Save") {
                    saveDrill()
                    isPresented = false
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        .frame(maxWidth: 400)
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding()
    }

    private func saveDrill() {
        guard !drillName.isEmpty else {
            print("Drill name cannot be empty!")
            return
        }
        let drill = Drill(name: drillName, targets: targets, zones: zones)
        drillStore.addDrill(drill)
        print("Drill '\(drillName)' saved successfully!")
    }
}
