package ru.mrdekk.notes.generic.models

import java.util.concurrent.TimeUnit

data class Time(
    val instant: Long,
    val unit: TimeUnit
) {
    fun toUnit(unit: TimeUnit): Long = unit.convert(instant, this.unit)
}
