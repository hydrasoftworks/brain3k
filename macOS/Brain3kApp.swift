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
    }

    var body: some Scene {
        WindowGroup {
            if !runningTests {
                SplashPage()
                    .frame(
                        minWidth: 800, idealWidth: 900, maxWidth: .infinity,
                        minHeight: 500, idealHeight: 600, maxHeight: .infinity
                    )
                    .provideStore(store)
            }
        }
        .commands {
            SidebarCommands()
        }

        Settings {
            SettingsPage()
                .padding()
                .frame(
                    minWidth: 300, idealWidth: 300, maxWidth: 300,
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
