//
//  Created by Kamil Powałowski on 25/09/2021.
//

import SwiftUI

struct OpenMemoryButton: View {
    let url: URL

    var body: some View {
        PrimaryButton(
            title: L10n.MemoryPage.openMemory,
            action: {
                #if os(iOS)
                    UIApplication.shared.open(url)
                #else
                    NSWorkspace.shared.open(url)
                #endif
            }
        )
        .padding()
    }
}
