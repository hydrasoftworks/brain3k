//
//  Created by Kamil Powałowski on 05/01/2022.
//

import SwiftUI

struct MemoryReportButton: View {
    let action: () -> Void

    var body: some View {
        Button(
            action: action,
            label: {
                Label(
                    L10n.MemoryPage.Button.report,
                    systemImage: "exclamationmark.bubble"
                )
            }
        )
    }
}
