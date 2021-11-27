//
//  Created by Kamil Powałowski on 27/11/2021.
//

import Foundation
import SwiftUI

class HapticService {
    enum FeedbackStyle: Int {
        case light = 0
        case medium = 1
        case heavy = 2
        case soft = 3
        case rigid = 4
    }

    enum FeedbackType: Int {
        case success = 0
        case warning = 1
        case error = 2
    }

    static func impactOccurred(_ style: FeedbackStyle) {
        #if os(iOS)
            let generator = UIImpactFeedbackGenerator(
                style: .init(rawValue: style.rawValue) ?? .light
            )
            generator.impactOccurred()
        #endif
    }

    static func notificationOccurred(_ type: FeedbackType) {
        #if os(iOS)
            guard let type = UINotificationFeedbackGenerator.FeedbackType(rawValue: type.rawValue) else {
                return
            }
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(type)
        #endif
    }
}
