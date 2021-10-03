//
//  Created by Kamil Powałowski on 03/10/2021.
//

import SwiftUI

struct EmptyList: View {
    let text: String

    var body: some View {
        VStack {
            Image(Asset.placeholder.name)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding(.bottom)
                .padding(.top, 100)
            Text(text)
                .font(.caption)
                .foregroundStyle(Color.brand)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 48)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct EmptyList_Previews: PreviewProvider {
    static var previews: some View {
        EmptyList(text: L10n.MemoriesPage.Empty.all)
    }
}
