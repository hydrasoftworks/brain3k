//
//  Created by Kamil Powałowski on 17/07/2021.
//

@testable import Brain3k
import Nimble
import Quick
import SwiftDux

final class MemoriesReducerSpec: QuickSpec {
    override func spec() {
        describe("\(MemoriesReducer.self)") {
            var sut: MemoriesReducer!

            beforeEach {
                sut = MemoriesReducer()
            }

            context("\(MemoriesAction.self) set") {
                it("should set memories in state") {
                    let memories = [
                        Memory.test(type: .url, value: "https://example.com"),
                        Memory.test(type: .image, value: "https://example.com/file.png"),
                        Memory.test(type: .url, value: "https://example.com"),
                    ]
                    let state = MemoriesState()
                    let result = sut.reduce(
                        state: state,
                        action: .set(memories)
                    )
                    expect(result.all).to(equal(memories))
                }
            }

            context("\(MemoriesAction.self) setFiltered") {
                it("should set memories as filtered") {
                    let memories = [
                        Memory.test(type: .url, value: "https://example.com"),
                        Memory.test(type: .image, value: "https://example.com/file.png"),
                        Memory.test(type: .url, value: "https://example.com"),
                    ]
                    let state = MemoriesState()
                    let result = sut.reduce(
                        state: state,
                        action: .setFiltered(memories)
                    )
                    expect(result.filtered).to(equal(memories))
                }
            }

            context("\(MemoriesAction.self) clearFiltered") {
                it("should set nil to filtered memories") {
                    let memories = [
                        Memory.test(type: .url, value: "https://example.com"),
                        Memory.test(type: .image, value: "https://example.com/file.png"),
                        Memory.test(type: .url, value: "https://example.com"),
                    ]
                    let state = MemoriesState(filtered: memories)
                    let result = sut.reduce(
                        state: state,
                        action: .clearFiltered
                    )
                    expect(result.filtered).to(beNil())
                }
            }
        }
    }
}
