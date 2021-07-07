//
//  Created by Kamil Powałowski on 07/07/2021.
//

import AuthenticationServices
import SwiftDux
import SwiftUI

struct AppSignInWithAppleButton: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    func map(state _: AppState) -> ViewModel? {
        ViewModel()
    }

    func body(props _: ViewModel) -> some View {
        SignInWithAppleButton(
            .continue,
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case let .success(authorization):
                    dispatch.send(AccountAction.signIn(authorization))
                case let .failure(error):
                    log.error("Authorization failed: " + error.localizedDescription)
                }
            }
        )
        .frame(height: 56)
    }

    struct ViewModel: Equatable {}
}

struct AppSignInWithAppleButton_Previews: PreviewProvider {
    static var previews: some View {
        AppSignInWithAppleButton()
    }
}
