//
//  DotsListPopup.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/20/24.
//
import SwiftUI
struct DotsListPopup: View {
    @Binding var targets: [Target]
    @Binding var zones: [Zone]
    @Binding var showingListPopup: Bool
    @Binding var showingSavePopup: Bool

    var body: some View {
        NavigationView {
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
                                get: {
                                    $target.configuration.color.wrappedValue.color
                                },
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
            }
            .padding()
            .navigationTitle("Dots")
            .navigationBarItems(
                leading: Button("Close") {
                    showingListPopup = false
                },
                trailing: Button("Save Drill") {
                    showingSavePopup = true
                }
            )
        }
        .sheet(isPresented: $showingSavePopup) {
            SaveDrillPopup(targets: targets, zones: zones, isPresented: $showingSavePopup)
        }
    }
}
