//
//  Created by Kamil Powałowski on 30/06/2021.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
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
        .accentColor(Color("PrimaryColor"))
        .materialBackground()
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
