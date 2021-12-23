//
//  Created by Kamil Powałowski on 30/06/2021.
//

import SwiftDux
import SwiftUI

struct HomePage: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private static var lastIdiom: UIUserInterfaceIdiom?

    var body: some View {
        content
            .accentColor(Color.brand)
            .onAppear(dispatch: MemoriesAction.watchAll())
            .onAppear(dispatch: AccountAction.watchUser())
            .onAppear(dispatch: SubscriptionAction.setIdentity())
    }

    @ViewBuilder
    private var content: some View {
        if shouldDisplayPadVersion {
            pad
                .onAppear { HomePage.lastIdiom = .pad }
        } else {
            phone
                .onAppear { HomePage.lastIdiom = .phone }
        }
    }

    private var pad: some View {
        NavigationView {
            Sidebar()
            MemoriesPageConnector()
            MemoryPageConnector(memoryId: nil)
        }
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
                SettingsPageConnector()
            }
            .tabItem {
                Label(
                    L10n.SettingsPage.title,
                    image: Asset.settingsIcon.name
                )
            }
        }
        .materialBackground()
    }

    /*
     On iPad, when the app is minimized, for a moment,
     horizontalSizeClass equals .compact, which resets the navigation tree.
     This repository https://github.com/pd95/SwiftUI-Sidebar contains an example
     with fully working implementation, but it requires a lot of work.
     */
    private var shouldDisplayPadVersion: Bool {
        (verticalSizeClass == .regular && horizontalSizeClass == .regular)
            || (HomePage.lastIdiom == .pad && scenePhase == .background)
    }
}
