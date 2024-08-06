package ru.mrdekk.notes.generic.arch.action

interface ActionExecutor<ACT: Action> {
    fun send(action: ACT)
}
