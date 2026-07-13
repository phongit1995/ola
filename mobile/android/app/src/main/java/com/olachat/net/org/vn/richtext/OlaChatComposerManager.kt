package com.olachat.net.org.vn.richtext

import android.graphics.Color
import com.facebook.react.bridge.ReadableArray
import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.uimanager.SimpleViewManager
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.ViewManagerDelegate
import com.facebook.react.viewmanagers.OlaChatComposerManagerDelegate
import com.facebook.react.viewmanagers.OlaChatComposerManagerInterface

@ReactModule(name = OlaChatComposerManager.NAME)
class OlaChatComposerManager :
  SimpleViewManager<OlaChatComposerView>(),
  OlaChatComposerManagerInterface<OlaChatComposerView> {

  private val delegate = OlaChatComposerManagerDelegate(this)

  override fun getDelegate(): ViewManagerDelegate<OlaChatComposerView> = delegate

  override fun getName(): String = NAME

  override fun createViewInstance(reactContext: ThemedReactContext): OlaChatComposerView =
    OlaChatComposerView(reactContext)

  override fun setFontSize(view: OlaChatComposerView, value: Float) {
    view.fontSizeDp = value
  }

  override fun setMaxHeight(view: OlaChatComposerView, value: Float) = Unit

  override fun setPaddingH(view: OlaChatComposerView, value: Float) {
    view.applyComposerPadding(value, null)
  }

  override fun setPaddingV(view: OlaChatComposerView, value: Float) {
    view.applyComposerPadding(null, value)
  }

  override fun setPlaceholder(view: OlaChatComposerView, value: String?) {
    view.hint = value
  }

  override fun setPlaceholderTextColor(view: OlaChatComposerView, value: Int?) {
    view.setHintTextColor(value ?: Color.argb(97, 0, 0, 0))
  }

  override fun setTextColor(view: OlaChatComposerView, value: Int?) {
    view.setTextColor(value ?: Color.BLACK)
  }

  override fun setSelectionColor(view: OlaChatComposerView, value: Int?) {
    view.applySelectionColor(value)
  }

  override fun setEditable(view: OlaChatComposerView, value: Boolean) {
    view.isEnabled = value
    view.isFocusable = value
    view.isFocusableInTouchMode = value
  }

  override fun setAlignTop(view: OlaChatComposerView, value: Boolean) {
    view.gravity = if (value) {
      android.view.Gravity.TOP or android.view.Gravity.START
    } else {
      android.view.Gravity.CENTER_VERTICAL
    }
  }

  override fun setInitialText(view: OlaChatComposerView, value: String?) {
    if (value != null && value.isNotEmpty() && view.serializedText().isEmpty()) {
      view.setTokenText(value)
    }
  }

  override fun insertCode(view: OlaChatComposerView, code: String?, trailingSpace: Boolean) {
    view.insertCodeAtCursor(code ?: "", trailingSpace)
  }

  override fun insertText(view: OlaChatComposerView, text: String?) {
    view.insertTextAtCursor(text ?: "")
  }

  override fun backspace(view: OlaChatComposerView) {
    view.backspaceAtCursor()
  }

  override fun setText(view: OlaChatComposerView, text: String?) {
    view.setTokenText(text ?: "")
  }

  override fun focus(view: OlaChatComposerView) {
    view.requestFocus()
    val inputMethodManager = view.context.getSystemService(android.content.Context.INPUT_METHOD_SERVICE)
      as? android.view.inputmethod.InputMethodManager
    inputMethodManager?.showSoftInput(view, 0)
  }

  override fun blur(view: OlaChatComposerView) {
    view.clearFocus()
    val inputMethodManager = view.context.getSystemService(android.content.Context.INPUT_METHOD_SERVICE)
      as? android.view.inputmethod.InputMethodManager
    inputMethodManager?.hideSoftInputFromWindow(view.windowToken, 0)
  }

  override fun receiveCommand(root: OlaChatComposerView, commandId: String, args: ReadableArray?) {
    delegate.receiveCommand(root, commandId, args)
  }

  override fun getExportedCustomDirectEventTypeConstants(): Map<String, Any> = mapOf(
    "topChangeText" to mapOf("registrationName" to "onChangeText"),
    "topComposerHeight" to mapOf("registrationName" to "onComposerHeight"),
    "topComposerFocus" to mapOf("registrationName" to "onComposerFocus"),
    "topComposerBlur" to mapOf("registrationName" to "onComposerBlur"),
  )

  companion object {
    const val NAME = "OlaChatComposer"
  }
}
