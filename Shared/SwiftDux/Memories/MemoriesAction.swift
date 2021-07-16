//
//  Created by Kamil Powałowski on 27/06/2021.
//

import Combine
import ParseSwift
import SwiftDux

enum MemoriesAction: Action, Equatable {
    case set([Memory])
}

extension MemoriesAction {
    static func getAll() -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            let query = Memory.query()
            return query.findAllPublisher()
                .map { MemoriesAction.set($0) }
                .catch { Just(MessageAction.set(.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }
}
