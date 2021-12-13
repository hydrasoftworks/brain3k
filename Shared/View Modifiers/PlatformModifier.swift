//
//  Created by Kamil Powałowski on 13/12/2021.
//

import SwiftUI

extension View {
    func iOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(iOS)
            return modifier(self)
        #else
            return self
        #endif
    }
}

extension View {
    func macOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(macOS)
            return modifier(self)
        #else
            return self
        #endif
    }
}
