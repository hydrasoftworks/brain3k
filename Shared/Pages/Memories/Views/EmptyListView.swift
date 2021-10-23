//
//  Created by Kamil Powałowski on 03/10/2021.
//

import SwiftUI

struct EmptyListView: View {
    let image: ImageAsset
    let text: String

    var body: some View {
        VStack {
            Image(image.name)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding(.bottom)
                .padding(.top, 40)
            Text(text)
                .font(.body)
                .foregroundStyle(Color.brand)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 48)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
