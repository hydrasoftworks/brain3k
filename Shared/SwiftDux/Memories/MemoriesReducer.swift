//
//  Created by Kamil Powałowski on 27/06/2021.
//

import SwiftDux

final class MemoriesReducer: Reducer {
    func reduce(
        state: [Memory],
        action: MemoriesAction
    ) -> [Memory] {
        switch action {
        case let .set(memories):
            return memories
        case let .add(memory):
            return [memory] + state
        }
    }
}
