//
//  Created by Kamil Powałowski on 16/07/2021.
//

@testable import Brain3k
import Combine
import Cuckoo
import Nimble
import Quick
import SwiftDux

extension StoreAction: Equatable where State == AppState {
    public static func == (lhs: StoreAction, rhs: StoreAction) -> Bool {
        switch (lhs, rhs) {
        case (.prepare, .prepare): return true
        case let (.reset(lhsState), .reset(rhsState)): return lhsState == rhsState
        default: return false
        }
    }
}

final class SignOutSpec: QuickSpec {
    override func spec() {
        describe("\(AccountAction.self) signOut actions") {
            var mock: MockAccountService!
            var actions: [StoreAction<AppState>?] = []
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

            it("should clean state") {
                let actionPlan = AccountAction.signOut(mock)

                cancellable = actionPlan.run(store: storeProxy())
                    .sink(receiveValue: { actions.append($0 as? StoreAction<AppState>) })
                expect(actions).toEventually(
                    contain(StoreAction.reset(state: AppState()))
                )
            }

            context("when request returns error") {
                beforeEach {
                    stub(mock) { stub in
                        when(stub.signOut())
                            .thenReturn(makeCombineError(Void.self))
                    }
                }

                it("should clean state as well") {
                    let actionPlan = AccountAction.signOut(mock)

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { actions.append($0 as? StoreAction<AppState>) })
                    expect(actions).toEventually(
                        contain(StoreAction.reset(state: AppState()))
                    )
                }
            }
        }
    }
}
