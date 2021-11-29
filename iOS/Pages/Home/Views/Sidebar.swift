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
                tag: Option.memories,
                selection: $selected,
                destination: { MemoriesPageConnector() }
            ) {
                Label(
                    L10n.MemoriesPage.title,
                    image: Asset.brainIcon.name
                )
            }
            NavigationLink(
                tag: Option.settings,
                selection: $selected,
                destination: { SettingsPage() }
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
