//
//  Created by Kamil Powałowski on 17/07/2021.
//

@testable import Brain3k
import Combine
import Cuckoo
import Nimble
import Quick
import SwiftDux

final class GetAllSpec: QuickSpec {
    override func spec() {
        describe("\(MemoriesAction.self) getAll action") {
            var mock: MockMemoriesService!
            var cancellable: AnyCancellable?

            beforeEach {
                mock = MockMemoriesService()
            }

            afterEach {
                cancellable?.cancel()
                cancellable = nil
            }

            context("when request returns success") {
                var action: MemoriesAction?
                var memories: [Memory]!

                beforeEach {
                    memories = [
                        Memory(objectId: "1", type: .url, value: "https://example.com"),
                        Memory(objectId: "2", type: .image, value: "https://example.com/file.png"),
                        Memory(objectId: "3", type: .url, value: "https://example.com"),
                    ]
                    stub(mock) { stub in
                        when(stub.getAll()).thenReturn(makeCombineResult(memories))
                    }
                }

                it("should call set action") {
                    let actionPlan = MemoriesAction.getAll(mock)

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { action = $0 as? MemoriesAction })

                    expect(action).toEventually(equal(MemoriesAction.set(memories)))
                }
            }

            context("when request returns error") {
                var action: Action?

                beforeEach {
                    stub(mock) { stub in
                        when(stub.getAll()).thenReturn(makeCombineError([Memory].self))
                    }
                }

                it("should call message action") {
                    let actionPlan = MemoriesAction.getAll(mock)

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { action = $0 })

                    expect(action).toEventually(beAKindOf(MessageAction.self))
                }
            }
        }
    }
}
