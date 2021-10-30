//
//  Created by Kamil Powałowski on 29/10/2021.
//

import SwiftDux
import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationView {
            MemoriesPageConnector()
                .frame(minWidth: 182, idealWidth: 350)
            MemoryPageConnector(memoryId: nil)
                .frame(minWidth: 300, idealWidth: 550)
        }
        .accentColor(Color.brand)
        .onAppear(dispatch: MemoriesAction.watchAll())
    }
}
