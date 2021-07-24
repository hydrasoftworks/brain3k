//
//  Created by Kamil Powałowski on 29/06/2021.
//

import SwiftDux

enum AccountAction: Action, Equatable {
    case setStatus(AccountStatus)

    static func accountAction(for account: Account) -> AccountAction {
        if account.emailVerified {
            return AccountAction.setStatus(.authenticated(account))
        }
        return AccountAction.setStatus(.unverifiedEmail(account))
    }
}
