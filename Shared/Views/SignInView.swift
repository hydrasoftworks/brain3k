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
        VStack(alignment: .center) {
            SignInWithAppleButton(
                .signIn,
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
        .padding()
    }

    struct ViewModel: Equatable {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
