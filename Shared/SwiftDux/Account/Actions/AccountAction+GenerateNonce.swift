//
//  Created by Kamil Powałowski on 27/09/2021.
//

import CryptoKit
import Foundation
import SwiftDux

extension AccountAction {
    static func generateNonce(
        _: AccountService = AccountService()
    ) -> ActionPlan<AppState> {
        ActionPlan<AppState> { store in
            let nonce = Data(ChaChaPoly.Nonce()).base64EncodedString()
            store.send(AccountAction.setNonce(nonce))
        }
    }
}
