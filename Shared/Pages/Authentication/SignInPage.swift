//
//  Created by Kamil Powałowski on 27/06/2021.
//

import AuthenticationServices
import SwiftDux
import SwiftUI

struct SignInPage: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    let flip: () -> Void

    @SwiftUI.State private var email: String = ""
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
                .multilineTextAlignment(.center)
            AppSignInWithAppleButton()
            Text("or sign in using email and password")
                .font(.body)
                .multilineTextAlignment(.center)
            EmailTextField(email: $email)
            PasswordTextField(
                title: "password",
                textContentType: .password,
                password: $password
            )
            signInButton
            signUpLink
        }
        .padding()
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(
                cornerRadius: 16,
                style: .continuous
            )
        )
        .padding()
    }

    private var signInButton: some View {
        Button(action: {
            dispatch.send(
                AccountAction.signIn(
                    withEmail: email,
                    andPassword: password
                )
            )
        }) {
            Text("Sign in with e-mail")
                .font(.title2)
                .foregroundColor(.white)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 56)
        .background(Color("PrimaryColor"))
        .cornerRadius(8)
    }

    private var signUpLink: some View {
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
