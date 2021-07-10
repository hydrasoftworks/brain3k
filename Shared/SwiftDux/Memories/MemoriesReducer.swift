//
//  Created by Kamil Powałowski on 27/06/2021.
//

import SwiftDux

final class MemoriesReducer: Reducer {
    func reduce(
        state: OrderedState<Memory>,
        action _: MemoriesAction
    ) -> OrderedState<Memory> {
        state
    }
}
