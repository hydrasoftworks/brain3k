//
//  Created by Kamil Powałowski on 30/06/2021.
//

import SwiftDux
import SwiftUI

struct SplashPage: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    func map(state: AppState, binder: ActionBinder) -> ViewModel? {
        let hasMessage: Bool = {
            switch state.messageState.message {
            case .error, .info: return true
            case .purchase,
                 .none:
                return false
            }
        }()
        return ViewModel(
            status: state.accountState.status,
            hasMessage: binder.bind(hasMessage) { _ in MessageAction.clear },
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
            viewModel.alertTitle,
            isPresented: viewModel.$hasMessage,
            presenting: viewModel.message,
            actions: { _ in
                Button(L10n.General.ok, role: .cancel, action: {})
            },
            message: { Text($0.text) }
        )
    }

    struct ViewModel: Equatable {
        let status: AccountStatus
        @ActionBinding var hasMessage: Bool
        let message: Message?

        var alertTitle: String {
            switch message {
            case .error: return L10n.Alerts.Error.title
            case .info: return L10n.Alerts.Info.title
            case .purchase, .none: return ""
            }
        }
    }
}
