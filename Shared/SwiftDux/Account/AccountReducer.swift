//
//  Created by Kamil Powałowski on 29/06/2021.
//

import SwiftDux

final class AccountReducer: Reducer {
    func reduce(
        state: AccountState,
        action: AccountAction
    ) -> AccountState {
        switch action {
        case let .setStatus(status):
            return state.copyWith(status: status)
        }
    }
}
