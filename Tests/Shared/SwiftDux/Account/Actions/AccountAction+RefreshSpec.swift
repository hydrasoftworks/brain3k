//
//  Created by Kamil Powałowski on 16/07/2021.
//

@testable import Brain3k
import Combine
import Cuckoo
import Nimble
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
                    verify(mock, never()).refresh()
                }
            }

            context("user in state") {
                var action: AccountAction?
                var account: Account!
                var state: AppState!

                beforeEach {
                    account = Account.test()
                    state = AppState(
                        accountState: AccountState(
                            status: .unverifiedEmail(Account.test(emailVerified: false))
                        )
                    )
                    stub(mock) { stub in
                        when(stub.refresh())
                            .thenReturn(makeCombineResult(account))
                    }
                }

                it("should check verification and call setStatus .authenticated action") {
                    let actionPlan = AccountAction.refresh(mock)

                    cancellable = actionPlan.run(store: storeProxy(state))
                        .sink(receiveValue: { action = $0 as? AccountAction })
                    expect(action).toEventually(equal(AccountAction.setStatus(.authenticated(account))))
                }

                context("when request returns error") {
                    var action: Action?

                    beforeEach {
                        stub(mock) { stub in
                            when(stub.refresh())
                                .thenReturn(makeCombineError(Account.self))
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
