//
//  Created by Kamil Powałowski on 27/06/2021.
//

import AuthenticationServices
import SwiftDux
import SwiftUI
import ValidatedPropertyKit

struct SignInPage: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    @Binding var flipped: Bool

    @Validated(!.isEmpty && .isEmail)
    private var email: String = ""
    @SwiftUI.State private var password: String = ""

    func map(state _: AppState) -> ViewModel? {
        ViewModel()
    }

    func body(props _: ViewModel) -> some View {
        SignPageBase(
            firstSection: {
                Text(L10n.SignInPage.title)
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.brand)
                Text(L10n.SignInPage.description1)
                    .font(.body)
                AppSignInWithAppleButton()
            },
            secondSection: {
                Text(L10n.SignInPage.description2)
                    .font(.body)
                EmailTextField(email: $email)
                PasswordTextField(
                    title: L10n.PasswordTextField.passwordPlaceholder,
                    textContentType: .password,
                    password: $password
                )
                signInButton
                goToSignUpButton
            }
        )
    }

    private var signInButton: some View {
        PrimaryButton(title: L10n.SignInPage.Button.signIn) {
            dispatch.send(
                AccountAction.signIn(
                    withEmail: email,
                    andPassword: password
                )
            )
        }
        .validated(_email)
    }

    private var goToSignUpButton: some View {
        SecondaryButton(
            title: L10n.SignInPage.Button.signUp,
            action: { flipped.toggle() }
        )
    }

    struct ViewModel: Equatable {}
}
