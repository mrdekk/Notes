//  Created by Denis Malykh on 17.04.2023.

import Foundation

extension String {
    func max(numberOfCharacters: Int) -> String {
        if count <= numberOfCharacters {
            return self
        }

        return String(self.prefix(numberOfCharacters)) + "..."
    }
}
