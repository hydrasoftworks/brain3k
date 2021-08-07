//
//  Created by Kamil Powałowski on 08/07/2021.
//

import SwiftDux

final class MessageReducer: Reducer {
    func reduce(
        state: MessageState,
        action: MessageAction
    ) -> MessageState {
        switch action {
        case let .show(message):
            return state.copyWith(message: message)
        case .clear:
            return state.copyWithNil(message: true)
        }
    }
}
