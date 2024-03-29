//
//  Created by Kamil Powałowski on 25/07/2021.
//

import Combine
import SwiftDux

extension MemoriesAction {
    static func createURL(
        url: String,
        _ memoriesService: MemoriesService = MemoriesService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { store -> AnyPublisher<Action, Never> in
            guard let account = store.state.accountState.account else {
                return .empty
            }

            return memoriesService.add(
                memory: Memory(type: .url, value: url),
                to: account.id
            )
            .mapToEmptyResult(ofType: Action.self)
            .catch { Just(MessageAction.show(.error($0.message))) }
            .eraseToAnyPublisher()
        }
    }
}
