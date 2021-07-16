//
//  Created by Kamil Powałowski on 16/07/2021.
//

import Combine
import SwiftDux

extension AccountAction {
    static func sendVerificationEmail(
        _ accountService: AccountService = AccountService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { store -> AnyPublisher<Action, Never> in
            guard let email = store.state.accountState.user?.email else {
                return .empty
            }

            return accountService.sendVerificationEmail(email)
                .mapToEmptyResult(ofType: Action.self)
                .catch { Just(MessageAction.set(.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }
}
