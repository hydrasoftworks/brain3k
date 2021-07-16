//
//  Created by Kamil Powałowski on 15/07/2021.
//

@testable import Brain3k
import Combine
import Cuckoo
import Nimble
import Quick
import SwiftDux

final class CheckAccountStatusSpec: QuickSpec {
    override func spec() {
        describe("\(AccountAction.self) checkAccountStatus") {
            var mock: MockAccountService!
            var action: AccountAction?

            beforeEach {
                mock = MockAccountService()
            }

            context("user not exists") {
                it("should call setStatus .unauthenticated action") {
                    stub(mock) { stub in
                        when(stub.getCurrentUser()).thenReturn(nil)
                    }
                    let actionPlan = AccountAction.checkAccountStatus(mock)
                    _ = actionPlan.run(store: storeProxy(send: { action = $0 as? AccountAction }))
                    expect(action).toEventually(equal(AccountAction.setStatus(.unauthenticated)))
                }
            }

            context("user exists") {
                it("should return setStatus .authenticated action") {
                    let user = User(emailVerified: true)
                    stub(mock) { stub in
                        when(stub.getCurrentUser()).thenReturn(user)
                    }

                    let actionPlan = AccountAction.checkAccountStatus(mock)
                    _ = actionPlan.run(store: storeProxy(send: { action = $0 as? AccountAction }))
                    expect(action).toEventually(equal(AccountAction.setStatus(.authenticated(user))))
                }
            }
        }
    }
}
