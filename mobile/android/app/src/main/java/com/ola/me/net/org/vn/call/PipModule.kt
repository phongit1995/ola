package com.ola.me.net.org.vn.call

import android.os.Build
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.UiThreadUtil
import com.facebook.react.modules.core.DeviceEventManagerModule

class PipModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  init {
    instance = this
  }

  override fun getName(): String = NAME

  override fun invalidate() {
    // Reload JS giữa cuộc gọi thì effect cleanup không chạy — reset cờ ở đây
    // để app không tự chui vào PiP khi đã hết call.
    pipEnabled = false
    if (instance === this) instance = null
    super.invalidate()
  }

  @ReactMethod
  fun setPipSupported(enabled: Boolean, aspectW: Double, aspectH: Double) {
    pipEnabled = enabled
    if (aspectW > 0 && aspectH > 0) {
      aspectWidth = aspectW.toInt()
      aspectHeight = aspectH.toInt()
    }
  }

  // Android không tự đóng cửa sổ PiP khi call kết thúc; moveTaskToBack là cách
  // chuẩn để dismiss nó mà không kill app.
  @ReactMethod
  fun exitPip() {
    val activity = reactApplicationContext.currentActivity ?: return
    UiThreadUtil.runOnUiThread {
      if (
        Build.VERSION.SDK_INT >= Build.VERSION_CODES.N &&
        activity.isInPictureInPictureMode
      ) {
        activity.moveTaskToBack(false)
      }
    }
  }

  private fun emit(event: String, value: Boolean) {
    if (!reactApplicationContext.hasActiveReactInstance()) return
    reactApplicationContext
      .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
      .emit(event, value)
  }

  companion object {
    const val NAME = "OlaCallPip"
    const val EVENT_PIP_CHANGED = "OlaCallPipModeChanged"
    const val EVENT_PIP_CLOSED = "OlaCallPipClosed"

    @Volatile
    var pipEnabled: Boolean = false
      private set

    @Volatile
    var aspectWidth: Int = 9
      private set

    @Volatile
    var aspectHeight: Int = 16
      private set

    @Volatile
    private var instance: PipModule? = null

    fun notifyPipChanged(isInPip: Boolean) {
      instance?.emit(EVENT_PIP_CHANGED, isInPip)
    }

    fun notifyPipClosed() {
      instance?.emit(EVENT_PIP_CLOSED, true)
    }
  }
}
