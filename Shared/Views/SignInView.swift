//
//  Created by Kamil Powałowski on 27/06/2021.
//

import AuthenticationServices
import SwiftDux
import SwiftUI

struct SignInView: ConnectableView {
    @Environment(\.actionDispatcher) private var dispatch

    func map(state _: AppState) -> ViewModel? {
        ViewModel()
    }

    func body(props _: ViewModel) -> some View {
        ZStack {
            background
            content
        }
    }

    private var background: some View {
        Image("background")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .frame(minWidth: 0, maxWidth: .infinity)
    }

    private var content: some View {
        VStack(spacing: 16) {
            Text("Welcome (back)")
                .font(.title)
                .bold()
                .foregroundStyle(
                    .linearGradient(
                        colors: [.purple, .blue],
                        startPoint: .bottomLeading,
                        endPoint: .topTrailing
                    )
                )
            Text("Sign in now and start using your new digital brain.")
                .font(.body)
                .multilineTextAlignment(.center)
            signInWithAppleButton
        }
        .padding()
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 16)
        )
        .padding()
    }

    private var signInWithAppleButton: some View {
        SignInWithAppleButton(
            .continue,
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case let .success(authorization):
                    dispatch.send(AccountAction.signIn(authorization))
                case let .failure(error):
                    log.error("Authorization failed: " + error.localizedDescription)
                }
            }
        )
        .frame(height: 60)
    }

    struct ViewModel: Equatable {}
}

struct SignInView_Previews: PreviewProvider {
    private static var store: Store<AppState> {
        Store(
            state: AppState(),
            reducer: AppReducer()
        )
    }

    static var previews: some View {
        SignInView()
            .provideStore(store)
    }
}
