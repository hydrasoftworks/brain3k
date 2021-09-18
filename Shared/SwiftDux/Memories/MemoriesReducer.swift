//
//  Created by Kamil Powałowski on 27/06/2021.
//

import SwiftDux

final class MemoriesReducer: Reducer {
    func reduce(
        state: MemoriesState,
        action: MemoriesAction
    ) -> MemoriesState {
        switch action {
        case let .set(memories):
            return state.copyWith(all: memories)
        case let .setSearchQuery(query):
            return state.copyWith(searchQuery: query)
        case let .setFiltered(memories):
            return state.copyWith(filtered: memories)
        case .clearFiltered:
            return state.copyWithNil(filtered: true)
        }
    }
}
