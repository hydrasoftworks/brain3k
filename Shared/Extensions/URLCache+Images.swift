//
//  Created by Kamil Powałowski on 28/11/2021.
//

import Foundation

extension URLCache {
    static let images = URLCache(
        memoryCapacity: 512 * 1000 * 1000,
        diskCapacity: 2 * 1000 * 1000 * 1000
    )
}
