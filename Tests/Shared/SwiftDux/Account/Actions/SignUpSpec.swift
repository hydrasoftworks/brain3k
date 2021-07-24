//
//  Created by Kamil Powałowski on 16/07/2021.
//

@testable import Brain3k
import Combine
import Cuckoo
import Nimble
import Quick
import SwiftDux

final class SignUpSpec: QuickSpec {
    override func spec() {
        describe("\(AccountAction.self) signUp actions") {
            var mock: MockAccountService!
            var account: Account!
            var action: AccountAction?
            var cancellable: AnyCancellable?

            beforeEach {
                account = Account.test()
                mock = MockAccountService()
            }

            afterEach {
                cancellable?.cancel()
                cancellable = nil
            }

            context("sign up with email and password") {
                beforeEach {
                    stub(mock) { stub in
                        when(stub.signUp(email: anyString(), password: anyString()))
                            .thenReturn(makeCombineResult(account))
                    }
                }

                it("should call setStatus .unverifiedEmail action") {
                    let actionPlan = AccountAction.signUp(
                        withEmail: "test@example.com",
                        andPassword: "password123",
                        mock
                    )

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { action = $0 as? AccountAction })
                    expect(action).toEventually(equal(AccountAction.setStatus(.unverifiedEmail(account))))
                }
            }

            context("when request returns error") {
                var action: Action?

                beforeEach {
                    stub(mock) { stub in
                        when(stub.signUp(email: anyString(), password: anyString()))
                            .thenReturn(makeCombineError(Account.self))
                    }
                }

                it("should call message action") {
                    let actionPlan = AccountAction.signUp(
                        withEmail: "test@example.com",
                        andPassword: "password123",
                        mock
                    )

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { action = $0 })

                    expect(action).toEventually(beAKindOf(MessageAction.self))
                }
            }
        }
    }
}
