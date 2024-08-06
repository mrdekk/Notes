package ru.mrdekk.notes.generic.arch

import kotlinx.coroutines.Job
import kotlinx.coroutines.channels.SendChannel

class StoreActor(val channel: SendChannel<Job>) {
    fun close() {
        channel.close()
    }
}
