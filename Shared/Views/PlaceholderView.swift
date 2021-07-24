//
//  Created by Kamil Powałowski on 22/07/2021.
//

import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        ProgressView("Loading...")
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
