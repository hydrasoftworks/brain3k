//
//  Created by Kamil Powałowski on 05/07/2021.
//

import AuthenticationServices
import SwiftDux
import SwiftUI

struct SignUpPage: ConnectableView {
    @Environment(\.dismiss) var dismiss
    @Environment(\.actionDispatcher) private var dispatch

    let flip: () -> Void

    @SwiftUI.State private var email: String = ""
    @SwiftUI.State private var password: String = ""

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
                .multilineTextAlignment(.center)
            AppSignInWithAppleButton()
            Text("or sign up using email and password")
                .font(.body)
                .multilineTextAlignment(.center)
            EmailTextField(email: $email)
            PasswordTextField(
                password: $password,
                textContentType: .newPassword
            )
            signUpButton
            signInLink
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

    private var signUpButton: some View {
        Button(action: {
            dispatch.send(
                AccountAction.signUp(
                    withEmail: email,
                    andPassword: password
                )
            )
        }) {
            Text("Sign up with e-mail")
                .font(.title2)
                .foregroundColor(.white)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 56)
        .background(Color("PrimaryColor"))
        .cornerRadius(8)
    }

    private var signInLink: some View {
        Button("Alredy have an account? Sign in now.", action: flip)
            .foregroundColor(Color("PrimaryColor"))
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
