//
//  Created by Kamil Powałowski on 15/09/2021.
//

@testable import Brain3k
import Combine
import Cuckoo
import Nimble
import Quick
import SwiftDux

final class SearchSpec: QuickSpec {
    override func spec() {
        describe("\(MemoriesAction.self) search(for:) action") {
            var mock: MockMemoriesService!
            var cancellable: AnyCancellable?
            var state: AppState!
            var filtered: [Memory]!

            beforeEach {
                state = AppState(
                    memoriesState: MemoriesState(
                        all: [
                            Memory.test(type: .url, value: "https://example.com"),
                            Memory.test(type: .image, value: "https://example.com/file.png"),
                            Memory.test(type: .url, value: "https://example.com"),
                        ]
                    )
                )

                mock = MockMemoriesService()
                filtered = Array(state.memoriesState.all.suffix(2))
                stub(mock) { stub in
                    when(stub.search(for: anyString(), in: any()))
                        .thenReturn(makeCombineResult(filtered))
                }
            }

            afterEach {
                cancellable?.cancel()
                cancellable = nil
            }

            it("should call service with correct query and items from state") {
                let actionPlan = MemoriesAction.search(for: "query", mock)

                cancellable = actionPlan.run(store: storeProxy(state))
                    .sink(receiveValue: { _ in })

                verify(mock, times(1))
                    .search(for: equal(to: "query"), in: equal(to: state.memoriesState.all))
            }

            it("should set result as filtered memories and update query") {
                var actions = [MemoriesAction?]()

                let actionPlan = MemoriesAction.search(for: "query", mock)

                cancellable = actionPlan.run(store: storeProxy(state))
                    .sink(receiveValue: { actions.append($0 as? MemoriesAction) })

                expect(actions).toEventually(
                    contain(
                        MemoriesAction.setSearchQuery("query"),
                        MemoriesAction.setFiltered(filtered)
                    )
                )
            }

            it("should clear data when query is empty") {
                var actions = [MemoriesAction?]()

                let actionPlan = MemoriesAction.search(for: "", mock)

                _ = actionPlan.run(
                    store: storeProxy(
                        state: state,
                        send: { actions.append($0 as? MemoriesAction) }
                    )
                )

                expect(actions).toEventually(
                    contain(
                        MemoriesAction.setSearchQuery(""),
                        MemoriesAction.clearFiltered
                    )
                )
            }
        }
    }
}
