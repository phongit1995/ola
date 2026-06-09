package com.mg.ola.common.widget;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.RectF;
import android.util.AttributeSet;
import android.util.TypedValue;
import android.view.View;

/* JADX INFO: loaded from: classes2.dex */
public class ProgressCircleView extends View {
    private static int a = 50;
    private int b;
    private int c;
    private int d;
    private int e;
    private long f;
    private long g;
    private Paint h;
    private RectF i;

    public ProgressCircleView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.b = 5;
        this.d = -1;
        this.e = Color.parseColor("#50000000");
        this.f = 0L;
        this.g = 100L;
        this.d = attributeSet.getAttributeResourceValue("http://schemas.android.com/apk/res/android", "color", -1);
        a();
    }

    private void a() {
        this.c = (int) Math.ceil(TypedValue.applyDimension(1, a, getResources().getDisplayMetrics()));
        this.h = new Paint();
        this.h.setStyle(Paint.Style.STROKE);
        this.h.setAntiAlias(true);
        this.h.setStrokeWidth(this.b);
        float fCeil = (int) Math.ceil(((double) this.b) / 2.0d);
        this.i = new RectF(fCeil, fCeil, this.c + this.b, this.c + this.b);
    }

    public void a(int i, int i2) {
        this.d = i;
        this.e = i2;
    }

    @Override // android.view.View
    public void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        int i = (int) ((this.f * 100) / this.g);
        float f = (i * 360) / 100.0f;
        if (i > 0) {
            this.h.setColor(this.d);
            canvas.drawArc(this.i, 270.0f, f, false, this.h);
        }
        if (i < 100) {
            this.h.setColor(this.e);
            canvas.drawArc(this.i, f + 270.0f, 360.0f - f, false, this.h);
        }
    }

    @Override // android.view.View
    protected void onMeasure(int i, int i2) {
        setMeasuredDimension(this.c + (this.b * 2), this.c + (this.b * 2));
    }

    public void setProgress(long j) {
        if (j == this.f) {
            return;
        }
        this.f = j;
        invalidate();
    }

    public void setProgressColor(int i) {
    }

    public void setRadius(int i) {
        a = i;
        this.c = (int) Math.ceil(TypedValue.applyDimension(1, a, getResources().getDisplayMetrics()));
        float fCeil = (int) Math.ceil(((double) this.b) / 2.0d);
        this.i = new RectF(fCeil, fCeil, this.c, this.c);
        requestLayout();
    }

    public void setStrokeWidth(float f) {
        this.b = (int) f;
        this.h.setStrokeWidth(f);
        float fCeil = (int) Math.ceil(((double) this.b) / 2.0d);
        this.i = new RectF(fCeil, fCeil, this.c, this.c);
    }

    public void setTotal(long j) {
        if (j != 0) {
            this.g = j;
        }
    }
}
