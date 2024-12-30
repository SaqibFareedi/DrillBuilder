//
//  DotsListView.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/12/24.
import SwiftUI
import SwiftUI

struct DotsListView: View {
    @Binding var targets: [Target]
    @Binding var zones: [Zone]
    @Binding var savedDrills: [Drill]
    @Binding var showingDrillList: Bool
    @EnvironmentObject var drillStore: DrillStore
    @State private var showingSavePopup = false
    @State private var showingSavedDrillsPopup = false
    @State private var offset: CGFloat = 0 // Track horizontal swipe offset

    // Batch management
    @State private var batches: [Batch] = [] // List of batches
    @State private var newBatchName: String = "" // Input for batch name
    @State private var selectedTargets: [Target] = [] // Targets selected for a batch
    @State private var showingBatchPopup = false // Toggle for batch creation popup

    // Pattern management
    @State private var patterns: [Pattern] = [] // List of patterns
    @State private var newPatternName: String = "" // Input for pattern name
    @State private var selectedSequence: [Target] = [] // Targets selected for the pattern
    @State private var repeatCount: Int = 1 // Repeat count for patterns
    @State private var showingPatternPopup = false // Toggle for pattern creation popup

    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("List of Dots")
                    .font(.headline)
                    .padding(.bottom, 5)

                // Display batches, patterns, and ungrouped targets
                List {
                    ForEach(batches) { batch in
                        Section(header: Text("Batch: \(batch.name)")) {
                            ForEach(batch.targets) { target in
                                HStack {
                                    Text(target.name)
                                        .font(.subheadline)

                                    Spacer()

                                    Text("Position: (\(Int(target.point.x)), \(Int(target.point.y)))")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteBatch)

                    ForEach(patterns) { pattern in
                        Section(header: Text("Pattern: \(pattern.name)")) {
                            ForEach(pattern.sequence) { target in
                                HStack {
                                    Text(target.name)
                                        .font(.subheadline)

                                    Spacer()

                                    Text("Position: (\(Int(target.point.x)), \(Int(target.point.y)))")
                                        .foregroundColor(.gray)
                                }
                            }
                            Text("Repeat Count: \(pattern.repeatCount)")
                                .font(.footnote)
                                .foregroundColor(.blue)
                        }
                    }
                    .onDelete(perform: deletePattern)

                    Section(header: Text("Ungrouped Targets")) {
                        ForEach(targets.filter { target in
                            !batches.contains { $0.targets.contains(where: { $0.id == target.id }) }
                                && !patterns.contains { $0.sequence.contains(where: { $0.id == target.id }) }
                        }) { target in
                            HStack {
                                Text(target.name)
                                    .font(.subheadline)

                                Spacer()

                                Text("Position: (\(Int(target.point.x)), \(Int(target.point.y)))")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }

                // Batch creation button
                Button(action: {
                    showingBatchPopup = true
                }) {
                    Text("Create Batch")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)

                // Pattern creation button
                Button(action: {
                    showingPatternPopup = true
                }) {
                    Text("Create Pattern")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)

                // Save Drill button
                Button(action: {
                    showingSavePopup = true
                }) {
                    Text("Save Drill")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)

                // View Saved Drills button
                Button(action: {
                    showingSavedDrillsPopup = true
                }) {
                    Text("View Saved Drills")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
            }
            .padding()
            .sheet(isPresented: $showingBatchPopup) {
                BatchPopupView(
                    targets: $targets,
                    batches: $batches,
                    selectedTargets: $selectedTargets,
                    newBatchName: $newBatchName
                )
            }
            .sheet(isPresented: $showingPatternPopup) {
                PatternPopupView(
                    targets: $targets,
                    patterns: $patterns,
                    selectedSequence: $selectedSequence,
                    newPatternName: $newPatternName,
                    repeatCount: $repeatCount
                )
            }
            .sheet(isPresented: $showingSavePopup) {
                SaveDrillPopup(targets: targets, zones: zones, isPresented: $showingSavePopup)
                    .environmentObject(drillStore)
            }
            .sheet(isPresented: $showingSavedDrillsPopup) {
                SavedDrillsView(
                    savedDrills: $savedDrills,
                    onLoadDrill: loadDrill
                )
            }
        }
    }

    private func deleteBatch(at offsets: IndexSet) {
        batches.remove(atOffsets: offsets)
    }

    private func deletePattern(at offsets: IndexSet) {
        patterns.remove(atOffsets: offsets)
    }

    private func loadDrill(_ drill: Drill) {
        targets = drill.targets
        zones = drill.zones
        showingSavedDrillsPopup = false // Dismiss popup after loading
    }
}
