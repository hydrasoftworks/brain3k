//
//  Created by Kamil Powałowski on 30/09/2021.
//

@testable import Brain3k
import Combine
import Cuckoo
import Nimble
import Quick
import SwiftDux

final class DeleteSpec: QuickSpec {
    override func spec() {
        describe("\(MemoriesAction.self) delete action") {
            var mock: MockMemoriesService!
            var cancellable: AnyCancellable?
            var state: AppState!
            var memory: Memory!

            beforeEach {
                mock = MockMemoriesService()
                state = AppState(
                    accountState: AccountState(
                        status: .authenticated(Account.test())
                    )
                )
                memory = Memory.test(type: .url, value: "https://example.com")
            }

            afterEach {
                cancellable?.cancel()
                cancellable = nil
            }

            context("when there is no account in state") {
                it("service shouldn't be called") {
                    let actionPlan = MemoriesAction.delete(memory: memory, mock)

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { _ in })

                    verify(mock, never()).deleteMemory(withId: anyString(), from: anyString())
                }
            }

            context("when there is no memory") {
                it("service shouldn't be called") {
                    let actionPlan = MemoriesAction.delete(memory: nil, mock)

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { _ in })

                    verify(mock, never()).deleteMemory(withId: anyString(), from: anyString())
                }
            }

            context("when request returns success") {
                beforeEach {
                    stub(mock) { stub in
                        when(stub.deleteMemory(withId: anyString(), from: anyString()))
                            .thenReturn(makeCombineResult(()))
                    }
                }

                it("should call deleteMemory(withId:from:) in service") {
                    let actionPlan = MemoriesAction.delete(memory: memory, mock)

                    cancellable = actionPlan.run(store: storeProxy(state))
                        .sink(receiveValue: { _ in })
                    verify(mock, times(1))
                        .deleteMemory(withId: equal(to: memory.id ?? ""), from: anyString())
                }
            }
        }
    }
}
