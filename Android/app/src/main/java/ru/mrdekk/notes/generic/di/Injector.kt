package ru.mrdekk.notes.generic.di

interface Injector<INJ: Injectable> {
    fun inject(target: INJ)
}
