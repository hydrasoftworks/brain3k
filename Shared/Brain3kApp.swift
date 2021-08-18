//
//  Created by Kamil Powałowski on 27/06/2021.
//

import Firebase
import SwiftDux
import SwiftDuxExtras
import SwiftUI
import SwiftyBeaver

let log = SwiftyBeaver.self

@main
struct Brain3kApp: App {
    private let store: Store<AppState>

    init() {
        store = Store(
            state: AppState(),
            reducer: AppReducer(),
            middleware: PrintActionMiddleware<AppState>()
        )

        initSwiftyBeaver()
        FirebaseApp.configure()
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

    private func initSwiftyBeaver() {
        #if Debug
            let console = ConsoleDestination() // log to Xcode Console
            log.addDestination(console)
            log.info("📘 SwiftyBeaver initialized")
        #endif
    }
}
