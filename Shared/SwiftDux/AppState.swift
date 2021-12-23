//
//  Created by Kamil Powałowski on 27/06/2021.
//

import Foundation
import SwiftDux

struct AppState: StateType {
    let messageState: MessageState
    let accountState: AccountState
    let subscriptionState: SubscriptionState
    let memoriesState: MemoriesState
    let storageState: StorageState

    init(
        messageState: MessageState = MessageState(),
        accountState: AccountState = AccountState(),
        subscriptionState: SubscriptionState = SubscriptionState(),
        memoriesState: MemoriesState = MemoriesState(),
        storageState: StorageState = StorageState()
    ) {
        self.messageState = messageState
        self.accountState = accountState
        self.subscriptionState = subscriptionState
        self.memoriesState = memoriesState
        self.storageState = storageState
    }
}
