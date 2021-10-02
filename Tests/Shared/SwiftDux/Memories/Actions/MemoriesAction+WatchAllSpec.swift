//
//  Created by Kamil Powałowski on 12/08/2021.
//

@testable import Brain3k
import Combine
import Cuckoo
import Nimble
import Quick
import SwiftDux

final class WatchAllSpec: QuickSpec {
    override func spec() {
        describe("\(MemoriesAction.self) watchAll action") {
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
                    let actionPlan = MemoriesAction.watchAll(mock)

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { _ in })

                    verify(mock, never()).watchAll(for: anyString())
                }
            }

            context("when request returns success") {
                var action: MemoriesAction?
                var memories: [Memory]!

                beforeEach {
                    memories = [
                        Memory.test(type: .url, value: "https://example.com"),
                        Memory.test(type: .image, value: "https://example.com/file.png"),
                        Memory.test(type: .url, value: "https://example.com"),
                    ]
                    stub(mock) { stub in
                        when(stub.watchAll(for: anyString()))
                            .thenReturn(makeCombineResult(memories))
                    }
                }

                it("should call set action") {
                    let actionPlan = MemoriesAction.watchAll(mock)

                    cancellable = actionPlan.run(store: storeProxy(state))
                        .sink(receiveValue: { action = $0 as? MemoriesAction })

                    expect(action).toEventually(equal(MemoriesAction.set(memories)))
                }
            }

            context("when request returns error") {
                var action: Action?

                beforeEach {
                    stub(mock) { stub in
                        when(stub.watchAll(for: anyString()))
                            .thenReturn(makeCombineError([Memory].self))
                    }
                }

                it("should call message action") {
                    let actionPlan = MemoriesAction.watchAll(mock)

                    cancellable = actionPlan.run(store: storeProxy(state))
                        .sink(receiveValue: { action = $0 })

                    expect(action).toEventually(beAKindOf(MessageAction.self))
                }
            }
        }
    }
}
