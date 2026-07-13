package com.olachat.net.org.vn.richtext

import com.facebook.react.BaseReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.module.model.ReactModuleInfo
import com.facebook.react.module.model.ReactModuleInfoProvider
import com.facebook.react.uimanager.ViewManager

class OlaRichTextPackage : BaseReactPackage() {

  override fun getModule(name: String, reactContext: ReactApplicationContext): NativeModule? =
    if (name == NativeOlaRichTextModule.NAME) NativeOlaRichTextModule(reactContext) else null

  override fun getReactModuleInfoProvider(): ReactModuleInfoProvider = ReactModuleInfoProvider {
    mapOf(
      NativeOlaRichTextModule.NAME to ReactModuleInfo(
        NativeOlaRichTextModule.NAME,
        NativeOlaRichTextModule::class.java.name,
        false,
        false,
        false,
        true,
      )
    )
  }

  override fun createViewManagers(
    reactContext: ReactApplicationContext,
  ): List<ViewManager<*, *>> = listOf(OlaRichTextViewManager(), OlaChatComposerManager())
}
