//
//  Created by Kamil Powałowski on 08/07/2021.
//

import SwiftDux

enum MessageAction: Action, Equatable {
    case set(Message)
    case clear
}
