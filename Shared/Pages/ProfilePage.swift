//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftDux
import SwiftUI

struct ProfilePage: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    func map(state _: AppState) -> ViewModel? {
        ViewModel()
    }

    func body(props _: ViewModel) -> some View {
        VStack {
            SecondaryButton(title: "Sign out") {
                dispatch.send(AccountAction.signOut())
            }
        }
        .navigationTitle("Profile")
    }

    struct ViewModel: Equatable {}
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
