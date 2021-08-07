//
//  Created by Kamil Powałowski on 04/08/2021.
//

import IrregularGradient
import SwiftUI

struct ProcessingCell: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            IrregularGradient(
                colors: colors,
                backgroundColor: Color.brand,
                shouldAnimate: .constant(true)
            )
            PlaceholderView(title: L10n.MemoryCell.ProcessingCell.title)
                .foregroundColor(foregroundColor)
                .tint(tintColor)
        }
    }

    private var colors: [Color] {
        if colorScheme == .dark {
            return [
                Color(red: 0.239, green: 0.306, blue: 0.506),
                Color(red: 0.341, green: 0.325, blue: 0.788),
                Color(red: 0.431, green: 0.498, blue: 0.953),
            ]
        }
        return [
            Color(red: 0.086, green: 0.851, blue: 0.89),
            Color(red: 0.188, green: 0.78, blue: 0.925),
            Color(red: 0.275, green: 0.682, blue: 0.969),
        ]
    }

    private var foregroundColor: Color {
        colorScheme == .dark ? .black : .white
    }

    private var tintColor: Color {
        foregroundColor.opacity(0.8)
    }
}

struct ProcessingCell_Previews: PreviewProvider {
    static var previews: some View {
        ProcessingCell()
    }
}
