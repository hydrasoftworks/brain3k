//
//  Created by Kamil Powałowski on 31/10/2021.
//

import SwiftUI

struct JoinPage: View {
    @State private var flipped = false

    var body: some View {
        ZStack {
            Background()
            if flipped {
                SignUpPage(flipped: $flipped)
            } else {
                SignInPage(flipped: $flipped)
            }
        }
        .onAppear(dispatch: AccountAction.generateNonce())
    }
}
