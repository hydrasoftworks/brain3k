//
//  Created by Kamil Powałowski on 17/07/2021.
//

import Combine
import SwiftDux

extension MemoriesAction {
    static func getAll(
        _ memoriesService: MemoriesService = MemoriesService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { store -> AnyPublisher<Action, Never> in
            guard let account = store.state.accountState.account else {
                return .empty
            }

            return memoriesService.getAll(for: account.id)
                .map { MemoriesAction.set($0) }
                .catch { Just(MessageAction.show(.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }
}
