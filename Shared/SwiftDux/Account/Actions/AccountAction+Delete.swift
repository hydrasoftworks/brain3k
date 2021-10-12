//
//  Created by Kamil Powałowski on 12/10/2021.
//

import Combine
import Foundation
import SwiftDux

extension AccountAction {
    static func delete(
        _ accountService: AccountService = AccountService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            accountService.deleteAccount()
                .map { _ in AccountAction.setStatus(.unauthenticated) }
                .catch { Just(MessageAction.show(.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }
}
