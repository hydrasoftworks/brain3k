//
//  Created by Kamil Powałowski on 19/09/2021.
//

import Firebase
import FirebaseAuth
import Foundation
import SwiftyBeaver

let log = SwiftyBeaver.self

class LibrariesService {
    func initSwiftyBeaver() {
        #if Debug
            let console = ConsoleDestination() // log to Xcode Console
            log.addDestination(console)
            log.info("📘 SwiftyBeaver initialized")
        #endif
    }

    func initFirebase() {
        FirebaseApp.configure()
        do {
            try Auth.auth().useUserAccessGroup("V3QMW7D5T5.com.brain3k.Brain3k.KeychainGroup")
        } catch {
            log.error("Error changing user access group: \(error)")
        }
    }
}
