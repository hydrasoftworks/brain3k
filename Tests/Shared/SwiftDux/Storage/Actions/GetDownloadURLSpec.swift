//
//  Created by Kamil Powałowski on 20/08/2021.
//

@testable import Brain3k
import Combine
import Cuckoo
import Foundation
import Nimble
import Quick
import SwiftDux

final class GetDownloadURLSpec: QuickSpec {
    override func spec() {
        describe("\(StorageAction.self) getDownloadURL action") {
            var mock: MockStorageService!
            var cancellable: AnyCancellable?
            var httpUrl: URL!
            var gsUrl: URL!

            beforeEach {
                mock = MockStorageService()
                httpUrl = URL(string: "https://example.com")!
                gsUrl = URL(string: "gs://example.com")!
            }

            afterEach {
                cancellable?.cancel()
                cancellable = nil
            }

            context("when URL is empty") {
                it("service shouldn't be called") {
                    let actionPlan = StorageAction.getDownloadURL(for: nil, mock)

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { _ in })

                    verify(mock, never()).downloadURL(for: any())
                }
            }

            context("when URL is already in state") {
                it("service shouldn't be called") {
                    let state = AppState(
                        storageState: StorageState(
                            downloadURLs: [httpUrl: httpUrl]
                        )
                    )
                    let actionPlan = StorageAction.getDownloadURL(for: httpUrl, mock)

                    cancellable = actionPlan.run(store: storeProxy(state))
                        .sink(receiveValue: { _ in })

                    verify(mock, never()).downloadURL(for: any())
                }
            }

            context("when URL is not a gs:// url") {
                var action: StorageAction?

                it("service shouldn't be called") {
                    let actionPlan = StorageAction.getDownloadURL(for: httpUrl, mock)

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { _ in })

                    verify(mock, never()).downloadURL(for: any())
                }

                it("should just added it to downloaded urls") {
                    let actionPlan = StorageAction.getDownloadURL(for: httpUrl, mock)

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { action = $0 as? StorageAction })

                    expect(action).toEventually(equal(StorageAction.add(httpUrl, httpUrl)))
                }
            }

            context("when URL is a gs:// url") {
                var action: StorageAction?

                beforeEach {
                    stub(mock) { stub in
                        when(stub.downloadURL(for: equal(to: gsUrl)))
                            .thenReturn(makeCombineResult(httpUrl))
                    }
                }

                it("service should be called for given url") {
                    let actionPlan = StorageAction.getDownloadURL(for: gsUrl, mock)

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { _ in })

                    verify(mock, times(1)).downloadURL(for: equal(to: gsUrl))
                }

                it("should add result to downloaded urls") {
                    let actionPlan = StorageAction.getDownloadURL(for: gsUrl, mock)

                    cancellable = actionPlan.run(store: storeProxy())
                        .sink(receiveValue: { action = $0 as? StorageAction })

                    expect(action).toEventually(equal(StorageAction.add(gsUrl, httpUrl)))
                }
            }
        }
    }
}
