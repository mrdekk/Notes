//  Created by Denis Malykh on 26.06.2023.

import Foundation

struct HomeState: State {

    enum Actions: Action {
        case showList
        case addCategory
    }

    let currentWorkMode: NotesWorkMode

    static func provideReducer() -> Store<HomeState, HomeState.Actions>.Reducer {
        { _, action in
            switch action {
            case .showList:
                return HomeState(currentWorkMode: .categoriesList)
            case .addCategory:
                return HomeState(currentWorkMode: .addCategory)
            }
        }
    }
}
