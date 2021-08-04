//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftUI

struct Background: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)

            if colorScheme == .dark {
                Rectangle()
                    .fill(Color.black.opacity(0.3))
            }
        }
        .ignoresSafeArea()
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
