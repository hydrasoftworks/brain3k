//
//  Created by Kamil Powałowski on 16/07/2021.
//

@testable import Brain3k
import Combine
import Cuckoo
import Nimble
import Quick
import SwiftDux

final class SignOutSpec: QuickSpec {
    override func spec() {
        describe("\(AccountAction.self) signOut actions") {
            var mock: MockAccountService!
            var actions: [AccountAction?] = []
            var cancellable: AnyCancellable?

            beforeEach {
                mock = MockAccountService()
                stub(mock) { stub in
                    when(stub.signOut())
                        .thenReturn(makeCombineResult(()))
                }
                actions.removeAll()
            }

            afterEach {
                cancellable?.cancel()
                cancellable = nil
            }

            it("should call setStatus(.unauthenticated) and setUser(nil) action") {
                let actionPlan = AccountAction.signOut(mock)

                cancellable = actionPlan.run(store: storeProxy())
                    .sink(receiveValue: { actions.append($0 as? AccountAction) })
                expect(actions).toEventually(
                    contain(
                        [
                            AccountAction.setStatus(.unauthenticated),
                            AccountAction.setUser(nil),
                        ]
                    )
                )
            }

            context("when request returns error") {
                beforeEach {
                    stub(mock) { stub in
                        when(stub.signOut())
                            .thenReturn(makeCombineError(Void.self))
                    }
                }

                it("should call setStatus(.unauthenticated) and setUser(nil) action as well") {
                    let actionPlan = AccountAction.signOut(mock)

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { actions.append($0 as? AccountAction) })
                    expect(actions).toEventually(
                        contain(
                            [
                                AccountAction.setStatus(.unauthenticated),
                                AccountAction.setUser(nil),
                            ]
                        )
                    )
                }
            }
        }
    }
}
