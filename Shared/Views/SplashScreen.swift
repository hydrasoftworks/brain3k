//
//  Created by Kamil Powałowski on 30/06/2021.
//

import SwiftDux
import SwiftUI

struct SplashScreen: ConnectableView {
    func map(state: AppState) -> ViewModel? {
        ViewModel(status: state.account.status)
    }

    @ViewBuilder
    func body(props viewModel: ViewModel) -> some View {
        switch viewModel.status {
        case .authenticated: ContentView()
        case .unauthenticated: SignInView()
        case .undetermined: Text("splash screen")
            .onAppear(dispatch: AccountAction.checkAccountStatus())
        }
    }

    struct ViewModel: Equatable {
        let status: AccountStatus
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
