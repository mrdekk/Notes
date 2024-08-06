package ru.mrdekk.notes.app

import android.app.Application
import ru.mrdekk.notes.generic.di.Injectable
import ru.mrdekk.notes.generic.di.Injector

class NotesApp(
    private val graph: AppGraph = AppGraph()
): Application(), Injector by graph {
}
