//
//  Created by Kamil Powałowski on 22/07/2021.
//

import SwiftUI

struct PlaceholderView: View {
    let title: String
    let color: Color

    init(
        title: String = L10n.General.loading,
        color: Color
    ) {
        self.title = title
        self.color = color
    }

    var body: some View {
        ProgressView(title)
            .expanded()
            .foregroundColor(color)
            .tint(color.opacity(0.8))
    }
}
