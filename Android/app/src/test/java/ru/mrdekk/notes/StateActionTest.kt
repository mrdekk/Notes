package ru.mrdekk.notes

import kotlinx.coroutines.launch
import kotlinx.coroutines.test.UnconfinedTestDispatcher
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.runTest
import org.junit.Test
import ru.mrdekk.notes.generic.arch.Reducer
import ru.mrdekk.notes.generic.arch.Store
import ru.mrdekk.notes.generic.arch.action.Action
import ru.mrdekk.notes.generic.arch.state.State

class StateActionTest {
    @Test
    fun `when working with states then we can send actions and observe state changes`() = runTest {
        val actor = Store.createStoreActor(this)
        val store = Store(StateForTest(0), reducerForTest, this, actor)

        assert(store.currentValue.value == 0)

        var step = 0

        // mimic the view
        val job1 = launch(UnconfinedTestDispatcher(testScheduler)) {
            store.updates.collect {
                when (step) {
                    0 -> {
                        assert(it.value == 0)
                        step += 1
                    }
                    1 -> {
                        assert(it.value == 2)
                        step += 1
                    }
                    2 -> {
                        assert(it.value == -1)
                        step += 1
                    }
                }
            }
        }

        // mimic the background service
        val job2 = launch(UnconfinedTestDispatcher(testScheduler)) {
            store.updates.collect {
                if (it.value == 2) {
                    store.send(ActionsForTest.Sub(3))
                }
            }
        }

        store.send(ActionsForTest.Add(2))
        advanceUntilIdle()

        job1.cancel()
        job2.cancel()
        actor.close()

        assert(step == 3)
    }
}

sealed interface ActionsForTest: Action {
    data class Add(val op: Int): ActionsForTest
    data class Sub(val op: Int): ActionsForTest
}

private data class StateForTest(val value: Int): State

private val reducerForTest: Reducer<StateForTest, ActionsForTest> = { state, action ->
    when (action) {
        is ActionsForTest.Add -> StateForTest(state.value + action.op)
        is ActionsForTest.Sub -> StateForTest(state.value - action.op)
    }
}
