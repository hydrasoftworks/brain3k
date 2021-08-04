//
//  Created by Kamil Powałowski on 04/08/2021.
//

@testable import Brain3k
import Nimble
import Quick

final class MemorySpec: QuickSpec {
    override func spec() {
        describe("\(Memory.self)") {
            it("Should be unprocessed when tags are nil") {
                let memory = Memory.test(
                    type: .url,
                    value: "https://example.com",
                    processed: false
                )
                expect(memory.tags).to(beNil())
                expect(memory.processed).to(beFalse())
            }

            it("Should be unprocessed when tags are nil") {
                let memory = Memory.test(
                    type: .url,
                    value: "https://example.com",
                    processed: true
                )
                expect(memory.tags).toNot(beNil())
                expect(memory.processed).to(beTrue())
            }
        }
    }
}
