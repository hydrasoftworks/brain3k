//
//  Created by Kamil Powałowski on 07/07/2021.
//

import MGFlipView
import SwiftUI

struct JoinPage: View {
    @State private var flipped = false

    var body: some View {
        ZStack {
            Background()
            VStack {
                Spacer()
                FlipView(
                    frontView: { SignUpPage(flipped: $flipped) },
                    backView: { SignInPage(flipped: $flipped) },
                    flipped: $flipped,
                    flipAxis: .y
                )
                Spacer()
                MarkdownText(
                    text: L10n.JoinPage.Label.terms(
                        SettingsPage.termsAndConditions?.absoluteString ?? ""
                    )
                )
                .font(.footnote)
                .padding(.bottom)
            }
        }
        .onAppear(dispatch: AccountAction.generateNonce())
    }
}
