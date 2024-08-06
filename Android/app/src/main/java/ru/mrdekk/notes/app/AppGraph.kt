package ru.mrdekk.notes.app

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import ru.mrdekk.notes.app.root.RootGraph
import ru.mrdekk.notes.generic.arch.Store
import ru.mrdekk.notes.generic.di.CompositeGraph
import ru.mrdekk.notes.generic.di.Graph

class AppGraph : CompositeGraph() {
    private val coroutineScope = CoroutineScope(Job())
    private val actor = Store.createStoreActor(coroutineScope = coroutineScope)

    private val rootGraph = RootGraph(
        coroutineScope = coroutineScope,
        actor = actor
    )

    override val subgraphs: Set<Graph>
        get() = setOf<Graph>(rootGraph)
}
