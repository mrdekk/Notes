//  Created by Denis Malykh on 20.03.2023.

import Combine
import Foundation

public protocol StatePublisher {
    associatedtype ST: State
    var updates: AnyPublisher<ST, Never> { get }
}
