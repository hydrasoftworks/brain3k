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
                Label("Memories", systemImage: "lightbulb")
            }
            NavigationView {
                ProfilePage()
            }
            .tabItem {
                Label("Profile", systemImage: "person")
            }
        }
        .accentColor(Color.primary)
        .materialBackground()
        .onAppear(dispatch: MemoriesAction.getAll())
    }

    struct ViewModel: Equatable {}
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
