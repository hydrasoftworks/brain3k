//
//  Created by Kamil Powałowski on 20/12/2021.
//

import Combine
import Foundation
import SwiftDux

extension PurchasesAction {
    static func getOfferings(
        _ purchasesService: PurchasesService = PurchasesService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { _ -> AnyPublisher<Action, Never> in
            purchasesService.getOfferings()
                .map(PurchasesAction.setOfferings)
                .catch { Just(MessageAction.show(.error($0.message))) }
                .eraseToAnyPublisher()
        }
    }
}
