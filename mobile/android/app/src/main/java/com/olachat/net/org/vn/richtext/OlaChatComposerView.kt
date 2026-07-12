package com.olachat.net.org.vn.richtext

import android.graphics.Color
import android.os.Build
import android.text.Editable
import android.util.TypedValue
import android.text.InputType
import android.text.Spannable
import android.text.SpannableStringBuilder
import android.text.TextWatcher
import android.view.Gravity
import androidx.appcompat.widget.AppCompatEditText
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableMap
import com.facebook.react.uimanager.PixelUtil
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.UIManagerHelper
import com.facebook.react.uimanager.events.Event
import kotlin.math.roundToInt

class ComposerTextEvent(
  surfaceId: Int,
  viewId: Int,
  private val text: String,
) : Event<ComposerTextEvent>(surfaceId, viewId) {
  override fun getEventName(): String = "topChangeText"
  override fun getEventData(): WritableMap = Arguments.createMap().apply { putString("text", text) }
}

class ComposerHeightEvent(
  surfaceId: Int,
  viewId: Int,
  private val heightDp: Float,
) : Event<ComposerHeightEvent>(surfaceId, viewId) {
  override fun getEventName(): String = "topComposerHeight"
  override fun getEventData(): WritableMap =
    Arguments.createMap().apply { putDouble("height", heightDp.toDouble()) }
}

class ComposerFocusEvent(
  surfaceId: Int,
  viewId: Int,
  private val focusEventName: String,
) : Event<ComposerFocusEvent>(surfaceId, viewId) {
  override fun getEventName(): String = focusEventName
  override fun getEventData(): WritableMap = Arguments.createMap()
}

class OlaChatComposerView(private val reactContext: ThemedReactContext) :
  AppCompatEditText(reactContext) {

  private val configListener: () -> Unit = { invalidate() }

  var fontSizeDp: Float = 16f
    set(value) {
      field = if (value > 0) value else 16f
      setTextSize(TypedValue.COMPLEX_UNIT_PX, PixelUtil.toPixelFromDIP(field))
    }

  private var suppressChangeEvent = false
  private var repairing = false
  private var lastEmittedHeight = 0f
  private var paddingHDp = 12f
  private var paddingVDp = 8f

  fun applyComposerPadding(horizontalDp: Float?, verticalDp: Float?) {
    if (horizontalDp != null) paddingHDp = horizontalDp
    if (verticalDp != null) paddingVDp = verticalDp
    setPadding(
      PixelUtil.toPixelFromDIP(paddingHDp).roundToInt(),
      PixelUtil.toPixelFromDIP(paddingVDp).roundToInt(),
      PixelUtil.toPixelFromDIP(paddingHDp).roundToInt(),
      PixelUtil.toPixelFromDIP(paddingVDp).roundToInt(),
    )
  }

  init {
    background = null
    gravity = Gravity.CENTER_VERTICAL
    inputType = InputType.TYPE_CLASS_TEXT or
      InputType.TYPE_TEXT_FLAG_MULTI_LINE or
      InputType.TYPE_TEXT_FLAG_CAP_SENTENCES
    applyComposerPadding(null, null)
    setTextSize(TypedValue.COMPLEX_UNIT_PX, PixelUtil.toPixelFromDIP(fontSizeDp))
    isVerticalScrollBarEnabled = true

    addTextChangedListener(object : TextWatcher {
      override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) = Unit
      override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) = Unit
      override fun afterTextChanged(s: Editable?) {
        if (repairing || s == null) return
        repairing = true
        repairSpans(s)
        repairing = false
        if (!suppressChangeEvent) emitChangeText()
        post { emitHeightIfNeeded() }
      }
    })

    setOnFocusChangeListener { _, hasFocus ->
      emitFocusEvent(if (hasFocus) "topComposerFocus" else "topComposerBlur")
    }

    OlaRichTextConfig.addListener(configListener)
  }

  override fun onDetachedFromWindow() {
    super.onDetachedFromWindow()
    OlaRichTextConfig.removeListener(configListener)
  }

  private fun repairSpans(editable: Editable) {
    val spans = editable.getSpans(0, editable.length, TokenImageSpan::class.java)
    val broken = spans.filter { span ->
      val start = editable.getSpanStart(span)
      val end = editable.getSpanEnd(span)
      start < 0 || end > editable.length || editable.subSequence(start, end).toString() != span.code
    }
    if (broken.isEmpty()) return
    val ranges = broken
      .map { span -> Pair(editable.getSpanStart(span), editable.getSpanEnd(span)) }
      .sortedByDescending { it.first }
    for (span in broken) editable.removeSpan(span)
    for ((start, end) in ranges) {
      if (start in 0 until end && end <= editable.length) editable.delete(start, end)
    }
  }

  override fun onSelectionChanged(selStart: Int, selEnd: Int) {
    super.onSelectionChanged(selStart, selEnd)
    val editable = text ?: return
    if (repairing) return
    val spans = editable.getSpans(0, editable.length, TokenImageSpan::class.java)
    var newStart = selStart
    var newEnd = selEnd
    for (span in spans) {
      val start = editable.getSpanStart(span)
      val end = editable.getSpanEnd(span)
      if (newStart in (start + 1) until end) newStart = if (newStart - start <= end - newStart) start else end
      if (newEnd in (start + 1) until end) newEnd = if (newEnd - start <= end - newEnd) start else end
    }
    if (newStart != selStart || newEnd != selEnd) setSelection(newStart, newEnd)
  }

  fun serializedText(): String = text?.toString() ?: ""

  private fun emitChangeText() {
    val dispatcher = UIManagerHelper.getEventDispatcherForReactTag(reactContext, id) ?: return
    dispatcher.dispatchEvent(
      ComposerTextEvent(UIManagerHelper.getSurfaceId(reactContext), id, serializedText())
    )
  }

  fun emitHeightIfNeeded() {
    val contentHeight = layout?.height ?: return
    val desired = contentHeight + compoundPaddingTop + compoundPaddingBottom
    val heightDp = PixelUtil.toDIPFromPixel(desired.toFloat())
    if (kotlin.math.abs(heightDp - lastEmittedHeight) < 1f) return
    lastEmittedHeight = heightDp
    val dispatcher = UIManagerHelper.getEventDispatcherForReactTag(reactContext, id) ?: return
    dispatcher.dispatchEvent(
      ComposerHeightEvent(UIManagerHelper.getSurfaceId(reactContext), id, heightDp)
    )
  }

  private fun emitFocusEvent(eventName: String) {
    val dispatcher = UIManagerHelper.getEventDispatcherForReactTag(reactContext, id) ?: return
    dispatcher.dispatchEvent(
      ComposerFocusEvent(UIManagerHelper.getSurfaceId(reactContext), id, eventName)
    )
  }

  private fun fontSizePx(): Float = PixelUtil.toPixelFromDIP(fontSizeDp)

  fun insertCodeAtCursor(code: String, trailingSpace: Boolean) {
    val fragment = OlaTokenizer.buildComposerFragment(code, fontSizePx())
    if (trailingSpace) fragment.append(' ')
    insertFragment(fragment)
  }

  fun insertTextAtCursor(value: String) {
    insertFragment(SpannableStringBuilder(value))
  }

  private fun insertFragment(fragment: CharSequence) {
    val editable = text ?: return
    val start = selectionStart.coerceAtLeast(0)
    val end = selectionEnd.coerceAtLeast(start)
    editable.replace(start, end, fragment)
    setSelection((start + fragment.length).coerceAtMost(editable.length))
  }

  fun backspaceAtCursor() {
    val editable = text ?: return
    val start = selectionStart
    val end = selectionEnd
    if (start < 0) return
    if (start != end) {
      editable.delete(start.coerceAtLeast(0), end)
      return
    }
    if (start == 0) return
    val spans = editable.getSpans(start, start, TokenImageSpan::class.java)
    val spanEndingHere = spans.firstOrNull { editable.getSpanEnd(it) == start }
    if (spanEndingHere != null) {
      editable.delete(editable.getSpanStart(spanEndingHere), start)
      return
    }
    val previousIndex = if (start >= 2 && Character.isSurrogatePair(editable[start - 2], editable[start - 1])) {
      start - 2
    } else {
      start - 1
    }
    editable.delete(previousIndex, start)
  }

  fun setTokenText(value: String) {
    suppressChangeEvent = true
    setText(OlaTokenizer.buildComposerFragment(value, fontSizePx()), BufferType.SPANNABLE)
    setSelection(text?.length ?: 0)
    suppressChangeEvent = false
    post { emitHeightIfNeeded() }
  }

  fun applySelectionColor(color: Int?) {
    highlightColor = color ?: Color.argb(60, 124, 179, 66)
    if (color != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
      textCursorDrawable?.setTint(color)
    }
  }

  override fun onLayout(changed: Boolean, left: Int, top: Int, right: Int, bottom: Int) {
    super.onLayout(changed, left, top, right, bottom)
    emitHeightIfNeeded()
  }
}
