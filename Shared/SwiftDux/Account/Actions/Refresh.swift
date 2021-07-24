//
//  Created by Kamil Powałowski on 16/07/2021.
//

import Combine
import SwiftDux

extension AccountAction {
    static func refresh(
        _ accountService: AccountService = AccountService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { store -> AnyPublisher<Action, Never> in
            guard store.state.accountState.account != nil else {
                return .empty
            }

            return accountService.refresh()
                .map(accountAction(for:))
                .catch { Just(MessageAction.set(.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }
}
