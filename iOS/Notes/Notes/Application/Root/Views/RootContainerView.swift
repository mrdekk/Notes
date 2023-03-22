//  Created by Denis Malykh on 21.03.2023.

import Combine
import Foundation
import SwiftUI

struct RootContainerView<HV: View, V: View, M: View, S: View>: View {

    class ViewModel: ObservableObject {
        @Published var selectedTab: WorkMode = .notes
        var cancellable: Cancellable?
    }

    private let makeHomeView: () -> HV
    private let makeVaultView: () -> V
    private let makeMapView: () -> M
    private let makeSettingsView: () -> S

    @ObservedObject private var viewModel: ViewModel

    typealias NotifyTabSwitched = (_ tab: WorkMode) -> Void

    private let notifyTabSwitched: NotifyTabSwitched

    init(
        viewModel: ViewModel,
        notifyTabSwitched: @escaping NotifyTabSwitched,
        makeHomeView: @escaping () -> HV,
        makeVaultView: @escaping () -> V,
        makeMapView: @escaping () -> M,
        makeSettingsView: @escaping () -> S
    ) {
        self.viewModel = viewModel
        self.notifyTabSwitched = notifyTabSwitched
        self.makeHomeView = makeHomeView
        self.makeVaultView = makeVaultView
        self.makeMapView = makeMapView
        self.makeSettingsView = makeSettingsView
    }

    var body: some View {
        let selectedTabBinding = Binding(
            get: { viewModel.selectedTab },
            set: { value in notifyTabSwitched(value) }
        )
        return TabView(selection: selectedTabBinding) {
            NavigationView {
                makeHomeView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Главная")
                    .background(Color.black.opacity(0.2))
            }
                .tag(WorkMode.notes)
                .tabItem {
                    Label("Главная", systemImage: "house")
                }
            makeVaultView()
                .tag(WorkMode.vault)
                .tabItem {
                    Label("Копилка", systemImage: "externaldrive")
                }
            makeMapView()
                .tag(WorkMode.geo)
                .tabItem {
                    Label("Гео", systemImage: "mappin.and.ellipse")
                }
            makeSettingsView()
                .tag(WorkMode.profile)
                .tabItem {
                    Label("Настройки", systemImage: "person.circle")
                }
        }
    }
}

struct RootContainerView_Previews: PreviewProvider {
    static var previews: some View {
        RootContainerView(
            viewModel: RootContainerView.ViewModel(),
            notifyTabSwitched: { _ in },
            makeHomeView: { ContentView() },
            makeVaultView: { ContentView() },
            makeMapView: { ContentView() },
            makeSettingsView: { ContentView() }
        )
    }
}
