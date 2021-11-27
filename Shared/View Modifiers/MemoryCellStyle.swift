//
//  Created by Kamil Powałowski on 31/10/2021.
//

import SwiftUI

extension View {
    func memoryCellStyle() -> some View {
        modifier(MemoryCellStyle())
    }
}

private struct MemoryCellStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.plain)
            .expanded()
            .aspectRatio(1, contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
