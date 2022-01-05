//
//  Created by Kamil Powałowski on 17/07/2021.
//

import FirebaseAuth
import Foundation

struct AppError: Error {
    static let unknown = AppError(message: L10n.Alerts.Error.unknown)

    let message: String

    init(message: String) {
        self.message = message
    }

    static func fromError(_ error: Error) -> AppError {
        if let error = error as? AppError { return error }
        let nsError = error as NSError
        return AppError(message: nsError.localizedDescription)
    }
}
