package ru.mrdekk.notes.app.home.views

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.runtime.Composable
import androidx.compose.runtime.State
import androidx.compose.runtime.collectAsState
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import kotlinx.coroutines.flow.Flow
import ru.mrdekk.notes.generic.models.Category

@Composable
fun HomeView(
    categories: Flow<List<Category>>
) {
    val categs = categories.collectAsState(initial = listOf())

    Box(modifier = Modifier.background(Color.LightGray).fillMaxHeight()) {
        HomeCategoriesView(categories = categs.value)
    }
}
