//
//  Created by Kamil Powałowski on 15/07/2021.
//

@testable import Brain3k
import Combine
import Foundation
import ParseSwift

func makeParseFuture<T>(_ object: T) -> Future<T, ParseError> {
    Future<T, ParseError> { promise in promise(.success(object)) }
}
