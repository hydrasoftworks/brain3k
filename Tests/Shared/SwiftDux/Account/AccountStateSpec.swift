//
//  Created by Kamil Powałowski on 12/07/2021.
//

@testable import Brain3k
import Nimble
import Quick

final class AccountStateSpec: QuickSpec {
    override func spec() {
        describe("\(AccountState.self) initial state") {
            var sut: AccountState!

            beforeEach {
                sut = AccountState()
            }

            it("should have undetermined status") {
                expect(sut.status).to(equal(.undetermined))
            }
        }

        describe("\(AccountState.self) user") {
            it("should be returned when available") {
                var sut = AccountState(status: .authenticated(User()))
                expect(sut.user).toNot(beNil())
                sut = AccountState(status: .unverifiedEmail(User()))
                expect(sut.user).toNot(beNil())
            }

            it("nil should be returned otherwise") {
                var sut = AccountState(status: .undetermined)
                expect(sut.user).to(beNil())
                sut = AccountState(status: .unauthenticated)
                expect(sut.user).to(beNil())
            }
        }
    }
}
