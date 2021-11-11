//
//  Created by Kamil Powałowski on 29/06/2021.
//

import CryptoKit
import Foundation

struct AccountState: StateType {
    let status: AccountStatus
    let nonce: String?
    let user: User?

    var account: Account? {
        switch status {
        case let .authenticated(account),
             let .unverifiedEmail(account): return account
        case .unauthenticated,
             .undetermined: return nil
        }
    }

    var sha256Nonce: String? {
        guard let nonce = nonce else { return nil }

        let inputData = Data(nonce.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()

        return hashString
    }

    init(
        status: AccountStatus = .undetermined,
        nonce: String? = nil,
        user: User? = nil
    ) {
        self.status = status
        self.nonce = nonce
        self.user = user
    }

    func copyWith(
        status: AccountStatus? = nil,
        nonce: String? = nil,
        user: User? = nil
    ) -> AccountState {
        AccountState(
            status: status ?? self.status,
            nonce: nonce ?? self.nonce,
            user: user ?? self.user
        )
    }

    func copyWithNil(
        user: Bool = false
    ) -> AccountState {
        AccountState(
            status: status,
            nonce: nonce,
            user: user ? nil : self.user
        )
    }
}
