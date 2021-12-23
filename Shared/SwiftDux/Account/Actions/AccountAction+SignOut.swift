//
//  Created by Kamil Powałowski on 16/07/2021.
//

import Combine
import SwiftDux

extension AccountAction {
    static func signOut(
        _ accountService: AccountService = AccountService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            accountService.signOut()
                .map { AccountAction.setStatus(.unauthenticated) }
                .catch { _ in Just(AccountAction.setStatus(.unauthenticated)) }
                .append(AccountAction.setUser(nil))
                .append(SubscriptionAction.setIdentity())
                .eraseToAnyPublisher()
        }
    }
}
