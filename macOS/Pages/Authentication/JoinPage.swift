//
//  Created by Kamil Powałowski on 31/10/2021.
//

import SwiftUI

struct JoinPage: View {
    @State private var flipped = false

    var body: some View {
        ZStack {
            Background()
            VStack {
                if flipped {
                    SignInPage(flipped: $flipped)
                } else {
                    SignUpPage(flipped: $flipped)
                }
                MarkdownText(
                    text: L10n.JoinPage.Label.terms(
                        SettingsPage.termsAndConditions?.absoluteString ?? ""
                    )
                )
                .font(.footnote)
            }
        }
        .onAppear(dispatch: AccountAction.generateNonce())
    }
}
