//
//  Created by Kamil Powałowski on 27/06/2021.
//

import SwiftDux

final class MemoriesReducer: Reducer {
    func reduce(
        state _: OrderedState<Memory>,
        action: MemoriesAction
    ) -> OrderedState<Memory> {
        switch action {
        case let .set(memories):
            return OrderedState(memories)
        }
    }
}
