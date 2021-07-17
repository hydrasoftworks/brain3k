//
//  Created by Kamil Powałowski on 15/07/2021.
//

@testable import Brain3k
import Combine
import Cuckoo
import Nimble
import ParseSwift
import Quick
import SwiftDux

final class SignInSpec: QuickSpec {
    override func spec() {
        describe("\(AccountAction.self) signIn actions") {
            var mock: MockAccountService!
            var user: User!
            var action: AccountAction?
            var cancellable: AnyCancellable?

            beforeEach {
                user = User(emailVerified: true)
                mock = MockAccountService()
            }

            afterEach {
                cancellable?.cancel()
                cancellable = nil
            }

            context("sign in with email and password") {
                beforeEach {
                    stub(mock) { stub in
                        when(stub.login(email: anyString(), password: anyString()))
                            .thenReturn(makeCombineResult(user))
                    }
                }

                it("should call setStatus .authenticated action") {
                    let actionPlan = AccountAction.signIn(
                        withEmail: "test@example.com",
                        andPassword: "password123",
                        mock
                    )

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { action = $0 as? AccountAction })
                    expect(action).toEventually(equal(AccountAction.setStatus(.authenticated(user))))
                }
            }

            context("when request returns error") {
                var action: Action?

                beforeEach {
                    stub(mock) { stub in
                        when(stub.login(email: anyString(), password: anyString()))
                            .thenReturn(makeCombineError(User.self))
                    }
                }

                it("should call message action") {
                    let actionPlan = AccountAction.signIn(
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
