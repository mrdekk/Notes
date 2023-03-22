//  Created by Denis Malykh on 20.03.2023.

import SwiftUI

@main
struct NotesApp: App {

    let graph = AppGraph()

    var body: some Scene {
        WindowGroup {
            graph.makeRootContainerView()
        }
    }
}
