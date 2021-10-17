//
//  Created by Kamil Powałowski on 17/10/2021.
//

import SwiftUI

struct UserInterfaceIdiomView<Phone, Pad>: View where Phone: View, Pad: View {
    private let phone: () -> Phone
    private let pad: () -> Pad

    init(
        @ViewBuilder phone: @escaping () -> Phone,
        @ViewBuilder pad: @escaping () -> Pad
    ) {
        self.phone = phone
        self.pad = pad
    }

    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            pad()
        } else {
            phone()
        }
    }
}
