//
//  Created by Kamil Powałowski on 05/07/2021.
//

import SwiftUI

struct PasswordTextField: View {
    @Binding var password: String
    let textContentType: UITextContentType

    var body: some View {
        SecureField("password", text: $password)
            .styleTextField()
            .textContentType(textContentType)
    }
}
