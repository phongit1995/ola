package com.mg.ola.common.widget;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.RectF;
import android.os.Handler;
import android.os.Message;
import android.os.SystemClock;
import android.support.v4.view.ViewCompat;
import android.view.MotionEvent;
import android.widget.Adapter;
import android.widget.ListView;
import android.widget.SectionIndexer;

/* JADX INFO: loaded from: classes2.dex */
public class c {
    private float a;
    private float b;
    private float c;
    private float d;
    private float e;
    private float f;
    private int h;
    private int i;
    private ListView l;
    private RectF o;
    private int g = 0;
    private int j = -1;
    private boolean k = false;
    private SectionIndexer m = null;
    private String[] n = null;
    private Handler p = new Handler() { // from class: com.mg.ola.common.widget.c.1
        @Override // android.os.Handler
        public void handleMessage(Message message) {
            c cVar;
            int i;
            super.handleMessage(message);
            switch (c.this.g) {
                case 1:
                    c.this.f = (float) (((double) c.this.f) + (((double) (1.0f - c.this.f)) * 0.2d));
                    if (c.this.f > 0.9d) {
                        c.this.f = 1.0f;
                        cVar = c.this;
                        i = 2;
                        cVar.a(i);
                    }
                    c.this.l.invalidate();
                    c.this.a(10L);
                    break;
                case 2:
                    c.this.a(3);
                    break;
                case 3:
                    c.this.f = (float) (((double) c.this.f) - (((double) c.this.f) * 0.2d));
                    if (c.this.f < 0.1d) {
                        c.this.f = 0.0f;
                        cVar = c.this;
                        i = 0;
                        cVar.a(i);
                    }
                    c.this.l.invalidate();
                    c.this.a(10L);
                    break;
            }
        }
    };

    public c(Context context, ListView listView) {
        this.l = null;
        this.d = context.getResources().getDisplayMetrics().density;
        this.e = context.getResources().getDisplayMetrics().scaledDensity;
        this.l = listView;
        a(this.l.getAdapter());
        this.a = this.d * 20.0f;
        this.b = this.d * 10.0f;
        this.c = this.d * 5.0f;
    }

    private int a(float f) {
        if (this.n == null || this.n.length == 0 || f < this.o.top + this.b) {
            return 0;
        }
        return f >= (this.o.top + this.o.height()) - this.b ? this.n.length - 1 : (int) (((f - this.o.top) - this.b) / ((this.o.height() - (this.b * 2.0f)) / this.n.length));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(int i) {
        long j;
        if (i < 0 || i > 3) {
            return;
        }
        this.g = i;
        switch (this.g) {
            case 0:
            case 2:
                this.p.removeMessages(0);
                return;
            case 1:
                this.f = 0.0f;
                j = 0;
                break;
            case 3:
                this.f = 1.0f;
                j = 3000;
                break;
            default:
                return;
        }
        a(j);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(long j) {
        this.p.removeMessages(0);
        this.p.sendEmptyMessageAtTime(0, SystemClock.uptimeMillis() + j);
    }

    private boolean a(float f, float f2) {
        return f >= this.o.left && f2 >= this.o.top && f2 <= this.o.top + this.o.height();
    }

    public void a() {
        if (this.g == 0) {
            a(1);
        } else if (this.g == 3) {
            a(3);
        }
    }

    public void a(int i, int i2, int i3, int i4) {
        this.h = i;
        this.i = i2;
        float f = i;
        this.o = new RectF((f - this.b) - this.a, this.b, f - this.b, i2 - this.b);
    }

    public void a(Canvas canvas) {
        if (this.g == 0) {
            return;
        }
        Paint paint = new Paint();
        paint.setColor(ViewCompat.MEASURED_STATE_MASK);
        paint.setAlpha((int) (this.f * 64.0f));
        paint.setAntiAlias(true);
        canvas.drawRoundRect(this.o, this.d * 5.0f, this.d * 5.0f, paint);
        if (this.n == null || this.n.length <= 0) {
            return;
        }
        if (this.j >= 0) {
            Paint paint2 = new Paint();
            paint2.setColor(ViewCompat.MEASURED_STATE_MASK);
            paint2.setAlpha(96);
            paint2.setAntiAlias(true);
            paint2.setShadowLayer(3.0f, 0.0f, 0.0f, Color.argb(64, 0, 0, 0));
            Paint paint3 = new Paint();
            paint3.setColor(-1);
            paint3.setAntiAlias(true);
            paint3.setTextSize(this.e * 50.0f);
            float fMeasureText = paint3.measureText(this.n[this.j]);
            float fDescent = ((this.c * 2.0f) + paint3.descent()) - paint3.ascent();
            RectF rectF = new RectF((this.h - fDescent) / 2.0f, (this.i - fDescent) / 2.0f, ((this.h - fDescent) / 2.0f) + fDescent, ((this.i - fDescent) / 2.0f) + fDescent);
            canvas.drawRoundRect(rectF, this.d * 5.0f, this.d * 5.0f, paint2);
            canvas.drawText(this.n[this.j], (rectF.left + ((fDescent - fMeasureText) / 2.0f)) - 1.0f, ((rectF.top + this.c) - paint3.ascent()) + 1.0f, paint3);
        }
        Paint paint4 = new Paint();
        paint4.setColor(-1);
        paint4.setAlpha((int) (this.f * 255.0f));
        paint4.setAntiAlias(true);
        paint4.setTextSize(this.e * 12.0f);
        float fHeight = (this.o.height() - (this.b * 2.0f)) / this.n.length;
        float fDescent2 = (fHeight - (paint4.descent() - paint4.ascent())) / 2.0f;
        for (int i = 0; i < this.n.length; i++) {
            canvas.drawText(this.n[i], this.o.left + ((this.a - paint4.measureText(this.n[i])) / 2.0f), (((this.o.top + this.b) + (i * fHeight)) + fDescent2) - paint4.ascent(), paint4);
        }
    }

    public void a(Adapter adapter) {
        if (adapter instanceof SectionIndexer) {
            this.m = (SectionIndexer) adapter;
            this.n = (String[]) this.m.getSections();
        }
    }

    public boolean a(MotionEvent motionEvent) {
        switch (motionEvent.getAction()) {
            case 0:
                if (this.g != 0 && a(motionEvent.getX(), motionEvent.getY())) {
                    a(2);
                    this.k = true;
                    this.j = a(motionEvent.getY());
                    this.l.setSelection(this.m.getPositionForSection(this.j));
                    return true;
                }
                return false;
            case 1:
                if (this.k) {
                    this.k = false;
                    this.j = -1;
                }
                if (this.g == 2) {
                    a(3);
                    return false;
                }
                return false;
            case 2:
                if (this.k) {
                    if (a(motionEvent.getX(), motionEvent.getY())) {
                        this.j = a(motionEvent.getY());
                        this.l.setSelection(this.m.getPositionForSection(this.j));
                    }
                    return true;
                }
                return false;
            default:
                return false;
        }
    }

    public void b() {
        if (this.g == 2) {
            a(3);
        }
    }
}
