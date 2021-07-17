//
//  Created by Kamil Powałowski on 17/07/2021.
//

import Combine
import ParseSwift

extension Future where Failure == ParseError {
    func mapToAppError() -> AnyPublisher<Output, AppError> {
        mapError(AppError.init(parseError:))
            .eraseToAnyPublisher()
    }
}
