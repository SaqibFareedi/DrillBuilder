//
//  ConfigurationView.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/11/24.
//

import SwiftUI

struct ConfigurationPanelView: View {
    @Binding var configuration: TargetConfiguration
    var onChange: ((TargetConfiguration) -> Void)?

    var body: some View {
        VStack {
            Text("Configure Dot")
                .font(.headline)

            // Shape Selection
            HStack {
                Text("Shape:")
                Picker("Shape", selection: $configuration.shape) {
                    Text("Circle").tag(ShapeType.circle)
                    Text("Square").tag(ShapeType.square)
                    Text("Triangle").tag(ShapeType.triangle)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding()

            // Notify when configuration changes
            Button(action: {
                onChange?(configuration) // Trigger the onChange callback
            }) {
                Text("Update Configuration")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top)
        }
        .frame(width: 250)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}


