//
//  Created by Kamil Powałowski on 25/07/2021.
//

@testable import Brain3k
import Combine
import Cuckoo
import Nimble
import Quick
import SwiftDux

final class CreateURLSpec: QuickSpec {
    override func spec() {
        describe("\(MemoriesAction.self) createURL action") {
            var mock: MockMemoriesService!
            var cancellable: AnyCancellable?
            var state: AppState!

            beforeEach {
                mock = MockMemoriesService()
                state = AppState(
                    accountState: AccountState(
                        status: .authenticated(Account.test())
                    )
                )
            }

            afterEach {
                cancellable?.cancel()
                cancellable = nil
            }

            context("when there is no account in state") {
                it("service shouldn't be called") {
                    let actionPlan = MemoriesAction.createURL(url: "https://example.com", mock)

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { _ in })

                    verify(mock, never()).getAll(for: anyString())
                }
            }

            context("when request returns success") {
                var memory: Memory!

                beforeEach {
                    memory = Memory.test(type: .url, value: "https://example.com")
                    stub(mock) { stub in
                        when(stub.add(memory: any(), to: anyString()))
                            .thenReturn(makeCombineResult(()))
                    }
                }

                it("should call add(memory:to:) in service") {
                    let actionPlan = MemoriesAction.createURL(url: memory.value, mock)

                    cancellable = actionPlan.run(store: storeProxy(state))
                        .sink(receiveValue: { _ in })
                    verify(mock, times(1)).add(memory: any(), to: anyString())
                }
            }

            context("when request returns error") {
                var action: Action?

                beforeEach {
                    stub(mock) { stub in
                        when(stub.add(memory: any(), to: anyString()))
                            .thenReturn(makeCombineError(Void.self))
                    }
                }

                it("should call message action") {
                    let actionPlan = MemoriesAction.createURL(url: "https://example.com", mock)

                    cancellable = actionPlan.run(store: storeProxy(state))
                        .sink(receiveValue: { action = $0 })

                    expect(action).toEventually(beAKindOf(MessageAction.self))
                }
            }
        }
    }
}
