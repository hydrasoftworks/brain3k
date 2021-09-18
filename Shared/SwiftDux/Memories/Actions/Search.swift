//
//  Created by Kamil Powałowski on 15/09/2021.
//

import Combine
import SwiftDux

extension MemoriesAction {
    static func search(
        for query: String,
        _ memoriesService: MemoriesService = MemoriesService()
    ) -> ActionPlan<AppState> {
        if query.isEmpty {
            return ActionPlan<AppState> { store in
                store.send(MemoriesAction.setSearchQuery(query))
                store.send(MemoriesAction.clearFiltered)
            }
        }

        return ActionPlan<AppState> { store -> AnyPublisher<Action, Never> in
            memoriesService.search(
                for: query,
                in: store.state.memoriesState.all
            )
            .map { MemoriesAction.setFiltered($0) }
            .prepend(MemoriesAction.setSearchQuery(query))
            .catch { Just(MessageAction.show(.error($0.message))) }
            .eraseToAnyPublisher()
        }
    }
}
