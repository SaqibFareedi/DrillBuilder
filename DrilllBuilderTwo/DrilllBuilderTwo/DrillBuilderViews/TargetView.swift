//
//  TargetView.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/16/24.
//

import SwiftUI
struct TargetView: View {
    @Binding var target: Target // Binding to allow updates
    @State private var currentMagnification: CGFloat = 1.0
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        let dotSize = target.configuration.size * currentMagnification

        switch target.configuration.shape {
        case .circle:
            Circle()
                .fill(target.configuration.color.color) // Use .color to convert ColorData to Color
                .frame(width: dotSize, height: dotSize)
                .gesture(combinedGesture)
        case .square:
            Rectangle()
                .fill(target.configuration.color.color) // Use .color to convert ColorData to Color
                .frame(width: dotSize, height: dotSize)
                .gesture(combinedGesture)
        case .triangle:
            Triangle()
                .fill(target.configuration.color.color) // Use .color to convert ColorData to Color
                .frame(width: dotSize, height: dotSize)
                .gesture(combinedGesture)
        }
    }

    // Combine DragGesture and MagnificationGesture
    private var combinedGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                dragOffset = value.translation
                finalizeDrag()
            }
            .simultaneously(
                with: MagnificationGesture()
                    .onChanged { value in
                        currentMagnification = value
                    }
                    .onEnded { _ in
                        finalizeSize()
                    }
            )
    }

    // Finalize the drag update when the gesture ends
    private func finalizeDrag() {
        target.point.x += dragOffset.width
        target.point.y += dragOffset.height
        dragOffset = .zero
    }

    // Finalize the size update when the gesture ends
    private func finalizeSize() {
        let newSize = target.configuration.size * currentMagnification
        target.configuration.size = max(20, min(newSize, 150)) // Clamp size between 20 and 150
        currentMagnification = 1.0
    }
}
