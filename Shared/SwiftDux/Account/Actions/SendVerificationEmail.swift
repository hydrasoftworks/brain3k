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
            guard store.state.accountState.account != nil else {
                return .empty
            }

            return accountService.sendVerificationEmail()
                .mapToEmptyResult(ofType: Action.self)
                .catch { Just(MessageAction.show(.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }
}
