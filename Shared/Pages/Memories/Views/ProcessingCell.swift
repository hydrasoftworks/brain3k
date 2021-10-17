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
            PlaceholderView(title: L10n.General.processing)
                .foregroundColor(.white)
                .tint(.white.opacity(0.8))
        }
    }
}
