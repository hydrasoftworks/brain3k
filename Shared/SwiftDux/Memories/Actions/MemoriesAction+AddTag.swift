//
//  Created by Kamil Powałowski on 06/12/2021.
//

import Combine
import Foundation
import SwiftDux

extension MemoriesAction {
    static func removeTag(
        memory: Memory?,
        tag: String,
        _ memoriesService: MemoriesService = MemoriesService()
    ) -> ActionPlan<AppState> {
        wrapper(memory: memory) { box in
            var tags = memory?.tags ?? []
            tags.removeAll(where: { $0 == tag })

            return memoriesService.update(
                memoryWithId: box.memoryId,
                withTags: tags.isEmpty ? nil : tags,
                on: box.account.id
            )
            .mapToEmptyResult(ofType: Action.self)
            .catch { Just(MessageAction.show(.error($0.message))) }
            .eraseToAnyPublisher()
        }
    }
}
