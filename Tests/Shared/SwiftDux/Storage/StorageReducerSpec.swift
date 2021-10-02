//
//  Created by Kamil Powałowski on 20/08/2021.
//

@testable import Brain3k
import Foundation
import Nimble
import Quick
import SwiftDux

final class StorageReducerSpec: QuickSpec {
    override func spec() {
        describe("\(StorageReducer.self)") {
            var sut: StorageReducer!

            beforeEach {
                sut = StorageReducer()
            }

            context("\(StorageReducer.self) add") {
                it("should update downloadURLs dictionary") {
                    let url1 = URL(string: "gs://example.com")!
                    let url2 = URL(string: "https://example.com")!

                    let state = StorageState()
                    let result = sut.reduce(
                        state: state,
                        action: .add(url1, url2)
                    )
                    expect(result.downloadURLs[url1]).to(equal(url2))
                }
            }
        }
    }
}
