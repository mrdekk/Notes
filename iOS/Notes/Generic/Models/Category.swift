//  Created by Denis Malykh on 07.04.2023.

import Foundation

struct Category: Identifiable {
    let id: String = UUID().uuidString
    
    let title: String
    let color: HexColor
    let schedule: Weekday
    let time: TimeInterval?
}

func makeDummyCategories() -> [Category] {
    [
        Category(
            title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse hendrerit porttitor ultrices. Mauris urna leo, semper sed faucibus ornare, vulputate nec ante. Fusce non dapibus neque. Aenean lacinia mauris et tellus scelerisque, eu porta arcu volutpat. Vivamus neque orci, tempor vel porttitor ac, suscipit dapibus odio. Morbi facilisis leo quis nisi vestibulum eleifend. Pellentesque auctor ante a ex tempor, eget varius libero porta.",
            color: "#ff00ff",
            schedule: Weekday.weekdays,
            time: TimeInterval(3 * 60 + 34)
        ),
        Category(
            title: "Second",
            color: "#00ff00",
            schedule: Weekday.weekend,
            time: TimeInterval(7 * 60 + 21)
        ),
        Category(
            title: "Third",
            color: "#f00ff0",
            schedule: Weekday.whole,
            time: TimeInterval(1 * 60 + 1)
        )
    ]
}
