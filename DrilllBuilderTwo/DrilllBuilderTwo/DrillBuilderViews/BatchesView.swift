//
//  BatchesView.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/23/24.
//

import SwiftUI

struct BatchesView: View {
    @Binding var targets: [Target]
    @State private var batches: [Batch] = []
    @State private var newBatchLabel: String = ""
    @State private var selectedTargets: [Target] = []
    @State private var repeatCount: Int = 1

    var body: some View {
        VStack {
            // Target Selection
            Text("Select Targets for Batch")
                .font(.headline)
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

            // Batch Configuration
            VStack(alignment: .leading) {
                TextField("Batch Label", text: $newBatchLabel)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                HStack {
                    Text("Repeat Count: \(repeatCount)")
                    Stepper("", value: $repeatCount, in: 1...10)
                        .labelsHidden()
                }
                .padding()
            }

            Button(action: addBatch) {
                Text("Add Batch")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Divider()

            // List of Batches
            List {
                ForEach(batches) { batch in
                    VStack(alignment: .leading) {
                        Text("\(batch.label) - Repeat \(batch.repeatCount)x")
                            .font(.headline)
                        Text("Targets: \(batch.targets.map { $0.name }.joined(separator: ", "))")
                            .font(.subheadline)
                    }
                }
                .onDelete(perform: deleteBatch)
            }

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

    private func addBatch() {
        guard !selectedTargets.isEmpty, !newBatchLabel.isEmpty else { return }

        let newBatch = Batch(label: newBatchLabel, targets: selectedTargets, repeatCount: repeatCount)
        batches.append(newBatch)
        selectedTargets.removeAll()
        newBatchLabel = ""
        repeatCount = 1
    }

    private func deleteBatch(at offsets: IndexSet) {
        batches.remove(atOffsets: offsets)
    }
}

