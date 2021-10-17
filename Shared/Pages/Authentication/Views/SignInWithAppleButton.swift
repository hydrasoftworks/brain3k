//
//  Created by Kamil Powałowski on 07/07/2021.
//

import AuthenticationServices
import SwiftDux
import SwiftUI

struct AppSignInWithAppleButton: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    func map(state: AppState) -> ViewModel? {
        ViewModel(nonce: state.accountState.sha256Nonce)
    }

    func body(props viewModel: ViewModel) -> some View {
        SignInWithAppleButton(
            .continue,
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
                request.nonce = viewModel.nonce
            },
            onCompletion: { result in
                switch result {
                case let .success(authorization):
                    dispatch.send(AccountAction.signIn(authorization))
                case let .failure(error):
                    dispatch.send(
                        MessageAction.show(
                            .error(L10n.SignInWithAppleButton.error(error.localizedDescription))
                        )
                    )
                }
            }
        )
        .frame(height: 56)
    }

    struct ViewModel: Equatable {
        let nonce: String?
    }
}
