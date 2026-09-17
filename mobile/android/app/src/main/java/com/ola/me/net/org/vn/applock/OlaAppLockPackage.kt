package com.ola.me.net.org.vn.applock

import com.facebook.react.BaseReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.module.model.ReactModuleInfo
import com.facebook.react.module.model.ReactModuleInfoProvider

class OlaAppLockPackage : BaseReactPackage() {

  override fun getModule(name: String, reactContext: ReactApplicationContext): NativeModule? =
    if (name == NativeOlaAppLockModule.NAME) NativeOlaAppLockModule(reactContext) else null

  override fun getReactModuleInfoProvider(): ReactModuleInfoProvider = ReactModuleInfoProvider {
    mapOf(
      NativeOlaAppLockModule.NAME to ReactModuleInfo(
        NativeOlaAppLockModule.NAME,
        NativeOlaAppLockModule::class.java.name,
        false,
        false,
        false,
        true,
      )
    )
  }
}
