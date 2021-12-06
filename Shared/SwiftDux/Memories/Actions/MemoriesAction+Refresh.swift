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
        wrapper(memory: memory) { box in
            let updatedMemory = box.memory
                .copyWithNil(
                    updatedAt: true,
                    thumbnail: true,
                    title: true,
                    description: true,
                    tags: true
                )
                .copyWith(processed: false)

            return memoriesService.update(
                memoryWithId: box.memoryId,
                with: updatedMemory,
                on: box.account.id
            )
            .mapToEmptyResult(ofType: Action.self)
            .catch { Just(MessageAction.show(.error($0.message))) }
            .eraseToAnyPublisher()
        }
    }
}
