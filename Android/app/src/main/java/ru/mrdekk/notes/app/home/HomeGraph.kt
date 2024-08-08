package ru.mrdekk.notes.app.home

import androidx.compose.runtime.Composable
import kotlinx.coroutines.flow.flowOf
import ru.mrdekk.notes.app.home.views.HomeView
import ru.mrdekk.notes.generic.models.makeDummyCategories

class HomeGraph {
    @Composable
    fun makeHomeView() {
        HomeView(categories = flowOf(makeDummyCategories()))
    }
}
