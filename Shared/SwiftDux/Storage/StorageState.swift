//
//  Created by Kamil Powałowski on 17/08/2021.
//

import Foundation

struct StorageState: StateType {
    let downloadURLs: [URL: URL]

    init(downloadURLs: [URL: URL] = [:]) {
        self.downloadURLs = downloadURLs
    }

    func downloadURL(for url: URL?) -> URL? {
        guard let url = url else { return nil }
        return downloadURLs[url]
    }

    func copyWith(
        downloadURLs: [URL: URL]? = nil
    ) -> StorageState {
        StorageState(
            downloadURLs: downloadURLs ?? self.downloadURLs
        )
    }
}
