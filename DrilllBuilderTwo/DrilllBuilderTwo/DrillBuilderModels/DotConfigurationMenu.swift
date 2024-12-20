//
//  DotConfigurationMenu.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/12/24.
//

import SwiftUI
struct DotConfigurationMenu: View {
    @Binding var configuration: TargetConfiguration
    var onClose: () -> Void
    var body: some View {
        VStack {
            Text("Dot Configuration")
                .font(.headline)

            // Shape Picker
            Picker("Shape", selection: $configuration.shape) {
                Text("Circle").tag(ShapeType.circle)
                Text("Square").tag(ShapeType.square)
                Text("Triangle").tag(ShapeType.triangle)
            }
            .pickerStyle(SegmentedPickerStyle())

            // Color Picker
            ColorPicker("Color", selection: .init(
                get: { configuration.color.color },
                set: { newColor in
                    configuration.color = ColorData(color: newColor)
                }
            ))
            .labelsHidden()

            // Size Slider
            Slider(value: .init(
                get: { Double(configuration.size) },
                set: { newSize in
                    configuration.size = CGFloat(newSize)
                }
            ), in: 20...200, step: 1) {
                Text("Size")
            }

            Button("Close") {
                onClose()
            }
        }
        .padding()
    }
}
