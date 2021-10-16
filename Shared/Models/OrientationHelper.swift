//
//  Created by Kamil Powałowski on 16/10/2021.
//

import SwiftUI

struct OrientationHelper {
    static var isLandscape: Bool {
        orientation?.isLandscape
            ?? window?.windowScene?.interfaceOrientation.isLandscape
            ?? false
    }

    static var isPortrait: Bool {
        orientation?.isPortrait
            ?? window?.windowScene?.interfaceOrientation.isPortrait
            ?? false
    }

    static var isFlat: Bool {
        orientation?.isFlat ?? false
    }

    static var orientation: UIDeviceOrientation? {
        UIDevice.current.orientation.isValidInterfaceOrientation
            ? UIDevice.current.orientation
            : nil
    }

    static var window: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window
        else {
            return nil
        }
        return window
    }
}
