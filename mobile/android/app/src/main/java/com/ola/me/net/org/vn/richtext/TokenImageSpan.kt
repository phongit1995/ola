package com.ola.me.net.org.vn.richtext

import android.graphics.Canvas
import android.graphics.Paint
import android.graphics.RectF
import android.text.style.ReplacementSpan
import kotlin.math.ceil
import kotlin.math.min
import kotlin.math.roundToInt

class TokenImageSpan(
  val code: String,
  private val imageWidth: Int,
  private val imageHeight: Int,
) : ReplacementSpan() {

  override fun getSize(
    paint: Paint,
    text: CharSequence?,
    start: Int,
    end: Int,
    fm: Paint.FontMetricsInt?,
  ): Int {
    if (fm != null) {
      val metrics = paint.fontMetricsInt
      fm.descent = metrics.descent
      fm.bottom = metrics.bottom
      fm.ascent = min(metrics.ascent, metrics.descent - imageHeight)
      fm.top = min(metrics.top, fm.ascent)
    }
    return imageWidth
  }

  override fun draw(
    canvas: Canvas,
    text: CharSequence?,
    start: Int,
    end: Int,
    x: Float,
    top: Int,
    y: Int,
    bottom: Int,
    paint: Paint,
  ) {
    val bitmap = OlaRichTextConfig.tokenImageForCode(code)?.bitmap ?: return
    val imageBottom = y + paint.fontMetricsInt.descent
    val destination = RectF(
      x,
      (imageBottom - imageHeight).toFloat(),
      x + imageWidth,
      imageBottom.toFloat(),
    )
    canvas.drawBitmap(bitmap, null, destination, paint)
  }

  companion object {
    fun create(code: String, fontSizePx: Float): TokenImageSpan? {
      val tokenImage = OlaRichTextConfig.tokenImageForCode(code) ?: return null
      val height = ceil(fontSizePx * tokenImage.heightFactor).roundToInt()
      val width = (height * tokenImage.aspect).roundToInt()
      return TokenImageSpan(code, width, height)
    }
  }
}
