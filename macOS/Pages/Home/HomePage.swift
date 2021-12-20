//
//  Created by Kamil Powałowski on 29/10/2021.
//

import SwiftDux
import SwiftUI

struct HomePage: View {
    @SwiftUI.State private var selectedMemoryID: String?

    var body: some View {
        NavigationView {
            MemoriesPageConnector()
                .frame(minWidth: 182, idealWidth: 350)
            MemoryPageConnector(memoryId: selectedMemoryID)
                .frame(minWidth: 300, idealWidth: 650)
        }
        .accentColor(Color.brand)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(
                    action: toggleSidebar,
                    label: { Image(systemName: "sidebar.leading") }
                )
            }
        }
        .onAppear(dispatch: MemoriesAction.watchAll())
        .onAppear(dispatch: AccountAction.watchUser())
        .onAppear(dispatch: PurchasesAction.setIdentity())
        .environment(\.selectedMemoryID, $selectedMemoryID)
    }

    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(
            #selector(NSSplitViewController.toggleSidebar(_:)),
            with: nil
        )
    }
}
