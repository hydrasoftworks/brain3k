//
//  Created by Kamil Powałowski on 10/07/2021.
//

import SwiftDux
import SwiftUI

struct SettingsPage: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    func map(state _: AppState) -> ViewModel? {
        ViewModel()
    }

    func body(props _: ViewModel) -> some View {
        VStack {
            SecondaryButton(title: L10n.SettingsPage.Button.signOut) {
                dispatch.send(AccountAction.signOut())
            }
        }
        .navigationTitle(L10n.SettingsPage.title)
    }

    struct ViewModel: Equatable {}
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
