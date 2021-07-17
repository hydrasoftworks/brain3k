//
//  Created by Kamil Powałowski on 15/07/2021.
//

@testable import Brain3k
import Combine
import Foundation
import ParseSwift

func makeCombineResult<T>(_ object: T) -> AnyPublisher<T, AppError> {
    Future<T, AppError> { promise in promise(.success(object)) }
        .eraseToAnyPublisher()
}

func makeCombineError<T>(_: T.Type) -> AnyPublisher<T, AppError> {
    Future<T, AppError> { promise in
        promise(.failure(AppError(message: "This is a test error")))
    }
    .eraseToAnyPublisher()
}
