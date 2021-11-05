//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftUI

extension View {
    func materialBackground() -> some View {
        modifier(MaterialBackground())
    }
}

private struct MaterialBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                .regularMaterial,
                in: RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
    }
}
