//
//  Created by Kamil Powałowski on 27/06/2021.
//

import SwiftDux

final class MemoriesReducer: Reducer {
    func reduce(
        state _: [Memory],
        action: MemoriesAction
    ) -> [Memory] {
        switch action {
        case let .set(memories):
            return memories
        }
    }
}
