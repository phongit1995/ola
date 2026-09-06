package com.ola.me.net.org.vn.richtext

import android.content.ClipboardManager
import android.content.Context
import android.graphics.Color
import android.net.Uri
import android.os.Build
import android.text.Editable
import android.util.TypedValue
import android.text.InputType
import android.text.Spannable
import android.text.SpannableStringBuilder
import android.text.TextWatcher
import android.view.Gravity
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.InputConnection
import androidx.appcompat.widget.AppCompatEditText
import androidx.core.view.inputmethod.EditorInfoCompat
import androidx.core.view.inputmethod.InputConnectionCompat
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableMap
import com.facebook.react.uimanager.PixelUtil
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.UIManagerHelper
import com.facebook.react.uimanager.events.Event
import java.io.File
import java.io.FileOutputStream
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

class ComposerPasteImageEvent(
  surfaceId: Int,
  viewId: Int,
  private val uri: String,
) : Event<ComposerPasteImageEvent>(surfaceId, viewId) {
  override fun getEventName(): String = "topPasteImage"
  override fun getEventData(): WritableMap = Arguments.createMap().apply { putString("uri", uri) }
}

class OlaChatComposerView(private val reactContext: ThemedReactContext) :
  AppCompatEditText(reactContext) {

  private val configListener: () -> Unit = { invalidate() }

  var fontSizeDp: Float = 16f
    set(value) {
      val next = if (value > 0) value else 16f
      if (next == field) return
      field = next
      setTextSize(TypedValue.COMPLEX_UNIT_PX, PixelUtil.toPixelFromDIP(next))
      // TokenImageSpan nhận kích thước qua constructor nên phải dựng lại theo cỡ mới, không
      // thì token giữ cỡ cũ trong khi chữ quanh nó đã đổi.
      val current = serializedText()
      if (current.isNotEmpty()) setTokenText(current)
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

  override fun onTextContextMenuItem(id: Int): Boolean {
    if (id == android.R.id.paste || id == android.R.id.pasteAsPlainText) {
      if (tryPasteImageFromClipboard()) return true
    }
    return super.onTextContextMenuItem(id)
  }

  private fun tryPasteImageFromClipboard(): Boolean {
    val clipboard =
      context.getSystemService(Context.CLIPBOARD_SERVICE) as? ClipboardManager ?: return false
    val clip = clipboard.primaryClip ?: return false
    for (index in 0 until clip.itemCount) {
      val uri = clip.getItemAt(index).uri ?: continue
      val mime = context.contentResolver.getType(uri) ?: continue
      if (!mime.startsWith("image/")) continue
      val cachedUri = copyImageToCache(uri, mime) ?: continue
      emitPasteImage(cachedUri)
      return true
    }
    return false
  }

  override fun onCreateInputConnection(outAttrs: EditorInfo): InputConnection? {
    val connection = super.onCreateInputConnection(outAttrs) ?: return null
    EditorInfoCompat.setContentMimeTypes(outAttrs, arrayOf("image/*"))
    return InputConnectionCompat.createWrapper(connection, outAttrs) { contentInfo, flags, _ ->
      try {
        if ((flags and InputConnectionCompat.INPUT_CONTENT_GRANT_READ_URI_PERMISSION) != 0) {
          contentInfo.requestPermission()
        }
        val mime = context.contentResolver.getType(contentInfo.contentUri)
          ?: contentInfo.description.getMimeType(0)
          ?: "image/jpeg"
        val cachedUri = copyImageToCache(contentInfo.contentUri, mime)
        contentInfo.releasePermission()
        if (cachedUri != null) {
          emitPasteImage(cachedUri)
          true
        } else {
          false
        }
      } catch (error: Exception) {
        false
      }
    }
  }

  private fun copyImageToCache(uri: Uri, mime: String): String? = try {
    if (mime.contains("gif") || mime.contains("webp")) {
      copyRawToCache(uri, if (mime.contains("gif")) "gif" else "webp")
    } else {
      copyScaledToCache(uri)
    }
  } catch (error: Exception) {
    null
  }

  private fun copyRawToCache(uri: Uri, extension: String): String? {
    val file = File(context.cacheDir, "paste-${System.currentTimeMillis()}.$extension")
    val copied = context.contentResolver.openInputStream(uri)?.use { input ->
      FileOutputStream(file).use { output -> input.copyTo(output) }
      true
    } ?: false
    return if (copied) Uri.fromFile(file).toString() else null
  }

  private fun copyScaledToCache(uri: Uri): String? {
    val maxDimension = 1920
    val bounds = android.graphics.BitmapFactory.Options().apply { inJustDecodeBounds = true }
    context.contentResolver.openInputStream(uri)?.use { input ->
      android.graphics.BitmapFactory.decodeStream(input, null, bounds)
    } ?: return null
    if (bounds.outWidth <= 0 || bounds.outHeight <= 0) return null
    var sampleSize = 1
    while (
      bounds.outWidth / (sampleSize * 2) >= maxDimension ||
      bounds.outHeight / (sampleSize * 2) >= maxDimension
    ) {
      sampleSize *= 2
    }
    val decodeOptions = android.graphics.BitmapFactory.Options().apply { inSampleSize = sampleSize }
    val decoded = context.contentResolver.openInputStream(uri)?.use { input ->
      android.graphics.BitmapFactory.decodeStream(input, null, decodeOptions)
    } ?: return null
    val largest = maxOf(decoded.width, decoded.height)
    val bitmap = if (largest > maxDimension) {
      val ratio = maxDimension.toFloat() / largest
      android.graphics.Bitmap.createScaledBitmap(
        decoded,
        (decoded.width * ratio).toInt().coerceAtLeast(1),
        (decoded.height * ratio).toInt().coerceAtLeast(1),
        true,
      )
    } else {
      decoded
    }
    val file = File(context.cacheDir, "paste-${System.currentTimeMillis()}.jpg")
    FileOutputStream(file).use { output ->
      bitmap.compress(android.graphics.Bitmap.CompressFormat.JPEG, 90, output)
    }
    if (bitmap !== decoded) bitmap.recycle()
    decoded.recycle()
    return Uri.fromFile(file).toString()
  }

  private fun emitPasteImage(uri: String) {
    val dispatcher = UIManagerHelper.getEventDispatcherForReactTag(reactContext, id) ?: return
    dispatcher.dispatchEvent(
      ComposerPasteImageEvent(UIManagerHelper.getSurfaceId(reactContext), id, uri)
    )
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
