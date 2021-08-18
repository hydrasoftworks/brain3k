//
//  Created by Kamil Powałowski on 20/08/2021.
//

import Combine
import Foundation

struct CompletionHandler<T> {
    let promise: Future<T, Error>.Promise

    init(_ promise: @escaping Future<T, Error>.Promise) {
        self.promise = promise
    }

    func handle() -> (T?, Error?) -> Void {
        { response, error in
            if let response = response {
                promise(.success(response))
            } else if let error = error {
                promise(.failure(error))
            }
        }
    }
}
