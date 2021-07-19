//
//  Created by Kamil Powałowski on 30/06/2021.
//

import SwiftDux
import SwiftUI

struct SplashPage: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    func map(state: AppState, binder: ActionBinder) -> ViewModel? {
        ViewModel(
            status: state.accountState.status,
            hasMessage: binder.bind(state.messageState.message != nil) { _ in MessageAction.clear },
            message: state.messageState.message
        )
    }

    @ViewBuilder
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
            "An error occurred.",
            isPresented: viewModel.$hasMessage,
            presenting: viewModel.message,
            actions: { _ in
                Button("OK", role: .cancel, action: {})
            },
            message: { message in
                switch message {
                case let .error(text): Text(text)
                }
            }
        )
    }

    struct ViewModel: Equatable {
        let status: AccountStatus
        @ActionBinding var hasMessage: Bool
        let message: Message?

        var messageText: String? {
            switch message {
            case let .error(text): return text
            case .none: return nil
            }
        }
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
