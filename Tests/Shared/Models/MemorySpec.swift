//
//  Created by Kamil Powałowski on 04/08/2021.
//

@testable import Brain3k
import Nimble
import Quick

final class MemorySpec: QuickSpec {
    override func spec() {
        describe("\(Memory.self)") {
            it("Should map value to URL") {
                let memory = Memory.test(
                    type: .url,
                    value: "https://example.com"
                )
                expect(memory.valueURL?.absoluteString)
                    .to(equal(memory.value))
            }

            it("Should map thumbnail to URL") {
                let memory = Memory.test(
                    type: .url,
                    value: "https://example.com",
                    thumbnail: "https://example.com/thumbnail"
                )
                expect(memory.thumbnailURL?.absoluteString)
                    .to(equal(memory.thumbnail))
            }
        }
    }
}
