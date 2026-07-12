package com.olachat.net.org.vn.richtext

import android.graphics.Canvas
import android.graphics.Color
import android.text.Layout
import android.text.StaticLayout
import android.text.TextUtils
import android.view.MotionEvent
import android.view.View
import android.view.ViewConfiguration
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableMap
import com.facebook.react.uimanager.PixelUtil
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.UIManagerHelper
import com.facebook.react.uimanager.events.Event
import kotlin.math.abs

class RichTextPressEvent(
  surfaceId: Int,
  viewId: Int,
  private val pressEventName: String,
  private val key: String,
  private val value: String,
) : Event<RichTextPressEvent>(surfaceId, viewId) {
  override fun getEventName(): String = pressEventName
  override fun getEventData(): WritableMap = Arguments.createMap().apply { putString(key, value) }
}

class OlaRichTextView(private val reactContext: ThemedReactContext) : View(reactContext) {
  var content: String = ""
  var fontSizeDp: Float = 16f
  var textColor: Int = Color.BLACK
  var accentColor: Int = Color.BLACK
  var maxLines: Int = 0

  private var staticLayout: StaticLayout? = null
  private var layoutWidth: Int = 0
  private val links = mutableListOf<LinkRange>()
  private var touchedLink: LinkRange? = null
  private var touchDownX = 0f
  private var touchDownY = 0f

  private val configListener: () -> Unit = { postInvalidate() }

  override fun onAttachedToWindow() {
    super.onAttachedToWindow()
    OlaRichTextConfig.addListener(configListener)
  }

  override fun onDetachedFromWindow() {
    super.onDetachedFromWindow()
    OlaRichTextConfig.removeListener(configListener)
  }

  fun rebuild() {
    staticLayout = null
    invalidate()
  }

  private fun ensureLayout(width: Int) {
    if (staticLayout != null && layoutWidth == width) return
    layoutWidth = width
    links.clear()
    val fontSizePx = PixelUtil.toPixelFromDIP(fontSizeDp)
    val paint = OlaTokenizer.textPaint(fontSizePx).apply { color = textColor }
    val spannable = OlaTokenizer.buildRich(content, fontSizePx, accentColor, links)
    val builder = StaticLayout.Builder
      .obtain(spannable, 0, spannable.length, paint, width.coerceAtLeast(0))
      .setIncludePad(true)
    if (maxLines > 0) {
      builder.setMaxLines(maxLines)
      builder.setEllipsize(TextUtils.TruncateAt.END)
    }
    staticLayout = builder.build()
  }

  override fun onDraw(canvas: Canvas) {
    super.onDraw(canvas)
    if (width <= 0) return
    ensureLayout(width)
    staticLayout?.draw(canvas)
  }

  private fun linkAt(x: Float, y: Float): LinkRange? {
    val layout = staticLayout ?: return null
    if (links.isEmpty()) return null
    if (y < 0 || y > layout.height) return null
    val line = layout.getLineForVertical(y.toInt())
    if (x < layout.getLineLeft(line) - 8 || x > layout.getLineRight(line) + 8) return null
    val offset = layout.getOffsetForHorizontal(line, x)
    return links.firstOrNull { offset >= it.start && offset <= it.end }
  }

  override fun onTouchEvent(event: MotionEvent): Boolean {
    when (event.actionMasked) {
      MotionEvent.ACTION_DOWN -> {
        ensureLayout(width)
        val link = linkAt(event.x, event.y) ?: return false
        touchedLink = link
        touchDownX = event.x
        touchDownY = event.y
        return true
      }
      MotionEvent.ACTION_MOVE -> {
        val slop = ViewConfiguration.get(context).scaledTouchSlop
        if (abs(event.x - touchDownX) > slop || abs(event.y - touchDownY) > slop) {
          touchedLink = null
        }
        return touchedLink != null
      }
      MotionEvent.ACTION_UP -> {
        val link = touchedLink ?: return false
        touchedLink = null
        if (linkAt(event.x, event.y) === link) emitLinkPress(link)
        return true
      }
      MotionEvent.ACTION_CANCEL -> {
        val hadLink = touchedLink != null
        touchedLink = null
        return hadLink
      }
    }
    return touchedLink != null
  }

  private fun emitLinkPress(link: LinkRange) {
    val dispatcher = UIManagerHelper.getEventDispatcherForReactTag(reactContext, id) ?: return
    val surfaceId = UIManagerHelper.getSurfaceId(reactContext)
    val event = when (link.kind) {
      LinkKind.MENTION -> RichTextPressEvent(surfaceId, id, "topMentionPress", "nick", link.payload)
      LinkKind.URL -> RichTextPressEvent(surfaceId, id, "topUrlPress", "url", link.payload)
    }
    dispatcher.dispatchEvent(event)
  }
}
