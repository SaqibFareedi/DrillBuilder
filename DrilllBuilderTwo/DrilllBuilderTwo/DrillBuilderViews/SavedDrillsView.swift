//
//  SavedDrillsView.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/23/24.
//

import SwiftUI

struct SavedDrillsView: View {
    @Binding var savedDrills: [Drill] // List of saved drills
    var onLoadDrill: (Drill) -> Void // Callback for loading a drill
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                if savedDrills.isEmpty {
                    Text("No saved drills available.")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(savedDrills) { drill in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(drill.name)
                                        .font(.headline)
                                    Text("\(drill.targets.count) targets, \(drill.zones.count) zones")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Button(action: {
                                    onLoadDrill(drill)
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Text("Load")
                                        .padding(6)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                savedDrills.remove(at: index)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Saved Drills")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}
