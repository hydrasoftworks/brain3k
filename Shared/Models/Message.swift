//
//  Created by Kamil Powałowski on 08/07/2021.
//

import Foundation

enum Message: Equatable {
    case error(String)
    case info(String)
    case purchase(String)

    var text: String {
        switch self {
        case let .error(text),
             let .info(text),
             let .purchase(text):
            return text
        }
    }
}
