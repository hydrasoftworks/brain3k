//
//  Created by Kamil Powałowski on 08/07/2021.
//

import Foundation

enum Message: Equatable {
    case error(String)
    case purchase(String)

    var text: String {
        switch self {
        case let .error(text),
             let .purchase(text):
            return text
        }
    }
}
