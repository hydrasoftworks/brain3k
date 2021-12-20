//
//  Created by Kamil Powałowski on 27/06/2021.
//

import SwiftDux
import SwiftDuxExtras
import SwiftUI

@main
struct Brain3kApp: App {
    private let store: Store<AppState>

    init() {
        store = Store(
            state: AppState(),
            reducer: AppReducer(),
            middleware: PrintActionMiddleware<AppState>()
        )

        let librariesService = LibrariesService()
        librariesService.initSwiftyBeaver()
        librariesService.initFirebase()
        let purchasesService = PurchasesService()
        purchasesService.initRevenueCat()
    }

    var body: some Scene {
        WindowGroup {
            if !runningTests {
                SplashPage()
                    .provideStore(store)
            }
        }
    }

    private var runningTests: Bool {
        ProcessInfo.processInfo.environment["XCInjectBundleInto"] != nil
    }
}
