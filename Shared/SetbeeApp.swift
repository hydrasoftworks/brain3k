//
//  Created by Kamil Powałowski on 27/06/2021.
//

import ParseSwift
import SwiftDux
import SwiftDuxExtras
import SwiftUI
import SwiftyBeaver

let log = SwiftyBeaver.self

@main
struct SetbeeApp: App {
    let store: Store<AppState>

    init() {
        let fileUrl = URL.persistFileUrl
        let jsonPersistor = JSONStatePersistor<AppState>(fileUrl: fileUrl)

        store = Store(
            state: AppState(),
            reducer: AppReducer(),
            middleware: PrintActionMiddleware<AppState>()
                + PersistStateMiddleware(jsonPersistor)
        )

        initSwiftyBeaver()

        log.info("SwiftDux persist file \(fileUrl)")

        let configuration = ParseConfiguration(
            applicationId: "B2Yxw2u4L1ikcz13dVKVvltuv3HfSbGZn3lIhCj5",
            clientKey: "HUZaHgZSg2rKQ4rcwYsm8p9yDZP267GaRSJxEw0U",
            serverURL: URL(string: "https://parseapi.back4app.com")!
        )
        ParseSwift.initialize(configuration: configuration)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    private func initSwiftyBeaver() {
        #if Debug
            let console = ConsoleDestination() // log to Xcode Console
            log.addDestination(console)
            log.info("📘 SwiftyBeaver initialized")
        #endif
    }
}
