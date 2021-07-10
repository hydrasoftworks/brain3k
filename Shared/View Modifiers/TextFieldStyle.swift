//
//  Created by Kamil Powałowski on 05/07/2021.
//

import SwiftUI

extension TextField {
    func styleTextField() -> some View {
        modifier(TextFieldStyle())
    }
}

extension SecureField {
    func styleTextField() -> some View {
        modifier(TextFieldStyle())
    }
}

private struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .frame(height: 56)
            .background(
                .thinMaterial,
                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
            )
    }
}
