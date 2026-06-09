package com.mg.ola.common.widget.date;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Rect;
import android.view.MotionEvent;

/* JADX INFO: loaded from: classes2.dex */
class b extends a {
    public b(Context context) {
        super(context);
    }

    @Override // com.mg.ola.common.widget.date.a
    public int a() {
        return 0;
    }

    @Override // com.mg.ola.common.widget.date.a
    public void a(int i) {
    }

    @Override // com.mg.ola.common.widget.date.a
    protected void a(int i, int i2) {
    }

    @Override // com.mg.ola.common.widget.date.a
    public void b(int i) {
    }

    @Override // com.mg.ola.common.widget.date.a, android.view.GestureDetector.OnGestureListener
    public boolean onDown(MotionEvent motionEvent) {
        return false;
    }

    @Override // android.view.View
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        canvas.drawText(this.h[0], this.g, this.e + this.d, this.c);
    }

    @Override // com.mg.ola.common.widget.date.a, android.view.GestureDetector.OnGestureListener
    public boolean onFling(MotionEvent motionEvent, MotionEvent motionEvent2, float f, float f2) {
        return false;
    }

    @Override // com.mg.ola.common.widget.date.a, android.view.View
    protected void onFocusChanged(boolean z, int i, Rect rect) {
        super.onFocusChanged(z, i, rect);
    }

    @Override // com.mg.ola.common.widget.date.a, android.view.GestureDetector.OnGestureListener
    public void onLongPress(MotionEvent motionEvent) {
    }

    @Override // com.mg.ola.common.widget.date.a, android.view.GestureDetector.OnGestureListener
    public boolean onScroll(MotionEvent motionEvent, MotionEvent motionEvent2, float f, float f2) {
        return false;
    }

    @Override // com.mg.ola.common.widget.date.a, android.view.GestureDetector.OnGestureListener
    public void onShowPress(MotionEvent motionEvent) {
    }

    @Override // com.mg.ola.common.widget.date.a, android.view.GestureDetector.OnGestureListener
    public boolean onSingleTapUp(MotionEvent motionEvent) {
        return false;
    }

    @Override // com.mg.ola.common.widget.date.a, android.view.View
    protected void onSizeChanged(int i, int i2, int i3, int i4) {
        super.onSizeChanged(i, i2, i3, i4);
        this.b.a(0.0f, this.f, false);
    }

    @Override // com.mg.ola.common.widget.date.a, android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        return super.onTouchEvent(motionEvent);
    }
}
