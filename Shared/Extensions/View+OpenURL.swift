//
//  Created by Kamil Powałowski on 23/12/2021.
//

import SwiftUI

extension View {
    func openURL(_ url: URL?) {
        guard let url = url else { return }
        #if os(iOS)
            UIApplication.shared.open(url)
        #else
            NSWorkspace.shared.open(url)
        #endif
    }
}
