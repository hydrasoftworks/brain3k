//
//  Created by Kamil Powałowski on 24/07/2021.
//

@testable import Brain3k
import Nimble
import Quick
import SwiftDux
import SwiftUI
import ViewInspector

extension PlaceholderView: Inspectable {}

final class PlaceholderViewSpec: QuickSpec {
    override func spec() {
        var sut: PlaceholderView!

        beforeEach {
            sut = PlaceholderView()
        }
        describe("\(PlaceholderView.self)") {
            it("Should display ProgressView") {
                let view = try sut.inspect().find(ViewType.ProgressView.self)
                expect(view).toNot(beNil())
            }
        }
    }
}
