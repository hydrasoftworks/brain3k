//
//  Created by Kamil Powałowski on 19/07/2021.
//

import SwiftUI

extension Color {
    static let brand = Asset.brandColor.swiftUIColor
    static let brandText = Asset.brandTextColor.swiftUIColor

    static func gradient(_ colorScheme: ColorScheme) -> [Color] {
        if colorScheme == .dark {
            return [
                Color(red: 0.239, green: 0.306, blue: 0.506),
                Color(red: 0.341, green: 0.325, blue: 0.788),
                Color(red: 0.431, green: 0.498, blue: 0.953),
                brand,
            ]
        }
        return [
            Color(red: 0.086, green: 0.851, blue: 0.89),
            Color(red: 0.188, green: 0.78, blue: 0.925),
            Color(red: 0.275, green: 0.682, blue: 0.969),
            brand,
        ]
    }
}
