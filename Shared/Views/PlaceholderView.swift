//
//  Created by Kamil Powałowski on 22/07/2021.
//

import SwiftUI

struct PlaceholderView: View {
    let title: String

    init(title: String = "Loading...") {
        self.title = title
    }

    var body: some View {
        ProgressView(title)
            .frame(
                minWidth: 0, maxWidth: .infinity,
                minHeight: 0, maxHeight: .infinity
            )
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView()
    }
}
