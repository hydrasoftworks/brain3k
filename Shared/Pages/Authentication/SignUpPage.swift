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
        VStack(spacing: 16) {
            Text("Create an account")
                .font(.title)
                .bold()
                .foregroundStyle(Color("PrimaryColor"))
            Text("Start using your new digital brain.")
                .font(.body)
            AppSignInWithAppleButton()
            Text("or sign up using email and password")
                .font(.body)
            EmailTextField(email: $email)
            PasswordTextField(
                title: "password (min. 8 characters)",
                textContentType: .newPassword,
                password: $password
            )
            signUpButton
            goToSignInButton
        }
        .multilineTextAlignment(.center)
        .padding()
        .materialBackground()
        .padding()
    }

    private var signUpButton: some View {
        PrimaryButton(title: "Sign up with e-mail") {
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
            title: "Already have an account? Sign in now.",
            action: flip
        )
    }

    struct ViewModel: Equatable {}
}

struct SignUpPage_Previews: PreviewProvider {
    private static var store: Store<AppState> {
        Store(
            state: AppState(),
            reducer: AppReducer()
        )
    }

    static var previews: some View {
        SignUpPage(flip: {})
            .provideStore(store)
    }
}
