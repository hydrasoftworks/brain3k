//
//  Created by Kamil Powałowski on 24/07/2021.
//

@testable import Brain3k
import Nimble
import Quick
import SwiftUI
import ViewInspector

extension ProcessingCell: Inspectable {}
extension MemoryCell: Inspectable {}

final class MemoryCellSpec: QuickSpec {
    override func spec() {
        describe("\(MemoryCellSpec.self)") {
            context("unprocessed cell") {
                it("Should return URLMemoryCell for memory type url") {
                    let sut = MemoryCell(
                        memory: Memory.test(
                            type: .url,
                            value: "https://example.com",
                            processed: false
                        )
                    )
                    let view = try sut.inspect().find(ProcessingCell.self)
                    expect(view).toNot(beNil())
                }
            }

            context("processed cell") {
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
}
