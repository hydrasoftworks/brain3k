//
//  Created by Kamil Powałowski on 10/07/2021.
//

import Foundation

extension String {
    func trim() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
