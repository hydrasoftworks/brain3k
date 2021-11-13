//
//  Created by Kamil Powałowski on 13/11/2021.
//

import SwiftUI

struct LimitExceededView: View {
    var body: some View {
        VStack(spacing: 16) {
            #if os(macOS)
                Text(L10n.AddMemoryPage.LimitExceeded.title)
                    .font(.title)
            #endif
            Text(L10n.AddMemoryPage.LimitExceeded.body)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            #if os(iOS)
                Spacer()
            #endif
        }
        .navigationTitle(L10n.AddMemoryPage.LimitExceeded.title)
    }
}
