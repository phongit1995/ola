package com.olachat.net.org.vn.richtext

import android.graphics.Color
import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.uimanager.SimpleViewManager
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.ViewManagerDelegate
import com.facebook.react.viewmanagers.OlaRichTextViewManagerDelegate
import com.facebook.react.viewmanagers.OlaRichTextViewManagerInterface

@ReactModule(name = OlaRichTextViewManager.NAME)
class OlaRichTextViewManager :
  SimpleViewManager<OlaRichTextView>(),
  OlaRichTextViewManagerInterface<OlaRichTextView> {

  private val delegate = OlaRichTextViewManagerDelegate(this)

  override fun getDelegate(): ViewManagerDelegate<OlaRichTextView> = delegate

  override fun getName(): String = NAME

  override fun createViewInstance(reactContext: ThemedReactContext): OlaRichTextView =
    OlaRichTextView(reactContext)

  override fun setContent(view: OlaRichTextView, value: String?) {
    view.content = value ?: ""
  }

  override fun setFontSize(view: OlaRichTextView, value: Float) {
    view.fontSizeDp = if (value > 0) value else 16f
  }

  override fun setTextColor(view: OlaRichTextView, value: Int?) {
    view.textColor = value ?: Color.BLACK
  }

  override fun setAccentColor(view: OlaRichTextView, value: Int?) {
    view.accentColor = value ?: view.textColor
  }

  override fun setMaxLines(view: OlaRichTextView, value: Int) {
    view.maxLines = value
  }

  override fun onAfterUpdateTransaction(view: OlaRichTextView) {
    super.onAfterUpdateTransaction(view)
    view.rebuild()
  }

  override fun getExportedCustomDirectEventTypeConstants(): Map<String, Any> = mapOf(
    "topMentionPress" to mapOf("registrationName" to "onMentionPress"),
    "topUrlPress" to mapOf("registrationName" to "onUrlPress"),
  )

  companion object {
    const val NAME = "OlaRichTextView"
  }
}
