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
                    let user = User(emailVerified: true)
                    let action = AccountAction.accountAction(for: user)
                    expect(action).to(equal(AccountAction.setStatus(.authenticated(user))))
                }
            }

            context("gets unverified user") {
                it("should return setStatus .unverifiedEmail action") {
                    let user = User(emailVerified: false)
                    let action = AccountAction.accountAction(for: user)
                    expect(action).to(equal(AccountAction.setStatus(.unverifiedEmail(user))))
                }
            }
        }
    }
}
