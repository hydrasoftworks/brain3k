//
//  Created by Kamil Powałowski on 17/07/2021.
//

import Foundation
import ParseSwift

struct AppError: Error {
    let message: String

    init(message: String) {
        self.message = message
    }

    init(parseError: ParseError) {
        message = parseError.message
    }
}
