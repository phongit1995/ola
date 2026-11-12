package com.ola.me.net.org.vn

import android.app.Application
import com.appcore.AppCore
import com.appcore.CrashHandler
import com.facebook.react.PackageList
import com.facebook.react.ReactApplication
import com.facebook.react.ReactHost
import com.facebook.react.ReactNativeApplicationEntryPoint.loadReactNative
import com.facebook.react.defaults.DefaultReactHost.getDefaultReactHost
import com.livekit.reactnative.LiveKitReactNative
import com.livekit.reactnative.audio.AudioType

class MainApplication : Application(), ReactApplication {

  override val reactHost: ReactHost by lazy {
    getDefaultReactHost(
      context = applicationContext,
      packageList =
        PackageList(this).packages.apply {
          add(com.ola.me.net.org.vn.richtext.OlaRichTextPackage())
          add(com.ola.me.net.org.vn.call.OlaCallPackage())
          add(com.ola.me.net.org.vn.applock.OlaAppLockPackage())
        },
      jsBundleFilePath = resolveJsBundle(),
    )
  }

  // CrashHandler của thư viện nuốt crash 2 giây đầu rồi tự khởi động lại app;
  // chỉ bật khi đang chạy bundle OTA để còn rollback, bundle gốc thì để Crashlytics bắt.
  private fun resolveJsBundle(): String {
    val bundle = AppCore.bundleJS(applicationContext, false)
    if (!bundle.startsWith("assets://")) {
      Thread.setDefaultUncaughtExceptionHandler(CrashHandler(applicationContext))
    }
    return bundle
  }

  override fun onCreate() {
    super.onCreate()
    LiveKitReactNative.setup(this, AudioType.CommunicationAudioType())
    loadReactNative(this)
  }
}
