package ru.mrdekk.notes.app.root

import androidx.compose.material.Text
import androidx.compose.runtime.collectAsState
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.launch
import ru.mrdekk.notes.app.home.HomeGraph
import ru.mrdekk.notes.app.root.model.WorkMode
import ru.mrdekk.notes.app.root.state.RootState
import ru.mrdekk.notes.app.root.views.RootContainerView
import ru.mrdekk.notes.generic.arch.Store
import ru.mrdekk.notes.generic.arch.StoreActor
import ru.mrdekk.notes.generic.di.CompositeGraph
import ru.mrdekk.notes.generic.di.Graph
import ru.mrdekk.notes.generic.di.InjectException
import ru.mrdekk.notes.generic.di.Injectable
import ru.mrdekk.notes.generic.di.Injector

class RootGraph(
    coroutineScope: CoroutineScope,
    actor: StoreActor
): CompositeGraph() {

    private var homeGraph = HomeGraph()

    private val store: Store <RootState, RootState.Actions>

    override val subgraphs: Set<Graph>
        get() = setOf()

    init {
        store = Store(
            initialState = RootState(currentWorkMode = WorkMode.Notes),
            reducer = RootState.provideReducer(),
            coroutineScope = coroutineScope,
            actor = actor
        )
    }

    override fun inject(target: Injectable): Boolean = when (target) {
        is MainActivity -> inject(target)
        else -> super.inject(target)
    }
    
    private fun inject(mainActivity: MainActivity): Boolean {
        val mode = store.updates
            .map { it.currentWorkMode }
            .distinctUntilChanged()
        mainActivity.makeRootView = {
            RootContainerView(
                mode,
                makeScreenView = {
                    when (it) {
                        WorkMode.Notes -> homeGraph.makeHomeView()
                        WorkMode.Vault -> Text("Vault Screen")
                        WorkMode.Geo -> Text("Geo screen")
                        WorkMode.Profile -> Text("Profile screen")
                    }
                },
                { newMode ->
                    store.send(RootState.Actions.SwitchWorkMode(newMode))
                }
            )
        }
        return true
    }
}
