package ru.mrdekk.notes.app.root.model

import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.AccountBalance
import androidx.compose.material.icons.outlined.AccountCircle
import androidx.compose.material.icons.outlined.Description
import androidx.compose.material.icons.outlined.LocationOn
import androidx.compose.ui.graphics.vector.ImageVector
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

fun WorkMode.icon(): ImageVector = when(this) {
    is WorkMode.Notes -> Icons.Outlined.Description
    is WorkMode.Vault -> Icons.Outlined.AccountBalance
    is WorkMode.Geo -> Icons.Outlined.LocationOn
    is WorkMode.Profile -> Icons.Outlined.AccountCircle
}
