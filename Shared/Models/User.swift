//
//  Created by Kamil Powałowski on 29/06/2021.
//

import Foundation
import ParseSwift

struct User: ParseUser {
    var username: String?
    var email: String?
    var emailVerified: Bool?
    var password: String?
    var authData: [String: [String: String]?]?
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
}
