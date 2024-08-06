package ru.mrdekk.notes.generic.di

interface Injector {
    fun inject(target: Injectable): Boolean
}
