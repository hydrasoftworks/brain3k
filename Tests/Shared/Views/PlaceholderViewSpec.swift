//
//  Created by Kamil Powałowski on 24/07/2021.
//

@testable import Brain3k
import Nimble
import Quick
import SwiftUI
import ViewInspector

extension PlaceholderView: Inspectable {}

final class PlaceholderViewSpec: QuickSpec {
    override func spec() {
        var sut: PlaceholderView!
        let title = "Test Title"

        beforeEach {
            sut = PlaceholderView(title: title, color: .white)
        }
        describe("\(PlaceholderView.self)") {
            it("Should display ProgressView") {
                let view = try sut.inspect().find(ViewType.ProgressView.self)
                expect(view).toNot(beNil())
            }

            it("Should display provided title") {
                let viewTitle = try sut.inspect()
                    .find(ViewType.ProgressView.self)
                    .labelView()
                    .text()
                    .string()

                expect(viewTitle).to(be(title))
            }
        }
    }
}
