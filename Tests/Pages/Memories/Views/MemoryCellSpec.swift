//
//  Created by Kamil Powałowski on 24/07/2021.
//

@testable import Brain3k
import Nimble
import Quick
import SwiftUI
import ViewInspector

extension MemoryCell: Inspectable {}

final class MemoryCellSpec: QuickSpec {
    override func spec() {
        describe("\(MemoryCellSpec.self)") {
            it("Should return URLMemoryCell for memory type url") {
                let sut = MemoryCell(
                    memory: Memory.test(type: .url, value: "https://example.com")
                )
                let view = try sut.inspect().find(URLMemoryCell.self)
                expect(view).toNot(beNil())
            }
        }
    }
}
