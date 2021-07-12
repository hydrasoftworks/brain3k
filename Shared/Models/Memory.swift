//
//  Created by Kamil Powałowski on 27/06/2021.
//

import Foundation
import ParseSwift

struct Memory: ParseObject, Identifiable {
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?

    var id: String? { objectId }
}
