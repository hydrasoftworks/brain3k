//
//  Created by Kamil Powałowski on 16/01/2022.
//

import SwiftUI

struct MemorySummaryView: View {
    let summary: String

    init(_ summary: String) {
        self.summary = summary.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(L10n.MemoryPage.Label.summary)
                .font(.caption)
            Text(summary)
                .textSelection(.enabled)
        }
        .font(.body)
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}
