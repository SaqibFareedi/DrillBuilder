//
//  UI screen.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/30/24.
//

import SwiftUI
import SwiftUI

extension UIScreen {
    static var scaleFactor: CGFloat {
        // Define a base width for iPhone
        let baseWidth: CGFloat = 375 // Reference screen width (e.g., iPhone 11)
        return UIScreen.main.bounds.width / baseWidth
    }
}

