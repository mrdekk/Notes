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
    private let selectedTabBinding: Binding<WorkMode>

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

        self.selectedTabBinding = Binding(
            get: { viewModel.selectedTab },
            set: { value in notifyTabSwitched(value) }
        )
    }

    var body: some View {
        return TabView(selection: selectedTabBinding) {
            NavigationView {
                makeHomeView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle(l10n.Home.title)
                    .background(Color.black.opacity(0.2))
            }
                .tag(WorkMode.notes)
                .tabItem {
                    Label(l10n.Home.title, systemImage: l10n.Home.image)
                }
            makeVaultView()
                .tag(WorkMode.vault)
                .tabItem {
                    Label(l10n.Vault.title, systemImage: l10n.Vault.image)
                }
            makeMapView()
                .tag(WorkMode.geo)
                .tabItem {
                    Label(l10n.Geo.title, systemImage: l10n.Geo.image)
                }
            makeSettingsView()
                .tag(WorkMode.profile)
                .tabItem {
                    Label(l10n.Settings.title, systemImage: l10n.Settings.image)
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
