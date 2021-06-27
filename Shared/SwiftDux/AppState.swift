//
//  Created by Kamil Powałowski on 27/06/2021.
//

import Foundation
import SwiftDux

struct AppState: StateType {
    let items: OrderedState<Item>

    init(
        items: OrderedState<Item> = OrderedState()
    ) {
        self.items = items
    }

    enum CodingKeys: String, CodingKey {
        case items
    }
}
