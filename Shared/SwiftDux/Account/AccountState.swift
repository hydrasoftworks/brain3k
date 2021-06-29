//
//  Created by Kamil Powałowski on 29/06/2021.
//

import Foundation

struct AccountState: StateType {
    let user: User?

    init(user: User? = nil) {
        self.user = user
    }

    func copyWith(
        user: User? = nil
    ) -> AccountState {
        AccountState(
            user: user ?? self.user
        )
    }
}
