//
//  DrillDetailView.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/18/24.
//


import SwiftUI

struct DrillDetailView: View {
    @EnvironmentObject var drillStore: DrillStore
    @Environment(\.presentationMode) var presentationMode

    @State var drill: Drill
    @State private var targets: [Target]
    @State private var zones: [Zone]
    @State private var selectedViews: [Target] = []
    @State private var savedDrills: [Drill] = [] // Saved drills state
    @State private var showingDrillList = false // Drill list view toggle

    init(drill: Drill) {
        self.drill = drill
        _targets = State(initialValue: drill.targets)
        _zones = State(initialValue: drill.zones)
    }

    var body: some View {
        VStack {
            HStack {
                TextField("Drill Name", text: $drill.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Update") {
                    drill.targets = targets
                    drill.zones = zones
                    drillStore.updateDrill(drill)
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }

            HStack {
                CanvasView(targets: $targets, selectedViews: $selectedViews, zones: $zones)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                if !targets.isEmpty {
                    DotsListView(
                        targets: $targets,
                        zones: $zones,
                        savedDrills: $savedDrills,
                        showingDrillList: $showingDrillList
                    )
                    .frame(width: 300)
                    .padding()
                }
            }

            Button(action: {
                showingDrillList = true
            }) {
                Text("View Saved Drills")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .sheet(isPresented: $showingDrillList) {
            DrillListView(savedDrills: savedDrills, loadDrill: loadDrill)
        }
        .onAppear {
            fetchSavedDrills()
        }
    }

    private func loadDrill(_ drill: Drill) {
        targets = drill.targets
        zones = drill.zones
    }

    private func fetchSavedDrills() {
        savedDrills = drillStore.drills // Ensure this matches the data source
    }
}
