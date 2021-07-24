//
//  Created by Kamil Powałowski on 29/06/2021.
//

import FirebaseAuth
import Foundation

struct Account: Equatable {
    var id: String
    var email: String?
    var emailVerified: Bool

    init(serviceUser: FirebaseAuth.User) {
        id = serviceUser.uid
        email = serviceUser.email
        emailVerified = serviceUser.isEmailVerified
    }

    init(id: String, email: String?, emailVerified: Bool) {
        self.id = id
        self.email = email
        self.emailVerified = emailVerified
    }
}
