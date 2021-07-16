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
        describe("\(AccountAction.self) sendVerificationEmailSpec actions") {
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
                beforeEach {
                    stub(mock) { stub in
                        when(stub.sendVerificationEmail(any()))
                            .thenReturn(makeParseFuture(()))
                    }
                }

                it("should call sendVerificationEmail in service") {
                    let state = AppState(
                        accountState: AccountState(
                            status: .unverifiedEmail(
                                User(
                                    email: "test@example.com",
                                    emailVerified: false
                                )
                            )
                        )
                    )
                    let actionPlan = AccountAction.sendVerificationEmail(mock)

                    cancellable = actionPlan.run(store: storeProxy(state))
                        .sink(receiveValue: { _ in })
                    verify(mock, times(1)).sendVerificationEmail(anyString())
                }
            }
        }
    }
}
