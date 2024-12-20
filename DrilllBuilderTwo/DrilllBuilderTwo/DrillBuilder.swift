//
//  DrillBuilderApp.swift
//  DrillBuilder
//
//  Created by Saqib Fareedi on 12/10/24.
//

import SwiftUI

enum TargetType: String, Codable {
    case light, obstacle
}

enum ShapeType: Int, Codable {
    case circle = 0, square, triangle
}

struct DrillBuilderView: View {
    @State private var targets: [Target] = [] // Correct type for targets
    @State private var zones: [Zone] = [] // Correct type for zones
    @State private var savedDrills: [Drill] = [] // Correct type for saved drills
    @State private var showingDrillList = false // Control showing drill list

    var body: some View {
        VStack {
            HStack {
                CanvasView(
                    targets: $targets, // Pass correct binding
                    selectedViews: .constant([]), // Provide a constant empty array if not used
                    zones: $zones // Pass correct binding
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                if !targets.isEmpty {
                    DotsListView(
                        targets: $targets, // Pass correct binding
                        zones: $zones, // Pass correct binding
                        savedDrills: $savedDrills, // Pass correct binding
                        showingDrillList: $showingDrillList // Pass correct binding
                    )
                    .frame(width: 300)
                    .padding()
                }
            }
            .padding()
        }
        .sheet(isPresented: $showingDrillList) {
            DrillListView(savedDrills: savedDrills, loadDrill: loadDrill)
        }
    }

    private func loadDrill(_ drill: Drill) {
        targets = drill.targets
        zones = drill.zones
    }
}


struct ArrowViewDB: View {
    var start: CGPoint
    var end: CGPoint
    
    var body: some View {
        ArrowShape(start: start, end: end)
            .stroke(Color.red, lineWidth: 2)
            .frame(width: 200, height: 200)
    }
}

struct ArrowShape: Shape {
    var start: CGPoint
    var end: CGPoint
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: start)
        path.addLine(to: end)
        return path
    }
}




// Triangle Shape Definition
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}


struct AnyShape: Shape {
    private let path: (CGRect) -> Path

    init<S: Shape>(_ shape: S) {
        self.path = shape.path(in:)
    }

    func path(in rect: CGRect) -> Path {
        return path(rect)
    }
}

struct ColorData: Codable {
    var red: Double
    var green: Double
    var blue: Double
    var opacity: Double

    init(color: Color) {
        let uiColor = UIColor(color)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        self.red = Double(r)
        self.green = Double(g)
        self.blue = Double(b)
        self.opacity = Double(a)
    }

    var color: Color {
        Color(red: red, green: green, blue: blue, opacity: opacity)
    }
}



// MARK: - Codable CGPoint & CGSize
extension CGPoint: Codable {
    enum CodingKeys: String, CodingKey { case x, y }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Double(x), forKey: .x)
        try container.encode(Double(y), forKey: .y)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let xVal = try container.decode(Double.self, forKey: .x)
        let yVal = try container.decode(Double.self, forKey: .y)
        self.init(x: xVal, y: yVal)
    }
}

extension CGSize: Codable {
    enum CodingKeys: String, CodingKey { case width, height }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Double(width), forKey: .width)
        try container.encode(Double(height), forKey: .height)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let w = try container.decode(Double.self, forKey: .width)
        let h = try container.decode(Double.self, forKey: .height)
        self.init(width: w, height: h)
    }
}
