//
//  Created by Kamil Powałowski on 15/07/2021.
//

@testable import Brain3k
import Combine
import Foundation
import SwiftDux

func storeProxy(_ state: AppState = AppState()) -> StoreProxy<AppState> {
    Store<AppState>(state: state, reducer: AppReducer())
        .proxy()
}

func storeProxy(
    send: @escaping SendAction,
    sendAsCancellable: @escaping SendCancellableAction = { _ in AnyCancellable {} }
) -> StoreProxy<AppState> {
    Store<AppState>(state: AppState(), reducer: AppReducer())
        .proxy(
            dispatcher: ActionDispatcherProxy(
                send: send,
                sendAsCancellable: sendAsCancellable
            )
        )
}
