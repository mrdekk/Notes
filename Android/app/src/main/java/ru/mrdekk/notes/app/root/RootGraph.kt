package ru.mrdekk.notes.app.root

import androidx.compose.material.Text
import androidx.compose.runtime.collectAsState
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.launch
import ru.mrdekk.notes.app.root.model.WorkMode
import ru.mrdekk.notes.app.root.views.RootContainerView
import ru.mrdekk.notes.generic.di.InjectException
import ru.mrdekk.notes.generic.di.Injectable
import ru.mrdekk.notes.generic.di.Injector

interface RootGraphInjectable: Injectable

class RootGraph: Injector<RootGraphInjectable> {
    override fun inject(target: RootGraphInjectable) = when (target) {
        is MainActivity ->  inject(target)
        else -> throw InjectException("Unknown injectable target")
    }
    
    private fun inject(mainActivity: MainActivity) {
        val coroutineScope = CoroutineScope(Job())
        val mode = MutableStateFlow<WorkMode>(WorkMode.Geo)
        mainActivity.makeRootView = {
            RootContainerView(
                mode,
                {
                    when (it) {
                        WorkMode.Notes -> Text("Notes Screen")
                        WorkMode.Vault -> Text("Vault Screen")
                        WorkMode.Geo -> Text("Geo screen")
                        WorkMode.Profile -> Text("Profile screen")
                    }
                },
                { newMode ->
                    coroutineScope.launch {
                        mode.emit(newMode)
                    }
                }
            )
        }
    }
}
