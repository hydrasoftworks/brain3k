//
//  Created by Kamil Powałowski on 27/06/2021.
//

import SwiftDux

enum MemoriesAction: Action, Equatable {
    case set([Memory])
    case add(Memory)
}
