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

final class SignOutSpec: QuickSpec {
    override func spec() {
        describe("\(AccountAction.self) signOut actions") {
            var mock: MockAccountService!
            var action: AccountAction?
            var cancellable: AnyCancellable?

            beforeEach {
                mock = MockAccountService()
                stub(mock) { stub in
                    when(stub.signOut())
                        .thenReturn(makeParseFuture(()))
                }
            }

            afterEach {
                cancellable?.cancel()
                cancellable = nil
            }

            it("should call setStatus .unauthenticated action") {
                let actionPlan = AccountAction.signOut(mock)

                cancellable = actionPlan.run(store: storeProxy())
                    .sink(receiveValue: { action = $0 as? AccountAction })
                expect(action).toEventually(equal(AccountAction.setStatus(.unauthenticated)))
            }
        }
    }
}
