//
//  Created by Kamil Powałowski on 30/06/2021.
//

import Foundation

enum AccountStatus: Equatable {
    case authenticated(Account)
    case unverifiedEmail(Account)
    case unauthenticated
    case undetermined
}
