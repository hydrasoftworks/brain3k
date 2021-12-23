//
//  Created by Kamil Powałowski on 30/10/2021.
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
        let purchasesService = SubscriptionService()
        purchasesService.initRevenueCat()
    }

    var body: some Scene {
        WindowGroup(id: "Brain3k") {
            if !runningTests {
                SplashPage()
                    .frame(
                        minWidth: 800, idealWidth: 1000, maxWidth: .infinity,
                        minHeight: 500, idealHeight: 700, maxHeight: .infinity
                    )
                    .provideStore(store)
            }
        }
        .commands {
            SidebarCommands()
        }

        Settings {
            SettingsPageConnector()
                .padding()
                .frame(
                    minWidth: 400, idealWidth: 400, maxWidth: 400,
                    minHeight: 400, idealHeight: 400, maxHeight: 600,
                    alignment: .topLeading
                )
                .provideStore(store)
        }
    }

    private var runningTests: Bool {
        ProcessInfo.processInfo.environment["XCInjectBundleInto"] != nil
    }
}
