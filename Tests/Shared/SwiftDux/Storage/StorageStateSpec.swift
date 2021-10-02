//
//  Created by Kamil Powałowski on 20/08/2021.
//

@testable import Brain3k
import Nimble
import Quick

final class StorageStateSpec: QuickSpec {
    override func spec() {
        describe("\(StorageState.self) initial state") {
            var sut: StorageState!

            beforeEach {
                sut = StorageState()
            }

            it("should have empty list of downloaded URLs") {
                expect(sut.downloadURLs).to(beEmpty())
            }
        }
    }
}
