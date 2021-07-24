//
//  Created by Kamil Powałowski on 15/07/2021.
//

@testable import Brain3k
import Nimble
import Quick

final class AccountActionSpec: QuickSpec {
    override func spec() {
        describe("\(AccountAction.self) accountAction") {
            context("gets verified user") {
                it("should return setStatus .authenticated action") {
                    let account = Account.test()
                    let action = AccountAction.accountAction(for: account)
                    expect(action).to(equal(AccountAction.setStatus(.authenticated(account))))
                }
            }

            context("gets unverified user") {
                it("should return setStatus .unverifiedEmail action") {
                    let account = Account.test(emailVerified: false)
                    let action = AccountAction.accountAction(for: account)
                    expect(action).to(equal(AccountAction.setStatus(.unverifiedEmail(account))))
                }
            }
        }
    }
}
