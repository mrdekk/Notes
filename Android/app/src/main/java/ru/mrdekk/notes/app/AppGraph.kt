package ru.mrdekk.notes.app

import ru.mrdekk.notes.app.root.RootGraph
import ru.mrdekk.notes.app.root.RootGraphInjectable
import ru.mrdekk.notes.generic.di.InjectException
import ru.mrdekk.notes.generic.di.Injectable
import ru.mrdekk.notes.generic.di.Injector

class AppGraph : Injector<Injectable> {
    private val rootGraph = RootGraph()

    override fun inject(target: Injectable) = when(target) {
        is RootGraphInjectable -> {
            rootGraph.inject(target)
        }
        else -> {
            throw InjectException("Unknown injectable target")
        }
    }
}
