//
//  Created by Kamil Powałowski on 02/10/2021.
//

import Combine
import Foundation
import SwiftDux

extension MemoriesAction {
    static func refresh(
        memory: Memory?,
        _ memoriesService: MemoriesService = MemoriesService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { store -> AnyPublisher<Action, Never> in
            guard let memory = memory,
                  let memoryId = memory.id,
                  let account = store.state.accountState.account
            else {
                return .empty
            }

            let updatedMemory = memory
                .copyWithNil(
                    updatedAt: true,
                    thumbnail: true,
                    title: true,
                    description: true,
                    tags: true
                )
                .copyWith(processed: false)

            return memoriesService.update(
                memoryWithId: memoryId,
                with: updatedMemory,
                on: account.id
            )
            .mapToEmptyResult(ofType: Action.self)
            .catch { Just(MessageAction.show(.error($0.message))) }
            .eraseToAnyPublisher()
        }
    }
}
