//
//  Created by Kamil Powałowski on 27/06/2021.
//

import Foundation

extension URL {
    static var persistFileUrl: URL {
        FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent("countdowns.json")
            ?? URL(fileURLWithPath: "./countdowns.json")
    }
}
