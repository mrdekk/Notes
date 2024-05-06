package ru.mrdekk.notes.generic.arch

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.CoroutineStart
import kotlinx.coroutines.channels.actor
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.launch
import ru.mrdekk.notes.generic.arch.action.Action
import ru.mrdekk.notes.generic.arch.action.ActionExecutor
import ru.mrdekk.notes.generic.arch.state.State
import ru.mrdekk.notes.generic.arch.state.StatePublisher

typealias Reducer<ST, ACT> = (state: ST, action: ACT) -> ST

class Store<ST: State, ACT: Action>(
    private val initialState: ST,
    private val reducer: Reducer<ST, ACT>,
    private val coroutineScope: CoroutineScope,
    private val actor: StoreActor
): StatePublisher<ST>, ActionExecutor<ACT> {

    private val _updates = MutableStateFlow(initialState)

    init {
        coroutineScope.launch {
            _updates.emit(initialState)
        }
    }

    fun cleanup() {
        // cleanup code here
    }

    // StatePublisher<ST>

    override val currentValue: ST = _updates.value
    override val updates: Flow<ST> = _updates

    // ActionExecutor<ACT>

    override fun send(action: ACT) {
        coroutineScope.launch {
            actor.channel.send(coroutineScope.launch(start = CoroutineStart.LAZY) {
                val currentState = _updates.value
                val newState = reducer(currentState, action)
                _updates.emit(newState)
            })
        }
    }

    companion object {
        fun createStoreActor(coroutineScope: CoroutineScope): StoreActor {
            return StoreActor(coroutineScope.actor {
                for (job in this) {
                    job.join()
                }
            })
        }
    }
}
