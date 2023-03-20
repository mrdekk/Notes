//  Created by Denis Malykh on 20.03.2023.

import Combine
import Foundation

public class Store<ST: State, ACT: Action>: StatePublisher, ActionExecutor {

    public typealias Reducer = (_ state: ST, _ action: ACT) -> ST

    private let state: CurrentValueSubject<ST, Never>
    private let reducer: Reducer

    init(initialState: ST, reducer: @escaping Reducer) {
        self.state = .init(initialState)
        self.reducer = reducer
    }

    // MARK: - StateObserver

    public var updates: AnyPublisher<ST, Never> {
        state.eraseToAnyPublisher()
    }

    // MARK: - ActionExecutor

    @StateActor
    public func execute(_ action: ACT) async {
        state.send(reducer(state.value, action))
    }
}
