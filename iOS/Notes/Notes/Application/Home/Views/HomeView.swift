//  Created by Denis Malykh on 07.04.2023.

import Combine
import SwiftUI

struct HomeView: View {

    class ViewModel: ObservableObject {
        @Published var categories: [Category] = []
        @Published var isAddingCategory: Bool = false
        var cancellable: Set<AnyCancellable> = Set()
    }

    @ObservedObject private var viewModel: ViewModel

    typealias AddCategoryClickAction = (_ show: Bool) -> Void
    private let addCategoryClickAction: AddCategoryClickAction

    private let isAddingCategoryBinding: Binding<Bool>

    var body: some View {
        ZStack {
            NavigationLink("Add Category", isActive: isAddingCategoryBinding) {
                ContentView()
            }
                .hidden()
            HomeCategoriesView(categories: $viewModel.categories)
                .background(Color.black.opacity(0.2))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .toolbar {
                    Button(
                        action: {
                            addCategoryClickAction(true)
                        },
                        label: {
                            Image(systemName: "folder.fill.badge.plus")
                        }
                    )
                }
        }
    }

    init(
        viewModel: ViewModel,
        addCategoryClickAction: @escaping AddCategoryClickAction
    ) {
        self.viewModel = viewModel
        self.addCategoryClickAction = addCategoryClickAction

        self.isAddingCategoryBinding = Binding(
            get: { viewModel.isAddingCategory },
            set: { value in addCategoryClickAction(value) }
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = HomeView.ViewModel()
        vm.categories = []
        vm.isAddingCategory = false
        return HomeView(
            viewModel: vm,
            addCategoryClickAction: { _ in }
        )
    }
}
