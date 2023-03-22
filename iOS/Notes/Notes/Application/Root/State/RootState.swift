//  Created by Denis Malykh on 21.03.2023.

import Foundation

struct RootState: State {

    enum Actions: Action {
        case switchWorkMode(mode: WorkMode)
    }

    let currentWorkMode: WorkMode

    static func provideReducer() -> Store<RootState, RootState.Actions>.Reducer {
        { _, action in
            switch action {
            case let .switchWorkMode(mode):
                return RootState(currentWorkMode: mode)
            }
        }
    }
}
