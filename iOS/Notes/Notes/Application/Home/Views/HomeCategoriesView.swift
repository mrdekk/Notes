//  Created by Denis Malykh on 07.04.2023.

import SwiftUI

struct HomeCategoriesView: View {

    @Binding var categories: [Category]

    var body: some View {
        List {
            ForEach($categories) { category in
                HomeCategoryView(category: category)
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 5)
                            .background(Color.clear)
                            .foregroundColor(Color.white)
                            .padding(
                                EdgeInsets(
                                    top: 2,
                                    leading: 10,
                                    bottom: 8,
                                    trailing: 10
                                )
                            )
                    )

            }
        }
        .listStyle(.plain)
        .background(Color(white: 0.95))
    }
}

struct HomeCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCategoriesView(
            categories: .constant([
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
            ])
        )
    }
}
