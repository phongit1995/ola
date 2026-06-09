package com.mg.ola.common.widget.date;

import android.content.Context;
import android.graphics.Paint;
import android.graphics.Rect;
import android.os.Handler;
import android.view.GestureDetector;
import android.view.MotionEvent;
import android.view.View;

/* JADX INFO: loaded from: classes2.dex */
abstract class a extends View implements GestureDetector.OnGestureListener {
    protected Handler a;
    protected g b;
    protected Paint c;
    protected int d;
    protected int e;
    protected int f;
    protected int g;
    protected String[] h;
    protected Runnable i;
    private GestureDetector j;
    private int k;
    private int l;

    public a(Context context) {
        super(context);
        this.a = new Handler();
        this.b = new g();
        this.c = new Paint();
        this.h = new String[0];
        this.k = -1;
        this.l = 0;
        this.i = new Runnable() { // from class: com.mg.ola.common.widget.date.a.1
            @Override // java.lang.Runnable
            public void run() {
                boolean zG = a.this.b.g();
                a.this.invalidate();
                if (zG) {
                    a.this.a.postDelayed(a.this.i, 33L);
                }
            }
        };
        setClickable(true);
        setFocusable(true);
        this.j = new GestureDetector(context, this);
        this.l = 0;
        this.c.setAntiAlias(true);
        this.c.setColor(-15790321);
        this.c.setTextAlign(Paint.Align.RIGHT);
        this.c.setAlpha(255);
        this.c.setShadowLayer(15.0f, 0.0f, 0.0f, -1);
    }

    private int b(int i, int i2) {
        int i3 = 0;
        for (String str : this.h) {
            int iA = d.a(str);
            if (i3 < iA) {
                i3 = iA;
            }
        }
        return (int) Math.min(i * 0.8f, (i2 * 0.8f) / ((int) (i3 * 0.5f)));
    }

    public abstract int a();

    public void a(int i) {
        this.a.removeCallbacks(this.i);
        if (!isShown()) {
            a(i, 1);
        } else {
            this.b.b(i);
            invalidate();
        }
    }

    protected void a(int i, int i2) {
        this.k = i;
        this.l = i2;
    }

    public void a(String[] strArr) {
        this.h = strArr;
    }

    protected void b() {
        switch (this.l) {
            case 1:
                this.b.b(this.k);
                break;
            case 2:
                this.b.a(this.k);
                this.a.post(this.i);
                break;
            default:
                return;
        }
        this.l = 0;
    }

    public void b(int i) {
        this.a.removeCallbacks(this.i);
        if (!isShown()) {
            a(i, 2);
        } else {
            this.b.a(i);
            this.a.post(this.i);
        }
    }

    @Override // android.view.GestureDetector.OnGestureListener
    public boolean onDown(MotionEvent motionEvent) {
        this.a.removeCallbacks(this.i);
        this.b.b();
        return false;
    }

    @Override // android.view.GestureDetector.OnGestureListener
    public boolean onFling(MotionEvent motionEvent, MotionEvent motionEvent2, float f, float f2) {
        this.b.b(f2);
        return false;
    }

    @Override // android.view.View
    protected void onFocusChanged(boolean z, int i, Rect rect) {
        if (!z) {
            this.a.removeCallbacks(this.i);
        }
        super.onFocusChanged(z, i, rect);
    }

    @Override // android.view.GestureDetector.OnGestureListener
    public void onLongPress(MotionEvent motionEvent) {
    }

    @Override // android.view.View
    protected void onMeasure(int i, int i2) {
        super.onMeasure(i, i2);
    }

    @Override // android.view.GestureDetector.OnGestureListener
    public boolean onScroll(MotionEvent motionEvent, MotionEvent motionEvent2, float f, float f2) {
        this.b.a(f2);
        invalidate();
        return false;
    }

    @Override // android.view.GestureDetector.OnGestureListener
    public void onShowPress(MotionEvent motionEvent) {
    }

    @Override // android.view.GestureDetector.OnGestureListener
    public boolean onSingleTapUp(MotionEvent motionEvent) {
        return false;
    }

    @Override // android.view.View
    protected void onSizeChanged(int i, int i2, int i3, int i4) {
        super.onSizeChanged(i, i2, i3, i4);
        this.f = i2 / 5;
        this.g = (int) (i * 0.925f);
        this.c.setTextSize(b(this.f, i));
        this.e = (int) ((-this.c.ascent()) * 0.35f);
        this.d = (int) (i2 * 0.5f);
    }

    @Override // android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        if (this.j.onTouchEvent(motionEvent)) {
            return true;
        }
        if (motionEvent.getAction() == 1) {
            this.b.c();
            if (this.b.d()) {
                this.a.post(this.i);
            }
        }
        return super.onTouchEvent(motionEvent);
    }
}
