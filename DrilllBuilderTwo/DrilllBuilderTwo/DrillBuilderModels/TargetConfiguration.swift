//
//  TargetType.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/11/24.
//
import SwiftUI
struct TargetConfiguration: Codable {
    var shape: ShapeType = .circle
    var color: ColorData
    var size: CGFloat 

    enum CodingKeys: String, CodingKey {
        case shape, color, size
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(shape, forKey: .shape)
        try container.encode(color, forKey: .color)
        // Convert CGFloat to Double
        try container.encode(Double(size), forKey: .size)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        shape = try container.decode(ShapeType.self, forKey: .shape)
        color = try container.decode(ColorData.self, forKey: .color)
        // Decode Double and convert to CGFloat
        let doubleSize = try container.decode(Double.self, forKey: .size)
        size = CGFloat(doubleSize)
    }

    init(shape: ShapeType = .circle, color: ColorData = ColorData(color: .blue), size: CGFloat = 80) {
        self.shape = shape
        self.color = color
        self.size = size
    }
}
