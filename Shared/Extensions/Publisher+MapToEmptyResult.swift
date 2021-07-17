//
//  Created by Kamil Powałowski on 10/07/2021.
//

import Combine

extension Publisher {
    func mapToEmptyResult<T>(ofType _: T.Type) -> AnyPublisher<T, Failure> {
        flatMap { _ in AnyPublisher<T, Failure>.empty }
            .eraseToAnyPublisher()
    }
}
