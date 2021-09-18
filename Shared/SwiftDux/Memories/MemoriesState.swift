//
//  Created by Kamil Powałowski on 15/09/2021.
//

import Foundation

import Foundation

struct MemoriesState: StateType {
    let all: [Memory]
    let searchQuery: String
    let filtered: [Memory]?

    init(
        all: [Memory] = [],
        searchQuery: String = "",
        filtered: [Memory]? = nil
    ) {
        self.all = all
        self.searchQuery = searchQuery
        self.filtered = filtered
    }

    func copyWith(
        all: [Memory]? = nil,
        searchQuery: String? = nil,
        filtered: [Memory]? = nil
    ) -> MemoriesState {
        MemoriesState(
            all: all ?? self.all,
            searchQuery: searchQuery ?? self.searchQuery,
            filtered: filtered ?? self.filtered
        )
    }

    func copyWithNil(
        filtered: Bool = false
    ) -> MemoriesState {
        MemoriesState(
            all: all,
            filtered: filtered ? nil : self.filtered
        )
    }
}
