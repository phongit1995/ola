package com.mg.ola.common.widget.date;

import android.content.Context;
import android.graphics.Canvas;

/* JADX INFO: loaded from: classes2.dex */
class c extends a {
    public c(Context context) {
        super(context);
    }

    @Override // com.mg.ola.common.widget.date.a
    public int a() {
        int iE = this.b.e();
        int length = this.h.length;
        int i = iE % length;
        return i < 0 ? i + length : i;
    }

    @Override // com.mg.ola.common.widget.date.a
    public void a(int i) {
        super.a(i % this.h.length);
    }

    @Override // com.mg.ola.common.widget.date.a
    public void b(int i) {
        super.b(i % this.h.length);
    }

    @Override // android.view.View
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        int iE = this.b.e();
        int iF = this.b.f();
        int length = this.h.length;
        for (int i = -3; i <= 3; i++) {
            int i2 = (iE + i) % length;
            if (i2 < 0) {
                i2 += length;
            }
            canvas.drawText(this.h[i2], this.g, ((this.e + this.d) + (this.f * i)) - iF, this.c);
        }
    }

    @Override // com.mg.ola.common.widget.date.a, android.view.View
    protected void onSizeChanged(int i, int i2, int i3, int i4) {
        super.onSizeChanged(i, i2, i3, i4);
        this.b.a(this.f * (this.h.length - 1), this.f, true);
        b();
    }
}
