//  Created by Denis Malykh on 21.03.2023.

import Foundation
import SwiftUI

final class RootGraph {

    private let store: Store<RootState, RootState.Actions>

    init() {
        self.store = Store(
            initialState: RootState(currentWorkMode: .notes),
            reducer: RootState.provideReducer()
        )
    }
}

extension RootGraph {
    func makeRootContainerView() -> some View {
        let vm = RootContainerView<ContentView, ContentView, ContentView, ContentView>.ViewModel()
        vm.cancellable = store.updates
            .receive(on: RunLoop.main)
            .sink { value in
                vm.selectedTab = value.currentWorkMode
            }

        return RootContainerView(
            viewModel: vm,
            notifyTabSwitched: { [weak self] newMode in
                guard let self = self else { return }
                self.store.send(.switchWorkMode(mode: newMode))
            },
            makeHomeView: {
                ContentView()
            },
            makeVaultView: { ContentView() },
            makeMapView: { ContentView() },
            makeSettingsView: { ContentView() }
        )
    }
}
