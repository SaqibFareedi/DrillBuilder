//
//  DotsListView.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/12/24.
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

    var body: some View {
        ZStack(alignment: .leading) {
            // Conditional Background Overlay
            if showingDrillList && offset == 0 {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            hideView()
                        }
                    }
            }

            // Main content
            VStack(alignment: .leading) {
                Text("List of Dots")
                    .font(.headline)
                    .padding(.bottom, 5)

                List {
                    ForEach($targets) { $target in
                        HStack {
                            TextField("Dot Name", text: $target.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(maxWidth: 100)

                            Spacer()

                            ColorPicker("", selection: Binding(
                                get: { $target.configuration.color.wrappedValue.color },
                                set: { newColor in
                                    $target.configuration.color.wrappedValue = ColorData(color: newColor)
                                }
                            ))
                            .labelsHidden()

                            Spacer()

                            Text("Position: (\(Int($target.point.x.wrappedValue)), \(Int($target.point.y.wrappedValue)))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                if let index = targets.firstIndex(where: { $0.id == $target.id.wrappedValue }) {
                                    targets.remove(at: index)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }

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
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 10)
            .offset(x: offset) // Apply swipe offset
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        // Update offset for both left and right swipes
                        offset = min(max(gesture.translation.width, 0), UIScreen.main.bounds.width)
                    }
                    .onEnded { gesture in
                        if gesture.translation.width > 100 {
                            // Swipe right to hide
                            withAnimation {
                                hideView()
                            }
                        } else if gesture.translation.width < -100 {
                            // Swipe left to show
                            withAnimation {
                                showView()
                            }
                        } else {
                            // Reset to current state
                            withAnimation {
                                offset = showingDrillList ? 0 : UIScreen.main.bounds.width
                            }
                        }
                    }
            )
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
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    // Detect swipe left outside to bring the view back
                    if !showingDrillList && gesture.translation.width < -100 {
                        withAnimation {
                            showView()
                        }
                    }
                }
        )
    }

    private func hideView() {
        offset = UIScreen.main.bounds.width // Move off-screen to the right
        showingDrillList = false // Update binding to hide the view
    }

    private func showView() {
        offset = 0 // Bring back to original position
        showingDrillList = true // Update binding to show the view
    }

    private func loadDrill(_ drill: Drill) {
        targets = drill.targets
        zones = drill.zones
        showingSavedDrillsPopup = false // Dismiss popup after loading
    }
} 
