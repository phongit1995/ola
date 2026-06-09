package com.mg.ola.common.widget;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.view.animation.AnimationUtils;
import android.widget.ImageView;

/* JADX INFO: loaded from: classes2.dex */
public class RotateImageView extends ImageView {
    private int a;
    private int b;
    private int c;
    private boolean d;
    private long e;
    private long f;

    public RotateImageView(Context context) {
        super(context);
        this.a = 0;
        this.b = 0;
        this.c = 0;
        this.d = false;
        this.e = 0L;
        this.f = 0L;
    }

    public RotateImageView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.a = 0;
        this.b = 0;
        this.c = 0;
        this.d = false;
        this.e = 0L;
        this.f = 0L;
    }

    public RotateImageView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.a = 0;
        this.b = 0;
        this.c = 0;
        this.d = false;
        this.e = 0L;
        this.f = 0L;
    }

    @Override // android.widget.ImageView, android.view.View
    protected void onDraw(Canvas canvas) {
        Drawable drawable = getDrawable();
        if (drawable == null) {
            return;
        }
        Rect bounds = drawable.getBounds();
        int i = bounds.right - bounds.left;
        int i2 = bounds.bottom - bounds.top;
        if (i == 0 || i2 == 0) {
            return;
        }
        if (this.a != this.c) {
            long jCurrentAnimationTimeMillis = AnimationUtils.currentAnimationTimeMillis();
            if (jCurrentAnimationTimeMillis < this.f) {
                int i3 = (int) (jCurrentAnimationTimeMillis - this.e);
                int i4 = this.b;
                if (!this.d) {
                    i3 = -i3;
                }
                int i5 = i4 + ((i3 * 180) / 1000);
                this.a = i5 >= 0 ? i5 % 360 : (i5 % 360) + 360;
                invalidate();
            } else {
                this.a = this.c;
            }
        }
        int paddingLeft = getPaddingLeft();
        int paddingTop = getPaddingTop();
        int paddingRight = getPaddingRight();
        int paddingBottom = getPaddingBottom();
        int width = (getWidth() - paddingLeft) - paddingRight;
        int height = (getHeight() - paddingTop) - paddingBottom;
        int saveCount = canvas.getSaveCount();
        canvas.translate(paddingLeft + (width / 2), paddingTop + (height / 2));
        canvas.rotate(-this.a);
        canvas.translate((-i) / 2, (-i2) / 2);
        drawable.draw(canvas);
        canvas.restoreToCount(saveCount);
    }

    public void setDegree(int i) {
        int i2 = i >= 0 ? i % 360 : (i % 360) + 360;
        if (i2 == this.c) {
            return;
        }
        this.c = i2;
        this.b = this.a;
        this.e = AnimationUtils.currentAnimationTimeMillis();
        int i3 = this.c - this.a;
        if (i3 < 0) {
            i3 += 360;
        }
        if (i3 > 180) {
            i3 -= 360;
        }
        this.d = i3 >= 0;
        this.f = this.e + ((long) ((Math.abs(i3) * 1000) / 180));
        invalidate();
    }
}
