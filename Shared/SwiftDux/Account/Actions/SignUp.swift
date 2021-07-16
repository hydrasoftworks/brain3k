//
//  Created by Kamil Powałowski on 16/07/2021.
//

import Combine
import ParseSwift
import SwiftDux

extension AccountAction {
    static func signUp(
        withEmail email: String,
        andPassword password: String,
        _ accountService: AccountService = AccountService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            accountService.signUp(email: email, password: password)
                .flatMap { user -> AnyPublisher<User, ParseError> in
                    var user = user
                    user.email = email
                    return accountService.save(user)
                        .eraseToAnyPublisher()
                }
                .map { user in AccountAction.setStatus(.unverifiedEmail(user)) }
                .catch { Just(MessageAction.set(.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }
}
