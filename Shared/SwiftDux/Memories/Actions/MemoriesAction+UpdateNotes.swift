//
//  Created by Kamil Powałowski on 20/11/2021.
//

import Combine
import Foundation
import SwiftDux

extension MemoriesAction {
    static func updateNotes(
        memory _: Memory?,
        notes _: String,
        _: MemoriesService = MemoriesService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            .empty
        }
    }
}
