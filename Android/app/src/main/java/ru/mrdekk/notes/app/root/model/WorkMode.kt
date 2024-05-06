package ru.mrdekk.notes.app.root.model

import ru.mrdekk.notes.R

sealed interface WorkMode {
    object Notes: WorkMode
    object Vault: WorkMode
    object Geo: WorkMode
    object Profile: WorkMode

    companion object {
        val all = listOf(
            Notes, Vault, Geo, Profile
        )
    }
}

fun WorkMode.title(): String = when(this) {
    is WorkMode.Notes -> "Notes"
    is WorkMode.Vault -> "Vault"
    is WorkMode.Geo -> "Geo"
    is WorkMode.Profile -> "Profile"
}
