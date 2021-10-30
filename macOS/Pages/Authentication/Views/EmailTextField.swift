//
//  Created by Kamil Powałowski on 29/10/2021.
//

import SwiftUI

struct EmailTextField: View {
    @Binding var email: String

    var body: some View {
        TextField(L10n.EmailTextField.placeholder, text: $email)
            .styleTextField()
            .textContentType(.username)
            .disableAutocorrection(true)
            .multilineTextAlignment(.leading)
    }
}
