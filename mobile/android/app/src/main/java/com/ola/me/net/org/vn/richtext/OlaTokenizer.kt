package com.ola.me.net.org.vn.richtext

import android.graphics.Typeface
import android.text.Spannable
import android.text.SpannableStringBuilder
import android.text.TextPaint
import android.text.style.ForegroundColorSpan
import android.text.style.StyleSpan
import android.text.style.UnderlineSpan
import java.util.regex.Pattern

enum class LinkKind { MENTION, URL }

class LinkRange(val start: Int, val end: Int, val kind: LinkKind, val payload: String)

object OlaTokenizer {
  private const val MENTION_SOURCE = "@[A-Za-z0-9][A-Za-z0-9._-]*[A-Za-z0-9]"
  private const val HASHTAG_SOURCE = "#[A-Za-z0-9_.]+"
  private const val URL_SOURCE = "https?://[^\\s]+|www\\.[^\\s]+"

  private val postTokenPattern =
    Pattern.compile("($MENTION_SOURCE|$HASHTAG_SOURCE|$URL_SOURCE)")
  private val mentionPattern = Pattern.compile("^(?:$MENTION_SOURCE)$")
  private val hashtagPattern = Pattern.compile("^(?:$HASHTAG_SOURCE)$")
  private val urlPattern = Pattern.compile("^(?:$URL_SOURCE)$")
  private val trailingPunctuationPattern = Pattern.compile("[.,;:!?)\\]}'\"]+$")

  fun textPaint(fontSizePx: Float): TextPaint = TextPaint(TextPaint.ANTI_ALIAS_FLAG).apply {
    textSize = fontSizePx
    typeface = Typeface.DEFAULT
  }

  private fun appendTokenized(builder: SpannableStringBuilder, text: String, fontSizePx: Float) {
    val pattern = OlaRichTextConfig.tokenPattern
    if (pattern == null || text.isEmpty()) {
      builder.append(text)
      return
    }
    val matcher = pattern.matcher(text)
    var lastIndex = 0
    while (matcher.find()) {
      val code = matcher.group()
      val span = TokenImageSpan.create(code, fontSizePx)
      if (span == null) continue
      if (matcher.start() > lastIndex) builder.append(text.substring(lastIndex, matcher.start()))
      val spanStart = builder.length
      builder.append(code)
      builder.setSpan(span, spanStart, builder.length, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE)
      lastIndex = matcher.end()
    }
    if (lastIndex < text.length) builder.append(text.substring(lastIndex))
  }

  fun buildComposerFragment(text: String, fontSizePx: Float): SpannableStringBuilder {
    val builder = SpannableStringBuilder()
    appendTokenized(builder, text, fontSizePx)
    return builder
  }

  fun buildRich(
    content: String,
    fontSizePx: Float,
    accentColor: Int,
    links: MutableList<LinkRange>?,
  ): SpannableStringBuilder {
    val builder = SpannableStringBuilder()
    val matcher = postTokenPattern.matcher(content)
    val parts = mutableListOf<String>()
    var lastIndex = 0
    while (matcher.find()) {
      parts.add(content.substring(lastIndex, matcher.start()))
      parts.add(matcher.group())
      lastIndex = matcher.end()
    }
    parts.add(content.substring(lastIndex))

    for (part in parts) {
      if (part.isEmpty()) continue
      if (mentionPattern.matcher(part).matches()) {
        val start = builder.length
        builder.append(part)
        builder.setSpan(ForegroundColorSpan(accentColor), start, builder.length, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE)
        builder.setSpan(StyleSpan(Typeface.BOLD), start, builder.length, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE)
        links?.add(LinkRange(start, builder.length, LinkKind.MENTION, part.substring(1)))
        continue
      }
      if (hashtagPattern.matcher(part).matches()) {
        val start = builder.length
        builder.append(part)
        builder.setSpan(ForegroundColorSpan(accentColor), start, builder.length, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE)
        continue
      }
      if (urlPattern.matcher(part).matches()) {
        val trailingMatcher = trailingPunctuationPattern.matcher(part)
        val trailing = if (trailingMatcher.find()) trailingMatcher.group() else ""
        val url = part.substring(0, part.length - trailing.length)
        val href = if (url.startsWith("www.")) "https://$url" else url
        val start = builder.length
        builder.append(url)
        builder.setSpan(ForegroundColorSpan(accentColor), start, builder.length, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE)
        builder.setSpan(UnderlineSpan(), start, builder.length, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE)
        links?.add(LinkRange(start, builder.length, LinkKind.URL, href))
        if (trailing.isNotEmpty()) builder.append(trailing)
        continue
      }
      appendTokenized(builder, part, fontSizePx)
    }
    return builder
  }
}
