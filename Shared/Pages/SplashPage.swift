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
        case .unverifiedEmail: UnverifiedEmailPage()
        case .undetermined: Text("splash screen")
            .onAppear(dispatch: AccountAction.checkAccountStatus())
        }
    }

    struct ViewModel: Equatable {
        let status: AccountStatus
    }
}

struct SplashScreen_Previews: PreviewProvider {
    private static var store: Store<AppState> {
        Store(
            state: AppState(),
            reducer: AppReducer()
        )
    }

    static var previews: some View {
        SplashPage()
            .provideStore(store)
    }
}
