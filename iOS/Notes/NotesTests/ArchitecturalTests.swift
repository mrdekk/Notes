//  Created by Denis Malykh on 20.03.2023.

import Combine
import XCTest

@testable import Notes

class ArchitecturalTests: XCTestCase {
    func testBasicSetup() async throws {
        let initialState = CounterState(counter: 0)
        let reducer = { (_ state: CounterState, _ action: CounterState.Actions) -> CounterState in
            switch action {
            case .increment:
                return CounterState(counter: state.counter + 1)

            case .decrement:
                return CounterState(counter: state.counter - 1)
            }
        }
        let store = Store(initialState: initialState, reducer: reducer)
        let spy = CounterStateSpy()
        spy.subscribe(publisher: store.updates)

        XCTAssert(spy.observedValues == [0], "spy observed initial value state")

        await store.execute(.increment)

        XCTAssert(spy.observedValues == [0, 1], "spy observes initial state and increment modification")

        await store.execute(.decrement)

        XCTAssert(spy.observedValues == [0, 1, 0], "spy observes initial state and both (increment, decrement) modifications")
    }
}

private struct CounterState: State {

    enum Actions: Action {
        case increment
        case decrement
    }

    var counter: Int = 0
}

private class CounterStateSpy {
    var observedValues: [Int] = []

    private var cancellable: Cancellable?

    func subscribe(publisher: AnyPublisher<CounterState, Never>) {
        cancellable = publisher.sink { state in
            self.observedValues.append(state.counter)
        }
    }
}
