//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftDux
import SwiftUI

struct UnverifiedEmailPage: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    func map(state: AppState) -> ViewModel? {
        ViewModel(email: state.accountState.account?.email)
    }

    func body(props viewModel: ViewModel) -> some View {
        ZStack {
            Background()
            VStack(spacing: 16) {
                Text("Email address verification needed")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.brand)
                Text("Go to your \(viewModel.email ?? "") inbox and confirm message from Brain3k. After that, press button below.")
                    .font(.body)
                emailVerifiedButton
                Text("Didn't received verification email?")
                    .font(.body)
                sendVerificationEmailButton
                Text("or")
                    .font(.body)
                signOutButton
            }
            .multilineTextAlignment(.center)
            .padding()
            .materialBackground()
            .padding()
            .onAppear(dispatch: AccountAction.sendVerificationEmail())
        }
    }

    private var emailVerifiedButton: some View {
        PrimaryButton(title: "Email verified") {
            dispatch.send(AccountAction.refresh())
        }
    }

    private var sendVerificationEmailButton: some View {
        SecondaryButton(title: "Send verification email") {
            dispatch.send(AccountAction.sendVerificationEmail())
        }
    }

    private var signOutButton: some View {
        SecondaryButton(title: "Sign out") {
            dispatch.send(AccountAction.signOut())
        }
    }

    struct ViewModel: Equatable {
        let email: String?
    }
}

struct UnverifiedEmailPage_Previews: PreviewProvider {
    static var previews: some View {
        UnverifiedEmailPage()
    }
}
