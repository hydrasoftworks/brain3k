//
//  Created by Kamil Powałowski on 11/11/2021.
//

import Foundation

import Combine
import SwiftDux

extension AccountAction {
    static func watchUser(
        _ userService: UserService = UserService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { store -> AnyPublisher<Action, Never> in
            guard let account = store.state.accountState.account else {
                return .empty
            }

            return userService.watch(for: account.id)
                .map { AccountAction.setUser($0) }
                .catch { Just(MessageAction.show(.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }
}
