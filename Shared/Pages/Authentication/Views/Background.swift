//
//  Created by Kamil Powałowski on 10/07/2021.
//

import Colorful
import SwiftUI

struct Background: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    private static let darkColorList = [#colorLiteral(red: 0.3020898664, green: 0.2080110187, blue: 0.2662029901, alpha: 1), #colorLiteral(red: 0.280035728, green: 0.2323848612, blue: 0.300201798, alpha: 1), #colorLiteral(red: 0.2227038989, green: 0.2344194243, blue: 0.2955788289, alpha: 1), #colorLiteral(red: 0.1352394819, green: 0.2753144455, blue: 0.3012403897, alpha: 1), #colorLiteral(red: 0.110897964, green: 0.2971421522, blue: 0.2882870417, alpha: 1), #colorLiteral(red: 0.1724232285, green: 0.3028834688, blue: 0.2134724228, alpha: 1)].map(Color.init)

    private static let animation = Animation
        .interpolatingSpring(stiffness: 50, damping: 1)
        .speed(0.025)

    var body: some View {
        ColorfulView(
            animation: Background.animation,
            colors: colorScheme == .dark
                ? Background.darkColorList
                : ColorfulView.defaultColorList
        )
        .ignoresSafeArea()
    }
}
