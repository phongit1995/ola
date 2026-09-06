package com.ola.me.net.org.vn.call

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.ResultReceiver
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.common.LifecycleState

class CallServiceModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String = NAME

  @ReactMethod
  fun start(withVideo: Boolean, promise: Promise) {
    if (
      reactApplicationContext.currentActivity == null ||
      reactApplicationContext.lifecycleState != LifecycleState.RESUMED
    ) {
      promise.reject(ERROR_BACKGROUND, "The call service requires a visible activity")
      return
    }

    val receiver = object : ResultReceiver(Handler(Looper.getMainLooper())) {
      override fun onReceiveResult(resultCode: Int, resultData: Bundle?) {
        if (resultCode == CallForegroundService.RESULT_STARTED) {
          promise.resolve(null)
          return
        }
        promise.reject(
          ERROR_START,
          resultData?.getString(CallForegroundService.EXTRA_ERROR)
            ?: "Could not start the call foreground service",
        )
      }
    }

    try {
      CallForegroundService.start(reactApplicationContext, withVideo, receiver)
    } catch (error: Exception) {
      promise.reject(ERROR_START, error)
    }
  }

  @ReactMethod
  fun stop(promise: Promise) {
    try {
      CallForegroundService.stop(reactApplicationContext)
      promise.resolve(null)
    } catch (error: Exception) {
      promise.reject(ERROR_STOP, error)
    }
  }

  companion object {
    const val NAME = "OlaCallService"
    private const val ERROR_BACKGROUND = "CALL_SERVICE_BACKGROUND"
    private const val ERROR_START = "CALL_SERVICE_START_FAILED"
    private const val ERROR_STOP = "CALL_SERVICE_STOP_FAILED"
  }
}
