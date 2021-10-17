//
//  Created by Kamil Powałowski on 30/06/2021.
//

import SwiftDux
import SwiftUI

struct HomePage: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    var body: some View {
        Group {
            if verticalSizeClass == .regular, horizontalSizeClass == .regular {
                pad
            } else {
                phone
            }
        }
        .accentColor(Color.brand)
        .onAppear(dispatch: MemoriesAction.watchAll())
    }

    private var phone: some View {
        TabView {
            NavigationView {
                MemoriesPageConnector()
            }
            .tabItem {
                Label(
                    L10n.MemoriesPage.title,
                    image: Asset.brainIcon.name
                )
            }
            NavigationView {
                SettingsPage()
            }
            .tabItem {
                Label(
                    L10n.SettingsPage.title,
                    systemImage: "gearshape.fill"
                )
            }
        }
        .materialBackground()
    }

    private var pad: some View {
        NavigationView {
            Sidebar()
            MemoriesPageConnector()
            MemoryPageConnector(memoryId: nil)
        }
    }
}
