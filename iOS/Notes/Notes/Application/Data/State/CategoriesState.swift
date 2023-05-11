//  Created by Denis Malykh on 11.05.2023.

import Foundation

struct CategoriesState: State {

    enum Actions: Action {
    }

    let knowCategories: [Category]

    init(knownCategories: [Category]) {
        self.knowCategories = knownCategories
    }

    static func provideReducer() -> Store<CategoriesState, CategoriesState.Actions>.Reducer {
        { state, _ in
            return state
        }
    }
}
