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

final class RefreshSpec: QuickSpec {
    override func spec() {
        describe("\(AccountAction.self) refresh actions") {
            var mock: MockAccountService!
            var cancellable: AnyCancellable?

            beforeEach {
                mock = MockAccountService()
            }

            afterEach {
                cancellable?.cancel()
                cancellable = nil
            }

            context("user not in state") {
                it("should not call refresh in service") {
                    let actionPlan = AccountAction.refresh(mock)

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { _ in })
                    verify(mock, never()).refresh(any())
                }
            }

            context("user in state") {
                var action: AccountAction?
                var user: User!
                var state: AppState!

                beforeEach {
                    user = User(emailVerified: true)
                    state = AppState(
                        accountState: AccountState(
                            status: .unverifiedEmail(User(emailVerified: false))
                        )
                    )
                    stub(mock) { stub in
                        when(stub.refresh(any()))
                            .thenReturn(makeCombineResult(user))
                    }
                }

                it("should check verification and call setStatus .authenticated action") {
                    let actionPlan = AccountAction.refresh(mock)

                    cancellable = actionPlan.run(store: storeProxy(state))
                        .sink(receiveValue: { action = $0 as? AccountAction })
                    expect(action).toEventually(equal(AccountAction.setStatus(.authenticated(user))))
                }

                context("when request returns error") {
                    var action: Action?

                    beforeEach {
                        stub(mock) { stub in
                            when(stub.refresh(any()))
                                .thenReturn(makeCombineError(User.self))
                        }
                    }

                    it("should call message action") {
                        let actionPlan = AccountAction.refresh(mock)

                        cancellable = actionPlan.run(store: storeProxy(state))
                            .sink(receiveValue: { action = $0 })

                        expect(action).toEventually(beAKindOf(MessageAction.self))
                    }
                }
            }
        }
    }
}
