//
//  Created by Kamil Powałowski on 07/07/2021.
//

import MGFlipView
import SwiftUI

struct JoinPage: View {
    @State private var flipped = false

    var body: some View {
        ZStack {
            background
            FlipView(
                frontView: { SignInPage(flip: { flipped = true }) },
                backView: { SignUpPage(flip: { flipped = false }) },
                flipped: $flipped,
                flipAxis: .y
            )
        }
    }

    private var background: some View {
        Image("background")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct JoinPage_Previews: PreviewProvider {
    static var previews: some View {
        JoinPage()
    }
}