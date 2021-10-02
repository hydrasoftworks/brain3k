//
//  Created by Kamil Powałowski on 16/07/2021.
//

import Combine
import SwiftDux

extension AccountAction {
    static func signUp(
        withEmail email: String,
        andPassword password: String,
        _ accountService: AccountService = AccountService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            accountService.signUp(email: email, password: password)
                .map { account in AccountAction.setStatus(.unverifiedEmail(account)) }
                .catch { Just(MessageAction.show(.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }
}
