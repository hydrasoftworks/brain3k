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
                    let state: [Memory] = []
                    let result = sut.reduce(
                        state: state,
                        action: .set(memories)
                    )
                    expect(result).to(equal(memories))
                }
            }
        }
    }
}
