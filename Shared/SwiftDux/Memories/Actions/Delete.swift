//
//  Created by Kamil Powałowski on 30/09/2021.
//

import Combine
import SwiftDux

extension MemoriesAction {
    static func delete(
        memory: Memory?,
        _ memoriesService: MemoriesService = MemoriesService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { store -> AnyPublisher<Action, Never> in
            guard let memoryId = memory?.id,
                  let account = store.state.accountState.account
            else {
                return .empty
            }

            return memoriesService.deleteMemory(
                withId: memoryId,
                from: account.id
            )
            .mapToEmptyResult(ofType: Action.self)
            .catch { Just(MessageAction.show(.error($0.message))) }
            .eraseToAnyPublisher()
        }
    }
}
