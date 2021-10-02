//
//  Created by Kamil Powałowski on 17/08/2021.
//

import Combine
import Foundation
import SwiftDux

extension StorageAction {
    static func getDownloadURL(
        for url: URL?,
        _ storageService: StorageService = StorageService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { store -> AnyPublisher<Action, Never> in
            let state = store.state.storageState
            guard let url = url,
                  state.downloadURLs[url] == nil
            else {
                return .empty
            }

            if url.scheme != "gs" {
                return Just(StorageAction.add(url, url))
                    .eraseToAnyPublisher()
            }

            return storageService.downloadURL(for: url)
                .map { StorageAction.add(url, $0) }
                .catch { _ in Empty() }
                .eraseToAnyPublisher()
        }
    }
}
