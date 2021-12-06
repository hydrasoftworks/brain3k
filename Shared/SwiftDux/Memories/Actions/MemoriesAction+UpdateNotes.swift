//
//  Created by Kamil Powałowski on 20/11/2021.
//

import Combine
import Foundation
import SwiftDux

extension MemoriesAction {
    static func updateNotes(
        memory: Memory?,
        notes: String,
        _ memoriesService: MemoriesService = MemoriesService()
    ) -> ActionPlan<AppState> {
        wrapper(memory: memory) { box in
            memoriesService.update(
                memoryWithId: box.memoryId,
                withNotes: notes.isEmpty ? nil : notes,
                on: box.account.id
            )
            .mapToEmptyResult(ofType: Action.self)
            .catch { Just(MessageAction.show(.error($0.message))) }
            .eraseToAnyPublisher()
        }
    }
}
