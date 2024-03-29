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
        wrapper(memory: memory) { box in
            memoriesService.delete(
                memoryWithId: box.memoryId,
                from: box.account.id
            )
            .mapToEmptyResult(ofType: Action.self)
            .catch { Just(MessageAction.show(.error($0.message))) }
            .eraseToAnyPublisher()
        }
    }
}
