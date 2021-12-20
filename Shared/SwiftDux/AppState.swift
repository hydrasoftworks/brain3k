//
//  Created by Kamil Powałowski on 27/06/2021.
//

import Foundation
import SwiftDux

struct AppState: StateType {
    let messageState: MessageState
    let accountState: AccountState
    let purchasesState: PurchasesState
    let memoriesState: MemoriesState
    let storageState: StorageState

    init(
        messageState: MessageState = MessageState(),
        accountState: AccountState = AccountState(),
        purchasesState: PurchasesState = PurchasesState(),
        memoriesState: MemoriesState = MemoriesState(),
        storageState: StorageState = StorageState()
    ) {
        self.messageState = messageState
        self.accountState = accountState
        self.purchasesState = purchasesState
        self.memoriesState = memoriesState
        self.storageState = storageState
    }
}
