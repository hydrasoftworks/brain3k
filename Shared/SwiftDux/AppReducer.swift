//
//  Created by Kamil Powałowski on 27/06/2021.
//

import SwiftDux

final class AppReducer: Reducer {
    private let messageReducer = MessageReducer()
    private let accountReducer = AccountReducer()
    private let itemsReducer = ItemsReducer()

    func reduceAny(state: AppState, action: Action) -> AppState {
        AppState(
            message: messageReducer.reduceAny(state: state.message, action: action),
            account: accountReducer.reduceAny(state: state.account, action: action),
            items: itemsReducer.reduceAny(state: state.items, action: action)
        )
    }
}
