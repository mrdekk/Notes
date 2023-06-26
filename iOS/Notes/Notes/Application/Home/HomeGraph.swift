//  Created by Denis Malykh on 07.04.2023.

import Combine
import Foundation
import SwiftUI

final class HomeGraph {

    private let categories: AnyPublisher<[Category], Never>
    private let store: Store<HomeState, HomeState.Actions>

    init(
        categories: AnyPublisher<[Category], Never>
    ) {
        self.categories = categories
        self.store = Store(
            initialState: HomeState(currentWorkMode: .categoriesList),
            reducer: HomeState.provideReducer()
        )
    }
    
}

extension HomeGraph {
    func makeHomeView() -> HomeView {
        let vm = HomeView.ViewModel()
        let c1 = categories
            .receive(on: RunLoop.main)
            .sink { categories in
                vm.categories = categories
            }
        let c2 = store.updates
            .receive(on: RunLoop.main)
            .map { value in
                value.currentWorkMode
            }
            .removeDuplicates()
            .sink { mode in
                vm.isAddingCategory = mode.isAddingCategory
            }
        vm.cancellable.insert(c1)
        vm.cancellable.insert(c2)

        return HomeView(
            viewModel: vm,
            addCategoryClickAction: { [weak self] show in
                if show {
                    self?.store.send(.addCategory)
                } else {
                    self?.store.send(.showList)
                }
            }
        )
    }
}

private extension NotesWorkMode {
    var isAddingCategory: Bool {
        switch self {
        case .categoriesList: return false
        case .addCategory: return true
        }
    }
}
