//
//  Created by Kamil Powałowski on 05/07/2021.
//

import AuthenticationServices
import SwiftDux
import SwiftUI
import ValidatedPropertyKit

struct SignUpPage: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    let flip: () -> Void

    @Validated(!.isEmpty && .isEmail)
    private var email: String = ""
    @Validated(.range(8...))
    private var password: String = ""

    func map(state _: AppState) -> ViewModel? {
        ViewModel()
    }

    func body(props _: ViewModel) -> some View {
        SignPageBase(
            firstSection: {
                Text(L10n.SignUpPage.title)
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.brand)
                Text(L10n.SignUpPage.description1)
                    .font(.body)
                AppSignInWithAppleButton()
            },
            secondSection: {
                Text(L10n.SignUpPage.description2)
                    .font(.body)
                EmailTextField(email: $email)
                PasswordTextField(
                    title: L10n.PasswordTextField.newPasswordPlaceholder,
                    textContentType: .newPassword,
                    password: $password
                )
                signUpButton
                goToSignInButton
            }
        )
    }

    private var signUpButton: some View {
        PrimaryButton(title: L10n.SignUpPage.Button.signUp) {
            dispatch.send(
                AccountAction.signUp(
                    withEmail: email,
                    andPassword: password
                )
            )
        }
        .validated(_email, _password)
    }

    private var goToSignInButton: some View {
        SecondaryButton(
            title: L10n.SignUpPage.Button.signIn,
            action: flip
        )
    }

    struct ViewModel: Equatable {}
}
