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
        case let .setNonce(nonce):
            return state.copyWith(nonce: nonce)
        case let .setUser(user):
            if let user = user {
                return state.copyWith(user: user)
            } else {
                return state.copyWithNil(user: true)
            }
        }
    }
}
