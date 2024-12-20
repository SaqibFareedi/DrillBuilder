//
//  CanvasView.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/11/24.
//


import SwiftUI

struct CanvasView: View {
    @Binding var targets: [Target]
    @Binding var selectedViews: [Target]
    @Binding var zones: [Zone]

    @State private var showingMenu = false
    @State private var selectedTarget: Target?
    @State private var menuPosition: CGPoint = .zero

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background for canvas interactions
                Rectangle()
                    .fill(Color.clear)
                    .contentShape(Rectangle())
                    .onTapGesture { location in
                        addTarget(at: location)
                        showingMenu = false // Hide menu when tapping on canvas
                    }

                // Add Path for connecting lines
                if targets.count > 1 {
                    Path { path in
                        for index in 0..<targets.count - 1 {
                            let start = targets[index].point
                            let end = targets[index + 1].point
                            path.move(to: start)
                            path.addLine(to: end)
                        }
                    }
                    .stroke(Color.red, lineWidth: 2)
                }

                // Draw and handle interactions with targets
                ForEach($targets) { $target in
                    TargetView(target: $target)
                        .position(target.point)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    updateTargetPosition(target, to: value.location)
                                }
                        )
                        .onTapGesture {
                            showConfigurationMenu(for: target, in: geometry)
                        }
                        .onLongPressGesture {
                            removeTarget(target)
                        }
                }
            }
            // Use overlay to dynamically position the menu
            .overlay(
                Group {
                    if showingMenu, let target = selectedTarget {
                        DotConfigurationMenu(configuration: Binding(
                            get: { target.configuration },
                            set: { newConfig in
                                if let index = targets.firstIndex(where: { $0.id == target.id }) {
                                    targets[index].configuration = newConfig
                                }
                            }
                        )) {
                            showingMenu = false
                        }
                        .frame(width: 350)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .position(menuPosition) // Position the menu
                    }
                }
            )
        }
    }

    private func addTarget(at location: CGPoint) {
        let newTarget = Target(
            point: location,
            configuration: TargetConfiguration()
        )
        targets.append(newTarget)
    }

    private func updateTargetPosition(_ target: Target, to newPosition: CGPoint) {
        if let index = targets.firstIndex(where: { $0.id == target.id }) {
            targets[index].point = newPosition
        }
    }

    private func removeTarget(_ target: Target) {
        if let index = targets.firstIndex(where: { $0.id == target.id }) {
            targets.remove(at: index)
        }
    }

    private func showConfigurationMenu(for target: Target, in geometry: GeometryProxy) {
        selectedTarget = target
        menuPosition = CGPoint(
            x: target.point.x,
            y: target.point.y + 50 // Offset to position below the target
        )
        showingMenu = true
    }
}
