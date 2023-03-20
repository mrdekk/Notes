//  Created by Denis Malykh on 20.03.2023.

import Foundation

public protocol ActionExecutor {
    associatedtype ACT: Action

    func execute(_ action: ACT) async
}

public extension ActionExecutor {
    func send(_ action: ACT) -> Task<Void, Never> {
        Task {
            await execute(action)
        }
    }
}


