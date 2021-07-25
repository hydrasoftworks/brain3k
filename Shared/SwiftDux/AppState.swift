//
//  Created by Kamil Powałowski on 27/06/2021.
//

import Foundation
import SwiftDux

struct AppState: StateType {
    let messageState: MessageState
    let accountState: AccountState
    let memoriesState: [Memory]

    init(
        messageState: MessageState = MessageState(),
        accountState: AccountState = AccountState(),
        memoriesState: [Memory] = []
    ) {
        self.messageState = messageState
        self.accountState = accountState
        self.memoriesState = memoriesState
    }
}
