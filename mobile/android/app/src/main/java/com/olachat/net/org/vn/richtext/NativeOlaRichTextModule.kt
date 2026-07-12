package com.olachat.net.org.vn.richtext

import android.text.StaticLayout
import android.text.TextUtils
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.WritableArray
import com.facebook.react.uimanager.PixelUtil
import kotlin.math.ceil

class NativeOlaRichTextModule(reactContext: ReactApplicationContext) :
  NativeOlaRichTextSpec(reactContext) {

  override fun configure(config: ReadableMap) {
    OlaRichTextConfig.configure(config, reactApplicationContext)
  }

  override fun measure(
    content: String,
    maxWidth: Double,
    fontSize: Double,
    maxLines: Double,
  ): WritableArray {
    val maxWidthPx = PixelUtil.toPixelFromDIP(maxWidth.toFloat()).toInt().coerceAtLeast(0)
    val fontSizePx = PixelUtil.toPixelFromDIP(fontSize.toFloat())
    val paint = OlaTokenizer.textPaint(fontSizePx)
    val spannable = OlaTokenizer.buildRich(content, fontSizePx, 0, null)
    val builder = StaticLayout.Builder
      .obtain(spannable, 0, spannable.length, paint, maxWidthPx)
      .setIncludePad(true)
    val lines = maxLines.toInt()
    if (lines > 0) {
      builder.setMaxLines(lines)
      builder.setEllipsize(TextUtils.TruncateAt.END)
    }
    val layout = builder.build()
    var usedWidth = 0f
    for (line in 0 until layout.lineCount) {
      if (layout.getLineWidth(line) > usedWidth) usedWidth = layout.getLineWidth(line)
    }
    val widthDp = PixelUtil.toDIPFromPixel(ceil(usedWidth)).coerceAtMost(maxWidth.toFloat())
    val heightDp = PixelUtil.toDIPFromPixel(layout.height.toFloat())
    return Arguments.createArray().apply {
      pushDouble(widthDp.toDouble())
      pushDouble(heightDp.toDouble())
    }
  }

  companion object {
    const val NAME = NativeOlaRichTextSpec.NAME
  }
}
