//
//  Created by Kamil Powałowski on 15/07/2021.
//

import AuthenticationServices
import Combine
import SwiftDux

extension AccountAction {
    static func signIn(
        _ authorization: ASAuthorization,
        _ accountService: AccountService = AccountService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { store -> AnyPublisher<Action, Never> in
            guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                return .empty
            }
            let nonce = store.state.accountState.nonce

            return accountService.login(credential: credential, nonce: nonce)
                .map { account in AccountAction.setStatus(.authenticated(account)) }
                .catch { Just(MessageAction.show(.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }

    static func signIn(
        withEmail email: String,
        andPassword password: String,
        _ accountService: AccountService = AccountService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            accountService.login(email: email, password: password)
                .map(accountAction(for:))
                .catch { Just(MessageAction.show(.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }
}
