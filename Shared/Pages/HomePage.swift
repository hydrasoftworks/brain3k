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
                MemoryPage()
            }
            .tabItem {
                Label(
                    L10n.MemoriesPage.title,
                    systemImage: "lightbulb"
                )
            }
            NavigationView {
                ProfilePage()
            }
            .tabItem {
                Label(
                    L10n.ProfilePage.title,
                    systemImage: "person"
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
