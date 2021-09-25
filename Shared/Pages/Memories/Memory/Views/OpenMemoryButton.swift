//
//  Created by Kamil Powałowski on 25/09/2021.
//

import SwiftUI

struct OpenMemoryButton: View {
    let url: URL

    var body: some View {
        PrimaryButton(
            title: L10n.MemoryPage.openMemory,
            action: { UIApplication.shared.open(url) }
        )
        .padding()
    }
}

struct OpenURLButton_Previews: PreviewProvider {
    static var previews: some View {
        if let url = URL(string: "https://example.com") {
            OpenMemoryButton(url: url)
        }
    }
}
