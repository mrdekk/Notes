//  Created by Denis Malykh on 20.03.2023.

import Combine
import Foundation
import SnapshotTesting
import SwiftUI
import XCTest
@testable import Notes

class SwiftUIArchitecturalTests: XCTestCase {
    func testArchitecturalBonds() async {
        let initialState = CounterState(counter: 0)
        let reducer = { (_ state: CounterState, _ action: CounterState.Actions) -> CounterState in
            switch action {
            case .increment:
                return CounterState(counter: state.counter + 1)

            case .decrement:
                return CounterState(counter: state.counter - 1)
            }
        }
        let store = await Store(initialState: initialState, reducer: reducer)

        let viewModel = CountView.ViewModel()
        viewModel.upstreamConnection = await store.updates
            .receive(on: RunLoop.main)
            .sink { value in
                viewModel.counterValue = value.counter
            }

        let view = await CountView(viewModel: viewModel)
        let controller = await UIHostingController(rootView: view)

        await MainActor.run {
            controller.view.frame = CGRect(x: 0, y: 0, width: 240, height: 120)
            assertSnapshot(matching: controller, as: .image, named: "initial")
        }

        await store.execute(.increment)

        await MainActor.run { assertSnapshot(matching: controller, as: .image, named: "incremented") }

        await store.execute(.decrement)

        await MainActor.run { assertSnapshot(matching: controller, as: .image, named: "decremented")}
    }
}

private struct CounterState: Notes.State {

    enum Actions: Action {
        case increment
        case decrement
    }

    var counter: Int = 0
}

private struct CountView: View {

    class ViewModel: ObservableObject {
        @Published var counterValue: Int = 0

        var upstreamConnection: Cancellable?
    }

    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Text("Counter is \(viewModel.counterValue)")
    }
}
