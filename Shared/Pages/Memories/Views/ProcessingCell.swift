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
                colors: Color.gradient(colorScheme),
                backgroundColor: Color.brand,
                shouldAnimate: .constant(true)
            )
            PlaceholderView(title: L10n.MemoryCell.ProcessingCell.title)
                .foregroundColor(foregroundColor)
                .tint(tintColor)
        }
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
