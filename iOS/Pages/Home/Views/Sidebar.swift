//
//  Created by Kamil Powałowski on 17/10/2021.
//

import SwiftUI

private enum Option: String {
    case memories, settings
}

struct Sidebar: View {
    @SwiftUI.State private var selected: Option? = Option.memories

    var body: some View {
        List {
            NavigationLink(
                destination: MemoriesPageConnector(),
                tag: Option.memories,
                selection: $selected
            ) {
                Label(
                    L10n.MemoriesPage.title,
                    image: Asset.brainIcon.name
                )
            }
            NavigationLink(
                destination: SettingsPage(),
                tag: Option.settings,
                selection: $selected
            ) {
                Label(
                    L10n.SettingsPage.title,
                    image: Asset.settingsIcon.name
                )
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle(L10n.HomePage.Menu.title)
    }
}
