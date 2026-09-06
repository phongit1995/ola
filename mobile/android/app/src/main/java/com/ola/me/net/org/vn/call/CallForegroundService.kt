package com.ola.me.net.org.vn.call

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Bundle
import android.os.Build
import android.os.IBinder
import android.os.ResultReceiver
import androidx.core.app.NotificationCompat
import com.ola.me.net.org.vn.MainActivity
import com.ola.me.net.org.vn.R

class CallForegroundService : Service() {

  override fun onBind(intent: Intent?): IBinder? = null

  override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
    val withVideo = intent?.getBooleanExtra(EXTRA_VIDEO, false) == true
    val receiver = resultReceiver(intent)

    try {
      createChannel()
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
        startForeground(NOTIFICATION_ID, buildNotification(), serviceTypes(withVideo))
      } else {
        startForeground(NOTIFICATION_ID, buildNotification())
      }
    } catch (error: Exception) {
      val data = Bundle().apply {
        putString(EXTRA_ERROR, error.message ?: error.javaClass.simpleName)
      }
      runCatching { receiver?.send(RESULT_FAILED, data) }
      stopSelf(startId)
      return START_NOT_STICKY
    }

    runCatching { receiver?.send(RESULT_STARTED, Bundle.EMPTY) }
    return START_NOT_STICKY
  }

  @Suppress("DEPRECATION")
  private fun resultReceiver(intent: Intent?): ResultReceiver? =
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
      intent?.getParcelableExtra(EXTRA_RECEIVER, ResultReceiver::class.java)
    } else {
      intent?.getParcelableExtra(EXTRA_RECEIVER)
    }

  private fun serviceTypes(withVideo: Boolean): Int {
    var types = ServiceInfo.FOREGROUND_SERVICE_TYPE_MICROPHONE
    if (withVideo) types = types or ServiceInfo.FOREGROUND_SERVICE_TYPE_CAMERA
    return types
  }

  private fun createChannel() {
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
    val manager = getSystemService(NotificationManager::class.java) ?: return
    if (manager.getNotificationChannel(CHANNEL_ID) != null) return
    val channel = NotificationChannel(
      CHANNEL_ID,
      getString(R.string.call_channel_name),
      NotificationManager.IMPORTANCE_LOW,
    )
    channel.setShowBadge(false)
    manager.createNotificationChannel(channel)
  }

  private fun buildNotification(): Notification {
    val intent = Intent(this, MainActivity::class.java).apply {
      flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
    }
    val pending = PendingIntent.getActivity(
      this,
      0,
      intent,
      PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
    )
    return NotificationCompat.Builder(this, CHANNEL_ID)
      .setContentTitle(getString(R.string.app_name))
      .setContentText(getString(R.string.call_notification_text))
      .setSmallIcon(R.drawable.ic_call_notification)
      .setContentIntent(pending)
      .setOngoing(true)
      .setCategory(NotificationCompat.CATEGORY_CALL)
      .setPriority(NotificationCompat.PRIORITY_LOW)
      .build()
  }

  companion object {
    private const val CHANNEL_ID = "ola_call"
    private const val NOTIFICATION_ID = 4711
    private const val EXTRA_VIDEO = "video"
    private const val EXTRA_RECEIVER = "receiver"
    const val EXTRA_ERROR = "error"
    const val RESULT_STARTED = 1
    const val RESULT_FAILED = 2

    fun start(context: Context, withVideo: Boolean, receiver: ResultReceiver) {
      val intent = Intent(context, CallForegroundService::class.java)
        .putExtra(EXTRA_VIDEO, withVideo)
        .putExtra(EXTRA_RECEIVER, receiver)
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        context.startForegroundService(intent)
      } else {
        context.startService(intent)
      }
    }

    fun stop(context: Context) {
      context.stopService(Intent(context, CallForegroundService::class.java))
    }
  }
}
