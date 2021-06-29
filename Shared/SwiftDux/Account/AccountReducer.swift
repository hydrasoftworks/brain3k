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
        case let .setUser(user):
            return state.copyWith(user: user)
        }
    }
}
