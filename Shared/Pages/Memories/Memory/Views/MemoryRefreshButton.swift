//
//  Created by Kamil Powałowski on 20/11/2021.
//

import SwiftUI

struct MemoryRefreshButton: View {
    let action: () -> Void

    var body: some View {
        Button(
            action: action,
            label: {
                Label(
                    L10n.MemoryPage.Button.refresh,
                    systemImage: "arrow.triangle.2.circlepath"
                )
            }
        )
    }
}
