//
//  Created by Kamil Powałowski on 15/07/2021.
//

import SwiftDux

extension AccountAction {
    static func checkAccountStatus(
        _ accountService: AccountService = AccountService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { store in
            let action: Action
            if let user = accountService.getCurrentUser() {
                action = accountAction(for: user)
            } else {
                action = AccountAction.setStatus(.unauthenticated)
            }
            store.send(action)
        }
    }
}
