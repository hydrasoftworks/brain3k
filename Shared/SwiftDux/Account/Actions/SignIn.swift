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
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                return .empty
            }

            return accountService.login(credential: credential)
                .map { user in AccountAction.setStatus(.authenticated(user)) }
                .catch { Just(MessageAction.set(.error($0.message))) }
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
                .catch { Just(MessageAction.set(.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }
}
