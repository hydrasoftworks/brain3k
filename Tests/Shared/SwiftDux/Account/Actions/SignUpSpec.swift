//
//  Created by Kamil Powałowski on 16/07/2021.
//

@testable import Brain3k
import Combine
import Cuckoo
import Nimble
import ParseSwift
import Quick
import SwiftDux

final class SignUpSpec: QuickSpec {
    override func spec() {
        describe("\(AccountAction.self) signUp actions") {
            var mock: MockAccountService!
            var user: User!
            var action: AccountAction?
            var cancellable: AnyCancellable?

            beforeEach {
                user = User(emailVerified: false)
                mock = MockAccountService()
                stub(mock) { stub in
                    when(stub.signUp(email: anyString(), password: anyString()))
                        .thenReturn(makeParseFuture(user))
                    when(stub.save(any()))
                        .thenReturn(makeParseFuture(user))
                }
            }

            afterEach {
                cancellable?.cancel()
                cancellable = nil
            }

            context("sign up with email and password") {
                it("should call setStatus .unverifiedEmail action") {
                    let actionPlan = AccountAction.signUp(
                        withEmail: "test@example.com",
                        andPassword: "password123",
                        mock
                    )

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { action = $0 as? AccountAction })
                    expect(action).toEventually(equal(AccountAction.setStatus(.unverifiedEmail(user))))
                }
            }
        }
    }
}
