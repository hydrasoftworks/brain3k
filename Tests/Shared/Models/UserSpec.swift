//
//  Created by Kamil Powałowski on 13/11/2021.
//

@testable import Brain3k
import Nimble
import Quick

final class UserSpec: QuickSpec {
    override func spec() {
        describe("\(User.self) canAddMemory") {
            it("Should be true when counter is smaller than limit") {
                expect(User.test(counter: 1, limit: 10).canAddMemory)
                    .to(beTrue())
                expect(User.test(counter: 999, limit: 1000).canAddMemory)
                    .to(beTrue())
            }

            it("should be false otherwise") {
                expect(User.test(counter: 10, limit: 10).canAddMemory)
                    .to(beFalse())
                expect(User.test(counter: 1000, limit: 999).canAddMemory)
                    .to(beFalse())
            }
        }
    }
}
