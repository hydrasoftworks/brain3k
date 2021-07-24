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

        describe("\(AccountState.self) account") {
            it("should be returned when available") {
                var sut = AccountState(status: .authenticated(Account.test()))
                expect(sut.account).toNot(beNil())
                sut = AccountState(status: .unverifiedEmail(Account.test(emailVerified: false)))
                expect(sut.account).toNot(beNil())
            }

            it("nil should be returned otherwise") {
                var sut = AccountState(status: .undetermined)
                expect(sut.account).to(beNil())
                sut = AccountState(status: .unauthenticated)
                expect(sut.account).to(beNil())
            }
        }
    }
}
