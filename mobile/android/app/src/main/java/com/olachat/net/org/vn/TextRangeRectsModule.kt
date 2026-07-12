package com.olachat.net.org.vn

import android.widget.EditText
import com.facebook.react.ReactPackage
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.ReadableArray
import com.facebook.react.bridge.UiThreadUtil
import com.facebook.react.uimanager.PixelUtil
import com.facebook.react.uimanager.UIManagerHelper
import com.facebook.react.uimanager.ViewManager
import com.facebook.react.uimanager.common.UIManagerType

class TextRangeRectsModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  override fun getName() = "TextRangeRects"

  @ReactMethod
  fun measure(tag: Double, starts: ReadableArray, promise: Promise) {
    UiThreadUtil.runOnUiThread {
      try {
        val uiManager = UIManagerHelper.getUIManager(reactApplicationContext, UIManagerType.FABRIC)
        val edit = uiManager?.resolveView(tag.toInt()) as? EditText
        val layout = edit?.layout
        if (edit == null || layout == null) {
          promise.reject("no_input", "text input not found for tag")
          return@runOnUiThread
        }
        val result = Arguments.createArray()
        val textLength = layout.text.length
        for (index in 0 until starts.size()) {
          val start = starts.getInt(index)
          val rect = Arguments.createMap()
          if (start < 0 || start >= textLength) {
            rect.putDouble("x", 0.0)
            rect.putDouble("y", 0.0)
            rect.putDouble("width", 0.0)
            rect.putDouble("height", 0.0)
            result.pushMap(rect)
            continue
          }
          val line = layout.getLineForOffset(start)
          val startX = layout.getPrimaryHorizontal(start)
          val endX =
            if (layout.getLineForOffset(start + 1) == line) {
              layout.getPrimaryHorizontal(start + 1)
            } else {
              layout.getLineRight(line)
            }
          val left = minOf(startX, endX) + edit.totalPaddingLeft
          val top = layout.getLineTop(line).toFloat() + edit.totalPaddingTop
          rect.putDouble("x", PixelUtil.toDIPFromPixel(left).toDouble())
          rect.putDouble("y", PixelUtil.toDIPFromPixel(top).toDouble())
          rect.putDouble("width", PixelUtil.toDIPFromPixel(kotlin.math.abs(endX - startX)).toDouble())
          rect.putDouble(
            "height",
            PixelUtil.toDIPFromPixel((layout.getLineBottom(line) - layout.getLineTop(line)).toFloat())
              .toDouble()
          )
          result.pushMap(rect)
        }
        promise.resolve(result)
      } catch (error: Throwable) {
        promise.reject("measure_failed", error)
      }
    }
  }
}

class TextRangeRectsPackage : ReactPackage {
  override fun createNativeModules(reactContext: ReactApplicationContext): List<NativeModule> =
    listOf(TextRangeRectsModule(reactContext))

  override fun createViewManagers(
    reactContext: ReactApplicationContext
  ): List<ViewManager<*, *>> = emptyList()
}
