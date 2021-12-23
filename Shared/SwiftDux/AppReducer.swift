//
//  Created by Kamil Powałowski on 27/06/2021.
//

import SwiftDux

final class AppReducer: Reducer {
    private let messageReducer = MessageReducer()
    private let accountReducer = AccountReducer()
    private let subscriptionReducer = SubscriptionReducer()
    private let memoriesReducer = MemoriesReducer()
    private let storageReducer = StorageReducer()

    func reduceAny(state: AppState, action: Action) -> AppState {
        AppState(
            messageState: messageReducer.reduceAny(state: state.messageState, action: action),
            accountState: accountReducer.reduceAny(state: state.accountState, action: action),
            subscriptionState: subscriptionReducer.reduceAny(state: state.subscriptionState, action: action),
            memoriesState: memoriesReducer.reduceAny(state: state.memoriesState, action: action),
            storageState: storageReducer.reduceAny(state: state.storageState, action: action)
        )
    }
}
