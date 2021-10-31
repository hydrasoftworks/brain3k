//
//  Created by Kamil Powałowski on 29/10/2021.
//

import SwiftUI

struct URLTextField: View {
    @Binding var text: String

    var body: some View {
        TextField(L10n.AddMemoryPage.TextField.placeholder, text: $text)
            .styleTextField()
            .disableAutocorrection(true)
    }
}
