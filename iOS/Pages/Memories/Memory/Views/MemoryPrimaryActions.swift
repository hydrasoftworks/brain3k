//
//  Created by Kamil Powałowski on 25/09/2021.
//

import SwiftUI

struct MemoryPrimaryActions: View {
    let url: URL

    @State private var isActivityViewPresented = false

    var body: some View {
        HStack(spacing: 16) {
            PrimaryButton(
                title: L10n.MemoryPage.Button.open,
                action: { UIApplication.shared.open(url) }
            )
            PrimaryIconButton(
                systemName: "square.and.arrow.up",
                label: L10n.MemoryPage.Button.share,
                action: { isActivityViewPresented = true }
            )
            .sheet(
                isPresented: $isActivityViewPresented,
                content: {
                    ActivityView(activityItems: [url])
                }
            )
        }
        .padding()
    }
}
