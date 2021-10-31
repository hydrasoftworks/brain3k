//
//  Created by Kamil Powałowski on 07/07/2021.
//

import MGFlipView
import SwiftUI

struct JoinPage: View {
    @State private var flipped = false

    var body: some View {
        ZStack {
            Background()
            FlipView(
                frontView: { SignInPage(flipped: $flipped) },
                backView: { SignUpPage(flipped: $flipped) },
                flipped: $flipped,
                flipAxis: .y
            )
        }
        .onAppear(dispatch: AccountAction.generateNonce())
    }
}
