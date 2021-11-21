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
        ActionPlan<AppState> { store -> AnyPublisher<Action, Never> in
            guard let memoryId = memory?.id,
                  let account = store.state.accountState.account
            else {
                return .empty
            }

            return memoriesService.update(
                memoryWithId: memoryId,
                withNotes: notes.isEmpty ? nil : notes,
                on: account.id
            )
            .mapToEmptyResult(ofType: Action.self)
            .catch { Just(MessageAction.show(.error($0.message))) }
            .eraseToAnyPublisher()
        }
    }
}
