//
//  Created by Kamil Powałowski on 21/11/2021.
//

import SwiftUI

extension View {
    func focusOnStart() -> some View {
        modifier(FocusOnStart())
    }
}

private struct FocusOnStart: ViewModifier {
    @FocusState private var isFocused: Bool

    func body(content: Content) -> some View {
        content
            .focused($isFocused)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isFocused = true
                }
            }
    }
}
