//
//  Created by Kamil Powałowski on 17/08/2021.
//

import SwiftDux

final class StorageReducer: Reducer {
    func reduce(
        state: StorageState,
        action: StorageAction
    ) -> StorageState {
        switch action {
        case let .add(key, value):
            var urls = state.downloadURLs
            urls[key] = value
            return state.copyWith(downloadURLs: urls)
        }
    }
}
