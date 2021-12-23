//
//  Created by Kamil Powałowski on 20/12/2021.
//

import Combine
import Foundation
import RevenueCat

class SubscriptionService {
    func initRevenueCat() {
        #if Debug
            Purchases.logLevel = .debug
        #endif
        Purchases.configure(withAPIKey: "appl_eMAMIlpeRBPoAyrgFBAuUBAvQrK")
    }

    func signIn(accountId: String) -> AnyPublisher<CustomerInfo, AppError> {
        Future<CustomerInfo, Error> { promise in
            Purchases.shared.logIn(accountId) { customerInfo, _, error in
                if let customerInfo = customerInfo {
                    promise(.success(customerInfo))
                } else {
                    promise(.failure(error ?? AppError.unknown))
                }
            }
        }
        .mapToAppError()
    }

    func signOut() -> AnyPublisher<Void, AppError> {
        Future<Void, Error> { promise in
            Purchases.shared.logOut { _, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .mapToAppError()
    }

    func getOfferings() -> AnyPublisher<Offerings, AppError> {
        Future<Offerings, Error> { promise in
            Purchases.shared.getOfferings { offerings, error in
                if let offerings = offerings {
                    promise(.success(offerings))
                } else {
                    promise(.failure(error ?? AppError.unknown))
                }
            }
        }
        .mapToAppError()
    }

    func restoreTransactions() -> AnyPublisher<CustomerInfo, AppError> {
        Future<CustomerInfo, Error> { promise in
            Purchases.shared.restoreTransactions { customerInfo, error in
                if let customerInfo = customerInfo {
                    promise(.success(customerInfo))
                } else {
                    promise(.failure(error ?? AppError.unknown))
                }
            }
        }
        .mapToAppError()
    }

    func purchasePackage(_ package: Package) -> AnyPublisher<CustomerInfo?, AppError> {
        Future<CustomerInfo?, Error> { promise in
            Purchases.shared.purchase(package: package) { _, customerInfo, error, userCancelled in
                if let error = error {
                    promise(.failure(error))
                } else if userCancelled {
                    promise(.success(nil))
                } else {
                    promise(.success(customerInfo))
                }
            }
        }
        .mapToAppError()
    }
}
