//
//  Created by Kamil Powałowski on 30/06/2021.
//

import SwiftDux
import SwiftUI

struct HomePage: View {
    var body: some View {
        UserInterfaceIdiomView(
            phone: { phone },
            pad: { pad }
        )
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
