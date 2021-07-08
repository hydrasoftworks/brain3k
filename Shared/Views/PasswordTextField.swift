//
//  Created by Kamil Powałowski on 05/07/2021.
//

import SwiftUI

struct PasswordTextField: View {
    let title: String
    let textContentType: UITextContentType
    @Binding var password: String

    var body: some View {
        SecureField(title, text: $password)
            .styleTextField()
            .textContentType(textContentType)
    }
}
