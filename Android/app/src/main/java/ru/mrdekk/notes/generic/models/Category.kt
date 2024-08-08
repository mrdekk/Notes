package ru.mrdekk.notes.generic.models

import java.util.UUID
import java.util.concurrent.TimeUnit

data class Category(
    val id: String,
    val title: String,
    val color: HexColor,
    val schedule: Weekdays,
    val time: Time
)

fun makeDummyCategories(): List<Category> = listOf(
    Category(
        id = UUID.randomUUID().toString(),
        title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse hendrerit porttitor ultrices. Mauris urna leo, semper sed faucibus ornare, vulputate nec ante. Fusce non dapibus neque. Aenean lacinia mauris et tellus scelerisque, eu porta arcu volutpat. Vivamus neque orci, tempor vel porttitor ac, suscipit dapibus odio. Morbi facilisis leo quis nisi vestibulum eleifend. Pellentesque auctor ante a ex tempor, eget varius libero porta.",
        color = HexColor("#ff00ff"),
        schedule = Weekdays.weekdays,
        time = Time(3 * 60 + 34, TimeUnit.MINUTES)
    ),
    Category(
        id = UUID.randomUUID().toString(),
        title = "Second",
        color = HexColor("#00ff00"),
        schedule = Weekdays.weekend,
        time = Time(7 * 60 + 21, TimeUnit.MINUTES)
    ),
    Category(
        id = UUID.randomUUID().toString(),
        title = "Third",
        color = HexColor("#f00ff0"),
        schedule = Weekdays.whole,
        time = Time(1 * 60 + 1, TimeUnit.MINUTES)
    )
)
