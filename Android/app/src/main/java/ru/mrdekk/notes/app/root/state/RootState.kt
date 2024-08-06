package ru.mrdekk.notes.app.root.state

import ru.mrdekk.notes.app.root.model.WorkMode
import ru.mrdekk.notes.generic.arch.Reducer
import ru.mrdekk.notes.generic.arch.action.Action
import ru.mrdekk.notes.generic.arch.state.State

class RootState(
    val currentWorkMode: WorkMode
): State {
    sealed interface Actions: Action {
        data class SwitchWorkMode(val mode: WorkMode): Actions
    }

    companion object {
        fun provideReducer(): Reducer<RootState, Actions> = { _, action ->
            when (action) {
                is Actions.SwitchWorkMode -> {
                    RootState(currentWorkMode = action.mode)
                }
            }
        }
    }
}
