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

final class SendVerificationEmailSpec: QuickSpec {
    override func spec() {
        describe("\(AccountAction.self) sendVerificationEmail actions") {
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
                it("should not call sendVerificationEmail in service") {
                    let actionPlan = AccountAction.sendVerificationEmail(mock)

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { _ in })
                    verify(mock, never()).sendVerificationEmail(anyString())
                }
            }

            context("user in state") {
                var state: AppState!

                beforeEach {
                    state = AppState(
                        accountState: AccountState(
                            status: .unverifiedEmail(
                                User(
                                    email: "test@example.com",
                                    emailVerified: false
                                )
                            )
                        )
                    )
                }

                context("when operation returns success") {
                    beforeEach {
                        stub(mock) { stub in
                            when(stub.sendVerificationEmail(anyString()))
                                .thenReturn(makeCombineResult(()))
                        }
                    }

                    it("should call sendVerificationEmail in service") {
                        let actionPlan = AccountAction.sendVerificationEmail(mock)

                        cancellable = actionPlan.run(store: storeProxy(state))
                            .sink(receiveValue: { _ in })
                        verify(mock, times(1)).sendVerificationEmail(anyString())
                    }
                }

                context("when request returns error") {
                    var action: Action?

                    beforeEach {
                        stub(mock) { stub in
                            when(stub.sendVerificationEmail(anyString()))
                                .thenReturn(makeCombineError(Void.self))
                        }
                    }

                    it("should call message action") {
                        let actionPlan = AccountAction.sendVerificationEmail(mock)

                        cancellable = actionPlan.run(store: storeProxy(state))
                            .sink(receiveValue: { action = $0 })

                        expect(action).toEventually(beAKindOf(MessageAction.self))
                    }
                }
            }
        }
    }
}
