//  Created by Denis Malykh on 07.04.2023.

import SwiftUI

struct HomeCategoryView: View {

    @Binding var category: Category

    var body: some View {
        VStack {
            HStack {
                //Text(" | ")
                Image(systemName: "chevron.compact.right")
                    .foregroundColor(Color(category.color.asUIColor))
                Text(category.title.max(numberOfCharacters: 60))
                Spacer()
                Image(systemName: "chevron.forward.circle")
                    .padding([.leading], 4)
            }
            Divider()
                .padding([.top, .bottom], 8)
            HStack(alignment: .top) {
                Image(systemName: "person.circle.fill")
                Spacer()
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "calendar")
                        Text(category.schedule.localized)
                            .font(.caption)
                            .frame(width: 70, alignment: .leading)                            

                    }
                    .padding([.bottom], 2)
                    HStack {
                        Image(systemName: "timer")
                        Text(category.time?.stringify ?? "~")
                            .font(.caption)
                            .frame(width: 70, alignment: .leading)
                    }
                }
            }
        }
            .padding(16)
    }
}

struct HomeCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeCategoryView(
                category: .constant(Category(
                    title: "Name",
                    color: "#ff00ff",
                    schedule: .tuesday,
                    time: nil
                ))
            )
                .previewDisplayName("Short Layout")
                .previewLayout(.fixed(width: 240, height: 240))
                .background(Color(white: 0.95))

            HomeCategoryView(
                category: .constant(Category(
                    title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce et faucibus orci. Vivamus vel laoreet nunc, eu elementum felis. Nunc non feugiat nunc. Sed blandit volutpat nulla, et ultricies ex. Phasellus nec interdum ligula, vitae ultrices turpis. Nam semper rhoncus mattis. Integer faucibus vestibulum tristique. Aliquam faucibus quam neque, a tincidunt ante dignissim ut. Maecenas nec enim cursus, iaculis velit in, suscipit eros. Nullam ut elementum justo.",
                    color: "#00ff00",
                    schedule: .friday,
                    time: TimeInterval(4 * 60 + 32)
                ))
            )
                .previewDisplayName("Long Text")
                .previewLayout(.fixed(width: 240, height: 240))
                .background(Color(white: 0.95))
        }
    }
}

private extension TimeInterval {
    var stringify: String {
        String(format: "%02d:%02d", Int(self) / 60, Int(self) % 60)
    }
}
