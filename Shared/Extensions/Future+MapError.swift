//
//  Created by Kamil Powałowski on 17/07/2021.
//

import Combine

extension Publisher where Failure == Error {
    func mapToAppError() -> AnyPublisher<Output, AppError> {
        mapError(AppError.fromError)
            .eraseToAnyPublisher()
    }
}
