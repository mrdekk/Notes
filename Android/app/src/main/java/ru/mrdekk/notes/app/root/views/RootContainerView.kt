package ru.mrdekk.notes.app.root.views

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material.Icon
import androidx.compose.material.Tab
import androidx.compose.material.TabRow
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.ui.Modifier
import kotlinx.coroutines.flow.Flow
import ru.mrdekk.notes.app.root.model.WorkMode
import ru.mrdekk.notes.app.root.model.icon
import ru.mrdekk.notes.app.root.model.title

@Composable
fun RootContainerView(
    workMode: Flow<WorkMode>,
    makeScreenView: @Composable (workMode: WorkMode) -> Unit,
    onWorkModeChange: (newMode: WorkMode) -> Unit
) {
    val modes = WorkMode.all
    val currentWorkMode = workMode.collectAsState(initial = WorkMode.Notes)

    Column(modifier = Modifier.fillMaxWidth()) {
        Row(modifier = Modifier.weight(1f)) {
            makeScreenView(currentWorkMode.value)
        }
        TabRow(selectedTabIndex = modes.indexOf(currentWorkMode.value)) {
            modes.forEachIndexed { index, tab ->
                Tab(
                    text = { Text(tab.title()) },
                    selected = currentWorkMode == modes[index],
                    onClick = { onWorkModeChange(modes[index]) },
                    icon = {
                        Icon(imageVector = tab.icon(), contentDescription = null)
                    }
                )
            }
        }
    }
}
