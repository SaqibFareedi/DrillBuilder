//
//  BatchPopupView.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/24/24.
//

import SwiftUI
struct BatchPopupView: View {
    @Binding var targets: [Target]
    @Binding var batches: [Batch]
    @Binding var selectedTargets: [Target]
    @Binding var newBatchName: String

    var body: some View {
        VStack {
            Text("Create a New Batch")
                .font(.headline)
                .padding()

            TextField("Batch Name", text: $newBatchName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Text("Select Targets")
                .font(.subheadline)
                .padding()

            ScrollView(.horizontal) {
                HStack {
                    ForEach(targets) { target in
                        Button(action: {
                            toggleTargetSelection(target)
                        }) {
                            Text(target.name)
                                .padding()
                                .background(selectedTargets.contains(where: { $0.id == target.id }) ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()

            Button("Create Batch") {
                createBatch()
            }
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()

            Spacer()
        }
        .padding()
    }

    private func toggleTargetSelection(_ target: Target) {
        if let index = selectedTargets.firstIndex(where: { $0.id == target.id }) {
            selectedTargets.remove(at: index)
        } else {
            selectedTargets.append(target)
        }
    }

    private func createBatch() {
        guard !newBatchName.isEmpty, !selectedTargets.isEmpty else { return }
        let newBatch = Batch(name: newBatchName, targets: selectedTargets)
        batches.append(newBatch)
        selectedTargets.removeAll()
        newBatchName = ""
    }
}
