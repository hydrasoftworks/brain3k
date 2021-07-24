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
            if let account = accountService.getCurrentAccount() {
                action = accountAction(for: account)
            } else {
                action = AccountAction.setStatus(.unauthenticated)
            }
            store.send(action)
        }
    }
}
