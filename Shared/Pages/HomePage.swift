//
//  Created by Kamil Powałowski on 30/06/2021.
//

import SwiftDux
import SwiftUI

struct HomePage: ConnectableView {
    func map(state _: AppState) -> ViewModel? { ViewModel() }

    func body(props _: ViewModel) -> some View {
        TabView {
            NavigationView {
                MemoriesPage()
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
        .accentColor(Color.brand)
        .materialBackground()
        .onAppear(dispatch: MemoriesAction.watchAll())
    }

    struct ViewModel: Equatable {}
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
