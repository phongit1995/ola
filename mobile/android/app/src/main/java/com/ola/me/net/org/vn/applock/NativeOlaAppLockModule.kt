package com.ola.me.net.org.vn.applock

import android.content.pm.PackageManager
import android.os.Build
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricManager.Authenticators.BIOMETRIC_STRONG
import androidx.biometric.BiometricManager.Authenticators.BIOMETRIC_WEAK
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.UiThreadUtil
import com.ola.me.net.org.vn.richtext.NativeOlaAppLockSpec

class NativeOlaAppLockModule(reactContext: ReactApplicationContext) :
  NativeOlaAppLockSpec(reactContext) {

  override fun getName(): String = NAME

  override fun biometryType(promise: Promise) {
    val manager = BiometricManager.from(reactApplicationContext)
    if (manager.canAuthenticate(AUTHENTICATORS) != BiometricManager.BIOMETRIC_SUCCESS) {
      promise.resolve("")
      return
    }
    val pm = reactApplicationContext.packageManager
    val type =
      when {
        pm.hasSystemFeature(PackageManager.FEATURE_FINGERPRINT) -> "fingerprint"
        Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q &&
          pm.hasSystemFeature(PackageManager.FEATURE_FACE) -> "face"
        Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q &&
          pm.hasSystemFeature(PackageManager.FEATURE_IRIS) -> "iris"
        else -> "biometric"
      }
    promise.resolve(type)
  }

  override fun authenticate(
    title: String,
    subtitle: String,
    cancelLabel: String,
    promise: Promise,
  ) {
    val activity = reactApplicationContext.currentActivity as? FragmentActivity
    if (activity == null) {
      promise.resolve("unavailable")
      return
    }
    UiThreadUtil.runOnUiThread {
      var settled = false
      fun settle(outcome: String) {
        if (settled) return
        settled = true
        promise.resolve(outcome)
      }
      val callback =
        object : BiometricPrompt.AuthenticationCallback() {
          override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) {
            settle("success")
          }

          override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
            settle(
              when (errorCode) {
                BiometricPrompt.ERROR_NEGATIVE_BUTTON,
                BiometricPrompt.ERROR_USER_CANCELED,
                BiometricPrompt.ERROR_CANCELED -> "cancel"
                BiometricPrompt.ERROR_LOCKOUT,
                BiometricPrompt.ERROR_LOCKOUT_PERMANENT -> "lockout"
                BiometricPrompt.ERROR_NO_BIOMETRICS,
                BiometricPrompt.ERROR_HW_NOT_PRESENT,
                BiometricPrompt.ERROR_HW_UNAVAILABLE -> "unavailable"
                else -> "failed"
              }
            )
          }

          override fun onAuthenticationFailed() {}
        }
      val info =
        BiometricPrompt.PromptInfo.Builder()
          .setTitle(title.ifEmpty { "Ola" })
          .setSubtitle(subtitle.ifEmpty { null })
          .setNegativeButtonText(cancelLabel.ifEmpty { "Cancel" })
          .setAllowedAuthenticators(AUTHENTICATORS)
          .setConfirmationRequired(false)
          .build()
      try {
        BiometricPrompt(activity, ContextCompat.getMainExecutor(activity), callback)
          .authenticate(info)
      } catch (_: Exception) {
        settle("unavailable")
      }
    }
  }

  companion object {
    const val NAME = "OlaAppLock"
    private const val AUTHENTICATORS = BIOMETRIC_STRONG or BIOMETRIC_WEAK
  }
}
