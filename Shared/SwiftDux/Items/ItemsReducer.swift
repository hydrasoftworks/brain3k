//
//  Created by Kamil Powałowski on 27/06/2021.
//

import SwiftDux

final class ItemsReducer: Reducer {
    func reduce(
        state: OrderedState<Item>,
        action _: ItemsAction
    ) -> OrderedState<Item> {
        state
    }
}
