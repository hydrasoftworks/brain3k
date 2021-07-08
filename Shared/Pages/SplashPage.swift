//
//  Created by Kamil Powałowski on 30/06/2021.
//

import SwiftDux
import SwiftUI

struct SplashPage: ConnectableView {
    func map(state: AppState) -> ViewModel? {
        ViewModel(status: state.account.status)
    }

    @ViewBuilder
    func body(props viewModel: ViewModel) -> some View {
        switch viewModel.status {
        case .authenticated: ContentPage()
        case .unauthenticated: JoinPage()
        case .emailVerificationNeeded: Text("email verification")
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
        SplashPage()
    }
}
