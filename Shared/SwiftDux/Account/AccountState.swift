//
//  Created by Kamil Powałowski on 29/06/2021.
//

import Foundation

struct AccountState: StateType {
    let status: AccountStatus

    var user: User? {
        switch status {
        case let .authenticated(user),
             let .unverifiedEmail(user): return user
        case .unauthenticated,
             .undetermined: return nil
        }
    }

    init(status: AccountStatus = .undetermined) {
        self.status = status
    }

    func copyWith(
        status: AccountStatus? = nil
    ) -> AccountState {
        AccountState(
            status: status ?? self.status
        )
    }
}
