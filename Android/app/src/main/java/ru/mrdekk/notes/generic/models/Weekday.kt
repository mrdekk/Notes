package ru.mrdekk.notes.generic.models

import ru.mrdekk.notes.R

enum class Weekday() {
    Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
}

class Weekdays(
    private var days: MutableSet<Weekday> = HashSet()
) {


    fun addDay(day: Weekday) {
        days.add(day)
    }

    fun removeDay(day: Weekday) {
        days.remove(day)
    }

    fun containsDay(day: Weekday): Boolean = days.contains(day)
    fun isSimilar(to: Weekdays): Boolean = days == to.days

    companion object {
        val weekdays = Weekdays(mutableSetOf(
            Weekday.Monday,
            Weekday.Tuesday,
            Weekday.Wednesday,
            Weekday.Thursday,
            Weekday.Friday
        ))
        val weekend = Weekdays(mutableSetOf(Weekday.Saturday, Weekday.Sunday))
        val whole = Weekdays(weekdays.days.union(weekend.days).toMutableSet())
    }
}

fun Weekdays.isWholeWeek() = isSimilar(Weekdays.whole)
fun Weekdays.isWeekend() = isSimilar(Weekdays.weekend)
fun Weekdays.isWeekdays() = isSimilar(Weekdays.weekdays)

fun Weekdays.localizedId(): List<Int> {
    if (isWholeWeek()) {
        return listOf(R.string.weekday_whole)
    }
    if (isWeekend()) {
        return listOf(R.string.weekday_end)
    }
    if (isWeekdays()) {
        return listOf(R.string.weekday_days)
    }

    val items = mutableListOf<Int>()
    if (containsDay(Weekday.Monday)) {
        items.add(R.string.weekday_mon)
    }
    if (containsDay(Weekday.Tuesday)) {
        items.add(R.string.weekday_tue)
    }
    if (containsDay(Weekday.Wednesday)) {
        items.add(R.string.weekday_wed)
    }
    if (containsDay(Weekday.Thursday)) {
        items.add(R.string.weekday_thu)
    }
    if (containsDay(Weekday.Friday)) {
        items.add(R.string.weekday_fri)
    }
    if (containsDay(Weekday.Saturday)) {
        items.add(R.string.weekday_sat)
    }
    if (containsDay(Weekday.Sunday)) {
        items.add(R.string.weekday_sun)
    }
    return items
}
