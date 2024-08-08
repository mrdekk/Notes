package ru.mrdekk.notes.generic.models

import android.graphics.Color

@JvmInline
value class HexColor(private val hexValue: String) {
    val color: Int
        get() = Color.parseColor(hexValue)
    val composeColor: androidx.compose.ui.graphics.Color
        get() = androidx.compose.ui.graphics.Color(color)
}
