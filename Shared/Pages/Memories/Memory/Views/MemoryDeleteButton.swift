//
//  Created by Kamil Powałowski on 20/11/2021.
//

import SwiftUI

struct MemoryDeleteButton: View {
    let action: () -> Void
    var body: some View {
        Button(
            role: .destructive,
            action: action,
            label: {
                Label(
                    L10n.MemoryPage.Button.delete,
                    systemImage: "trash"
                )
            }
        )
    }
}
