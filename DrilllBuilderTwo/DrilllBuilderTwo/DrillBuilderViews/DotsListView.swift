//
//  DotsListView.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/12/24.
//
import SwiftUI
import SwiftUI

struct DotsListView: View {
    @Binding var targets: [Target]
    @Binding var zones: [Zone]
    @Binding var savedDrills: [Drill]
    @Binding var showingDrillList: Bool
    @EnvironmentObject var drillStore: DrillStore

    @State private var showingListPopup = false // Toggle for list popup
    @State private var showingSavePopup = false // Toggle for save drill popup
    @State private var drillNameInput = ""

    var body: some View {
        VStack {
            HStack {
                // Button to show the list of dots
                Button(action: {
                    showingListPopup = true // Show the list popup
                }) {
                    Image(systemName: "list.bullet") // List icon
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .sheet(isPresented: $showingListPopup) {
                    DotsListPopup(
                        targets: $targets,
                        zones: $zones,
                        showingListPopup: $showingListPopup,
                        showingSavePopup: $showingSavePopup
                    )
                }

                Spacer()

                // Save Drill Button
                Button(action: {
                    showingSavePopup = true // Show save drill popup
                }) {
                    Text("Save Drill")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showingSavePopup) {
                    SaveDrillPopup(
                        targets: targets,
                        zones: zones,
                        isPresented: $showingSavePopup
                    )
                    .environmentObject(drillStore) // Pass the drill store
                }
            }
            .padding()
        }
    }
}
