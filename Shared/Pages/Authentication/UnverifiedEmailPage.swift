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
                Text(L10n.UnverifiedEmailPage.title)
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.brand)
                Text(L10n.UnverifiedEmailPage.description1(viewModel.email ?? "", L10n.appName))
                    .font(.body)
                emailVerifiedButton
                Text(L10n.UnverifiedEmailPage.description2)
                    .font(.body)
                sendVerificationEmailButton
                Text(L10n.UnverifiedEmailPage.description3)
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
        PrimaryButton(title: L10n.UnverifiedEmailPage.Button.verified) {
            dispatch.send(AccountAction.refresh())
        }
    }

    private var sendVerificationEmailButton: some View {
        SecondaryButton(title: L10n.UnverifiedEmailPage.Button.send) {
            dispatch.send(AccountAction.sendVerificationEmail())
        }
    }

    private var signOutButton: some View {
        SecondaryButton(title: L10n.UnverifiedEmailPage.Button.signOut) {
            dispatch.send(AccountAction.signOut())
        }
    }

    struct ViewModel: Equatable {
        let email: String?
    }
}
