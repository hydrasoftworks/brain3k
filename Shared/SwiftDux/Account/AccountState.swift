//
//  Created by Kamil Powałowski on 29/06/2021.
//

import Foundation

struct AccountState: StateType {
    let status: AccountStatus

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
