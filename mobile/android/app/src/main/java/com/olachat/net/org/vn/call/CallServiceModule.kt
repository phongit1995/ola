package com.olachat.net.org.vn.call

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod

class CallServiceModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String = NAME

  @ReactMethod
  fun start(withVideo: Boolean) {
    runCatching { CallForegroundService.start(reactApplicationContext, withVideo) }
  }

  @ReactMethod
  fun stop() {
    runCatching { CallForegroundService.stop(reactApplicationContext) }
  }

  companion object {
    const val NAME = "OlaCallService"
  }
}
