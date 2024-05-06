package ru.mrdekk.notes.generic.di

import android.app.Activity

fun Activity.inject() {
    val thisAsInjectable = this as? Injectable ?: throw InjectException("activity is not injectable")
    val application = application ?: throw InjectException("application isn't set to activity")
    val injector = application as? Injector<Injectable> ?: throw InjectException("application is not an injector")
    injector.inject(thisAsInjectable)
}
