//
//  Created by Kamil Powałowski on 27/06/2021.
//

import AuthenticationServices
import SwiftDux
import SwiftUI
import ValidatedPropertyKit

struct SignInPage: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    let flip: () -> Void

    @Validated(!.isEmpty && .isEmail)
    private var email: String = ""
    @SwiftUI.State private var password: String = ""

    func map(state _: AppState) -> ViewModel? {
        ViewModel()
    }

    func body(props _: ViewModel) -> some View {
        VStack(spacing: 16) {
            Text("Welcome back")
                .font(.title)
                .bold()
                .foregroundStyle(Color("PrimaryColor"))
            Text("Start using your new digital brain.")
                .font(.body)
            AppSignInWithAppleButton()
            Text("or sign in using email and password")
                .font(.body)
            EmailTextField(email: $email)
            PasswordTextField(
                title: "password",
                textContentType: .password,
                password: $password
            )
            signInButton
            goToSignUpButton
        }
        .multilineTextAlignment(.center)
        .padding()
        .materialBackground()
        .padding()
    }

    private var signInButton: some View {
        PrimaryButton(title: "Sign in with e-mail") {
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
        Button("You are new? Create an account.", action: flip)
            .foregroundColor(Color("PrimaryColor"))
    }

    struct ViewModel: Equatable {}
}

struct SignInPage_Previews: PreviewProvider {
    private static var store: Store<AppState> {
        Store(
            state: AppState(),
            reducer: AppReducer()
        )
    }

    static var previews: some View {
        SignInPage(flip: {})
            .provideStore(store)
    }
}
