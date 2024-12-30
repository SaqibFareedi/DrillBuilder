//
//  PatternPopupView.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/30/24.
//
import SwiftUI
struct PatternPopupView: View {
    @Binding var targets: [Target]
    @Binding var patterns: [Pattern]
    @Binding var selectedSequence: [Target]
    @Binding var newPatternName: String
    @Binding var repeatCount: Int

    var body: some View {
        VStack {
            Text("Create a New Pattern")
                .font(.headline)
                .padding()

            TextField("Pattern Name", text: $newPatternName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Text("Select Sequence")
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
                                .background(selectedSequence.contains(where: { $0.id == target.id }) ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()

            HStack {
                Text("Repeat Count: \(repeatCount)")
                Stepper("", value: $repeatCount, in: 1...100)
            }
            .padding()

            Button("Create Pattern") {
                createPattern()
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
        if let index = selectedSequence.firstIndex(where: { $0.id == target.id }) {
            selectedSequence.remove(at: index)
        } else {
            selectedSequence.append(target)
        }
    }

    private func createPattern() {
        guard !newPatternName.isEmpty, !selectedSequence.isEmpty else { return }
        let newPattern = Pattern(name: newPatternName, sequence: selectedSequence, repeatCount: repeatCount)
        patterns.append(newPattern)
        selectedSequence.removeAll()
        newPatternName = ""
        repeatCount = 1
    }
}
