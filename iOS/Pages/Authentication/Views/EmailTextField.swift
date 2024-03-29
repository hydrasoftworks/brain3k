//
//  Created by Kamil Powałowski on 05/07/2021.
//

import SwiftUI

struct EmailTextField: View {
    @Binding var email: String

    var body: some View {
        TextField(L10n.EmailTextField.placeholder, text: $email)
            .styleTextField()
            .textContentType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .multilineTextAlignment(.leading)
    }
}
