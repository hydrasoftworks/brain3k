//
//  Created by Kamil Powałowski on 10/08/2021.
//

import SwiftUI

extension View {
    func expanded() -> some View {
        modifier(ExpandedFrame())
    }
}

private struct ExpandedFrame: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(
                minWidth: 0, maxWidth: .infinity,
                minHeight: 0, maxHeight: .infinity
            )
    }
}
