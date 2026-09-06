package com.ola.me.net.org.vn.richtext

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Handler
import android.os.Looper
import com.facebook.react.bridge.ReadableMap
import java.net.URL
import java.util.concurrent.CopyOnWriteArraySet
import java.util.concurrent.Executors
import java.util.regex.Pattern

object OlaRichTextConfig {
  class TokenImage(val uri: String, val aspect: Float, val heightFactor: Float) {
    @Volatile var bitmap: Bitmap? = null
  }

  @Volatile private var emoji: List<TokenImage> = emptyList()
  @Volatile private var smileyByCode: Map<String, TokenImage> = emptyMap()
  @Volatile var tokenPattern: Pattern? = null
    private set

  private val emojiTokenPattern = Pattern.compile("^\\[e:(\\d{1,2})\\]$")
  private val listeners = CopyOnWriteArraySet<() -> Unit>()
  private val executor = Executors.newSingleThreadExecutor()
  private val mainHandler = Handler(Looper.getMainLooper())

  fun addListener(listener: () -> Unit) {
    listeners.add(listener)
  }

  fun removeListener(listener: () -> Unit) {
    listeners.remove(listener)
  }

  fun configure(config: ReadableMap, context: Context) {
    val smileyFactor = if (config.hasKey("smileyFactor")) config.getDouble("smileyFactor").toFloat() else 1.25f
    val emojiFactor = if (config.hasKey("emojiFactor")) config.getDouble("emojiFactor").toFloat() else 1.15f

    val emojiList = mutableListOf<TokenImage>()
    config.getArray("emoji")?.let { array ->
      for (index in 0 until array.size()) {
        val entry = array.getMap(index) ?: continue
        emojiList.add(
          TokenImage(
            uri = entry.getString("uri") ?: "",
            aspect = if (entry.hasKey("aspect")) entry.getDouble("aspect").toFloat() else 1f,
            heightFactor = emojiFactor,
          )
        )
      }
    }

    val codeMap = mutableMapOf<String, TokenImage>()
    config.getArray("smileys")?.let { array ->
      for (index in 0 until array.size()) {
        val entry = array.getMap(index) ?: continue
        val image = TokenImage(
          uri = entry.getString("uri") ?: "",
          aspect = if (entry.hasKey("aspect")) entry.getDouble("aspect").toFloat() else 1f,
          heightFactor = smileyFactor,
        )
        val codes = entry.getArray("codes") ?: continue
        for (codeIndex in 0 until codes.size()) {
          val code = codes.getString(codeIndex) ?: continue
          if (code.isNotEmpty()) codeMap[code] = image
        }
      }
    }

    val sortedCodes = codeMap.keys.sortedByDescending { it.length }
    val pattern = buildString {
      append("\\[e:\\d{1,2}\\]")
      for (code in sortedCodes) {
        append('|')
        append(Pattern.quote(code))
      }
    }

    emoji = emojiList
    smileyByCode = codeMap
    tokenPattern = Pattern.compile(pattern)

    loadImages(context.applicationContext)
  }

  fun tokenImageForCode(code: String): TokenImage? {
    val emojiMatch = emojiTokenPattern.matcher(code)
    if (emojiMatch.matches()) {
      val index = emojiMatch.group(1)?.toIntOrNull() ?: return null
      return emoji.getOrNull(index - 1)
    }
    return smileyByCode[code]
  }

  private fun loadImages(context: Context) {
    val all = LinkedHashSet<TokenImage>()
    all.addAll(emoji)
    all.addAll(smileyByCode.values)
    executor.execute {
      for (entry in all) {
        if (entry.bitmap != null || entry.uri.isEmpty()) continue
        entry.bitmap = decodeUri(entry.uri, context)
      }
      mainHandler.post {
        for (listener in listeners) listener()
      }
    }
  }

  private fun decodeUri(uri: String, context: Context): Bitmap? = runCatching {
    when {
      uri.startsWith("http://") || uri.startsWith("https://") ->
        URL(uri).openStream().use { BitmapFactory.decodeStream(it) }
      uri.startsWith("file://") ->
        BitmapFactory.decodeFile(Uri.parse(uri).path)
      else -> {
        val resourceId = context.resources.getIdentifier(uri, "drawable", context.packageName)
        if (resourceId != 0) BitmapFactory.decodeResource(context.resources, resourceId) else null
      }
    }
  }.getOrNull()
}
