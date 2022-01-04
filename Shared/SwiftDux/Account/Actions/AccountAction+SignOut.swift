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
                .map { StoreAction.reset(state: AppState()) }
                .catch { _ in Just(StoreAction.reset(state: AppState())) }
                .append(SubscriptionAction.setIdentity())
                .eraseToAnyPublisher()
        }
    }
}
