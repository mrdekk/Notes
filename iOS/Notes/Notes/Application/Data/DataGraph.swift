//  Created by Denis Malykh on 11.05.2023.

import Combine
import Foundation

final class DataGraph {

    private let categoriesStore: Store<CategoriesState, CategoriesState.Actions>

    var categories: AnyPublisher<[Category], Never> {
        categoriesStore.updates
            .map { state in
                state.knowCategories
            }
            .eraseToAnyPublisher()
    }

    init() {
        self.categoriesStore = Store(
            initialState: CategoriesState(
                knownCategories: makeDummyCategories()
            ),
            reducer: CategoriesState.provideReducer()
        )
    }
}
