//  Created by Denis Malykh on 21.03.2023.

import Foundation
import SwiftUI

final class RootGraph {

    private let store: Store<RootState, RootState.Actions>

    private lazy var homeGraph: HomeGraph = {
        HomeGraph(
            categories: dataGraph.categories
        )
    }()

    private lazy var dataGraph: DataGraph = {
        DataGraph()
    }()

    init() {
        self.store = Store(
            initialState: RootState(currentWorkMode: .notes),
            reducer: RootState.provideReducer()
        )
    }
}

extension RootGraph {
    func makeRootContainerView() -> some View {
        let vm = RootContainerView<HomeView, ContentView, ContentView, ContentView>.ViewModel()
        vm.cancellable = store.updates
            .receive(on: RunLoop.main)
            .map { value in
                value.currentWorkMode
            }
            .removeDuplicates()
            .sink { mode in
                vm.selectedTab = mode
            }

        return RootContainerView(
            viewModel: vm,
            notifyTabSwitched: { [weak self] newMode in
                self?.store.send(.switchWorkMode(mode: newMode))
            },
            makeHomeView: { [homeGraph] in
                homeGraph.makeHomeView()
            },
            makeVaultView: {
                ContentView()
            },
            makeMapView: {
                ContentView()
            },
            makeSettingsView: {
                ContentView()
            }
        )
    }
}
