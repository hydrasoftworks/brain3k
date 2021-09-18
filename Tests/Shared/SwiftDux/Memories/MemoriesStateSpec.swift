//
//  Created by Kamil Powałowski on 15/09/2021.
//

@testable import Brain3k
import Nimble
import Quick

final class MemoriesStateSpec: QuickSpec {
    override func spec() {
        describe("\(MemoriesState.self) initial state") {
            var sut: MemoriesState!

            let memories = [
                Memory.test(type: .url, value: "https://example.com"),
                Memory.test(type: .image, value: "https://example.com/file.png"),
                Memory.test(type: .url, value: "https://example.com"),
            ]

            beforeEach {
                sut = MemoriesState()
            }

            it("should have empty array of all memories") {
                expect(sut.all).to(beEmpty())
            }

            it("should have nil as filtered memories - filtering not active") {
                expect(sut.filtered).to(beNil())
            }

            it("copyWith should set properties") {
                let all = memories
                let filtered = Array(memories.suffix(2))
                sut = sut.copyWith(all: all, filtered: filtered)
                expect(sut.all).to(equal(all))
                expect(sut.filtered).to(equal(filtered))
            }

            it("copyWithNil should clear properties") {
                sut = sut.copyWith(filtered: memories)
                sut = sut.copyWithNil(filtered: true)
                expect(sut.filtered).to(beNil())
            }
        }
    }
}
