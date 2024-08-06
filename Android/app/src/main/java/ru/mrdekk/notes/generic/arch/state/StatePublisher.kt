package ru.mrdekk.notes.generic.arch.state

import kotlinx.coroutines.flow.Flow

interface StatePublisher<ST: State> {
    val currentValue: ST
    val updates: Flow<ST>
}
