//
//  Created by Kamil Powałowski on 27/06/2021.
//

import Foundation
import SwiftDux

struct AppState: StateType {
    let message: MessageState
    let account: AccountState
    let items: OrderedState<Item>

    init(
        message: MessageState = MessageState(),
        account: AccountState = AccountState(),
        items: OrderedState<Item> = OrderedState()
    ) {
        self.message = message
        self.account = account
        self.items = items
    }
}
