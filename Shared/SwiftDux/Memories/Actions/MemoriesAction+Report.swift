//
//  Created by Kamil Powałowski on 05/01/2022.
//

import Combine
import Foundation
import SwiftDux

extension MemoriesAction {
    static func report(
        memory: Memory?,
        _ memoriesService: MemoriesService = MemoriesService()
    ) -> ActionPlan<AppState> {
        wrapper(memory: memory) { box in
            memoriesService.report(
                memoryWithId: box.memoryId,
                with: box.memory,
                from: box.account.id
            )
            .map { MessageAction.show(.info(L10n.Alerts.Info.memoryReported)) }
            .catch { _ in Just(MessageAction.show(.info(L10n.Alerts.Info.memoryReported))) }
            .eraseToAnyPublisher()
        }
    }
}
