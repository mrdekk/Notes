//  Created by Denis Malykh on 20.03.2023.

import Combine
import Foundation

public class Store<ST: State, ACT: Action>: StatePublisher, ActionExecutor {

    public typealias Reducer = (_ state: ST, _ action: ACT) -> ST

    private let state: CurrentValueSubject<ST, Never>
    private let reducer: Reducer
    private let syncQueue: DispatchingQueue

    init(initialState: ST, reducer: @escaping Reducer, syncQueue: DispatchingQueue) {
        self.state = .init(initialState)
        self.reducer = reducer
        self.syncQueue = syncQueue
    }

    // MARK: - StateObserver

    public var updates: AnyPublisher<ST, Never> {
        state.eraseToAnyPublisher()
    }

    // MARK: - ActionExecutor

    public func execute(_ action: ACT) async {
        syncQueue.async { [weak self] in
            guard let self = self else { return }
            self.state.send(self.reducer(self.state.value, action))
        }
    }
}
