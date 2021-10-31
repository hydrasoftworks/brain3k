//
//  Created by Kamil Powałowski on 31/10/2021.
//

import Foundation

struct AppConfiguration {
    #if os(iOS)
        static let buttonHeight: CGFloat = 56
    #else
        static let buttonHeight: CGFloat = 32
    #endif
}
