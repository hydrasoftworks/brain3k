//
//  Created by Kamil Powałowski on 27/06/2021.
//

import Foundation
import SwiftDux

struct AppState: StateType {
    let account: AccountState
    let items: OrderedState<Item>

    init(
        account: AccountState = AccountState(),
        items: OrderedState<Item> = OrderedState()
    ) {
        self.account = account
        self.items = items
    }
}
