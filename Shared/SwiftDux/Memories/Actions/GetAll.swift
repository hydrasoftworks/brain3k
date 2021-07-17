//
//  Created by Kamil Powałowski on 17/07/2021.
//

import Combine
import SwiftDux

extension MemoriesAction {
    static func getAll(
        _ memoriesService: MemoriesService = MemoriesService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            memoriesService.getAll()
                .map { MemoriesAction.set($0) }
                .catch { Just(MessageAction.set(.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }
}
