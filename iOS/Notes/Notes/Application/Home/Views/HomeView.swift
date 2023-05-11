//  Created by Denis Malykh on 07.04.2023.

import Combine
import SwiftUI

struct HomeView: View {

    class ViewModel: ObservableObject {
        @Published var categories: [Category] = []
        var cancellable: Cancellable?
    }

    @ObservedObject private var viewModel: ViewModel

    typealias AddCategoryClickAction = () -> Void
    private let addCategoryClickAction: AddCategoryClickAction

    var body: some View {
        HomeCategoriesView(categories: $viewModel.categories)
            .background(Color.black.opacity(0.2))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar {
                Button(
                    action: {
                        addCategoryClickAction()
                    },
                    label: {
                        Image(systemName: "folder.fill.badge.plus")
                    }
                )
            }
    }

    init(
        viewModel: ViewModel,
        addCategoryClickAction: @escaping AddCategoryClickAction
    ) {
        self.viewModel = viewModel
        self.addCategoryClickAction = addCategoryClickAction
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = HomeView.ViewModel()
        vm.categories = []
        return HomeView(
            viewModel: vm,
            addCategoryClickAction: {}
        )
    }
}
