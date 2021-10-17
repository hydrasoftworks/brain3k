//
//  Created by Kamil Powałowski on 16/10/2021.
//

import SwiftUI

struct DeviceOrientationView<Portrait, Landscape>: View where Portrait: View, Landscape: View {
    @SwiftUI.State private var isPortrait: Bool

    private let portrait: () -> Portrait
    private let landscape: () -> Landscape

    init(
        @ViewBuilder portrait: @escaping () -> Portrait,
        @ViewBuilder landscape: @escaping () -> Landscape
    ) {
        isPortrait = OrientationHelper.isPortrait
        self.portrait = portrait
        self.landscape = landscape
    }

    var body: some View {
        Group {
            if isPortrait {
                portrait()
            } else {
                landscape()
            }
        }
        .onReceive(
            NotificationCenter.Publisher(
                center: .default,
                name: UIDevice.orientationDidChangeNotification
            )
        ) { _ in
            self.isPortrait = OrientationHelper.isPortrait
        }
    }
}
