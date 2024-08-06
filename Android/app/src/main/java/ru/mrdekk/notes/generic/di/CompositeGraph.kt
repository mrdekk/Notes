package ru.mrdekk.notes.generic.di

abstract class CompositeGraph: Graph() {
    protected abstract val subgraphs: Set<Graph>

    override fun inject(target: Injectable): Boolean = subgraphs.any { it.inject(target) }
}
