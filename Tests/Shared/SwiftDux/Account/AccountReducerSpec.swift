//
//  Created by Kamil Powałowski on 12/07/2021.
//

@testable import Brain3k
import Nimble
import Quick

final class AccountReducerSpec: QuickSpec {
    override func spec() {
        describe("\(AccountReducer.self)") {
            var sut: AccountReducer!

            beforeEach {
                sut = AccountReducer()
            }

            context("\(AccountAction.self) setStatus") {
                it("should set status in state") {
                    let state = AccountState()
                    let result = sut.reduce(
                        state: state,
                        action: .setStatus(.unauthenticated)
                    )
                    expect(result.status).to(equal(.unauthenticated))
                }

                it("should change current state") {
                    let state = AccountState(status: .undetermined)
                    let result = sut.reduce(
                        state: state,
                        action: .setStatus(.unauthenticated)
                    )
                    expect(result.status).to(equal(.unauthenticated))
                }
            }
        }
    }
}
