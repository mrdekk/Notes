//  Created by Denis Malykh on 07.04.2023.

import Combine
import Foundation
import SwiftUI

final class HomeGraph {

    private let categories: AnyPublisher<[Category], Never>

    init(
        categories: AnyPublisher<[Category], Never>
    ) {
        self.categories = categories
    }
    
}

extension HomeGraph {
    func makeHomeView() -> HomeView {
        let vm = HomeView.ViewModel()
        vm.cancellable = categories
            .receive(on: RunLoop.main)
            .sink { categories in
                vm.categories = categories
            }
        return HomeView(
            viewModel: vm,
            addCategoryClickAction: {
                // TODO: Home Tab Navigation State
            }
        )
    }
}
