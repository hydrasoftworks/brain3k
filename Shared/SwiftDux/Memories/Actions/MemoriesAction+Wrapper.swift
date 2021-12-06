//
//  Created by Kamil Powałowski on 06/12/2021.
//

import Combine
import SwiftDux

extension MemoriesAction {
    struct Box {
        let state: AppState
        let memory: Memory
        let account: Account
        let memoryId: String
    }

    static func wrapper(
        memory: Memory?,
        completed: @escaping (Box) -> AnyPublisher<Action, Never>
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { store -> AnyPublisher<Action, Never> in
            guard let memory = memory,
                  let memoryId = memory.id,
                  let account = store.state.accountState.account
            else {
                return .empty
            }

            let box = Box(
                state: store.state,
                memory: memory,
                account: account,
                memoryId: memoryId
            )

            return completed(box)
        }
    }
}
