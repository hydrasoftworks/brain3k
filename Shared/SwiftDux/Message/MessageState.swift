//
//  Created by Kamil Powałowski on 08/07/2021.
//

import Foundation

struct MessageState: StateType {
    let message: Message?

    init(message: Message? = nil) {
        self.message = message
    }

    func copyWith(
        message: Message? = nil
    ) -> MessageState {
        MessageState(
            message: message ?? self.message
        )
    }

    func copyWithNil(
        message: Bool = false
    ) -> MessageState {
        MessageState(
            message: message ? nil : self.message
        )
    }
}
