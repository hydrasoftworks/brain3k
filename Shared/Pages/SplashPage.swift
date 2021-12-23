//
//  Created by Kamil Powałowski on 30/06/2021.
//

import SwiftDux
import SwiftUI

struct SplashPage: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    func map(state: AppState, binder: ActionBinder) -> ViewModel? {
        let hasErrorMessage: Bool = {
            switch state.messageState.message {
            case .error: return true
            case .purchase,
                 .none:
                return false
            }
        }()
        return ViewModel(
            status: state.accountState.status,
            hasErrorMessage: binder.bind(hasErrorMessage) { _ in MessageAction.clear },
            message: state.messageState.message
        )
    }

    func body(props viewModel: ViewModel) -> some View {
        Group {
            switch viewModel.status {
            case .authenticated: HomePage()
            case .unauthenticated: JoinPage()
            case .unverifiedEmail: UnverifiedEmailPage()
            case .undetermined: Text("splash screen")
                .onAppear(dispatch: AccountAction.checkAccountStatus())
            }
        }
        .alert(
            L10n.General.Error.title,
            isPresented: viewModel.$hasErrorMessage,
            presenting: viewModel.message,
            actions: { _ in
                Button(L10n.General.ok, role: .cancel, action: {})
            },
            message: { Text($0.text) }
        )
    }

    struct ViewModel: Equatable {
        let status: AccountStatus
        @ActionBinding var hasErrorMessage: Bool
        let message: Message?
    }
}
