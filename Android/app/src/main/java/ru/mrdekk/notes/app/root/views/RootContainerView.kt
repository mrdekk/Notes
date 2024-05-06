package ru.mrdekk.notes.app.root.views

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material.Icon
import androidx.compose.material.Tab
import androidx.compose.material.TabRow
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Home
import androidx.compose.runtime.Composable
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.State
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import kotlinx.coroutines.flow.Flow
import ru.mrdekk.notes.app.root.model.WorkMode
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
        makeScreenView(currentWorkMode.value)
        TabRow(selectedTabIndex = modes.indexOf(currentWorkMode.value)) {
            modes.forEachIndexed { index, tab ->
                Tab(
                    text = { Text(tab.title()) },
                    selected = currentWorkMode == modes[index],
                    onClick = { onWorkModeChange(modes[index]) },
                    icon = {
                        Icon(imageVector = Icons.Default.Home, contentDescription = null)
                    }
                )
            }
        }
    }
}
