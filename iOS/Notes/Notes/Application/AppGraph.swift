//  Created by Denis Malykh on 20.03.2023.

import Foundation
import SwiftUI

final class AppGraph {
    private lazy var rootGraph: RootGraph = {
        RootGraph()
    }()
}

extension AppGraph {
    func makeRootContainerView() -> some View {
        rootGraph.makeRootContainerView()
    }
}
