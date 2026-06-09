package chat.ola.vn.balloon.a;

import android.os.Handler;

/* JADX INFO: loaded from: classes.dex */
public class b extends a {
    private int g;
    private int h;
    private int i;
    private int j;
    private long k;
    private Runnable l;

    public b(chat.ola.vn.balloon.a aVar, Handler handler) {
        super(aVar, handler);
        this.k = 0L;
        this.l = new Runnable() { // from class: chat.ola.vn.balloon.a.b.1
            /* JADX WARN: Code restructure failed: missing block: B:14:0x0090, code lost:
            
                if (r8.a.a(r6, r4) != false) goto L8;
             */
            @Override // java.lang.Runnable
            /*
                Code decompiled incorrectly, please refer to instructions dump.
                To view partially-correct add '--show-bad-code' argument
            */
            public void run() {
                /*
                    r8 = this;
                    chat.ola.vn.balloon.a.b r0 = chat.ola.vn.balloon.a.b.this
                    short r0 = r0.a
                    r1 = 2
                    switch(r0) {
                        case 0: goto La1;
                        case 1: goto L93;
                        case 2: goto L9;
                        case 3: goto La1;
                        default: goto L8;
                    }
                L8:
                    return
                L9:
                    long r2 = java.lang.System.currentTimeMillis()
                    chat.ola.vn.balloon.a.b r0 = chat.ola.vn.balloon.a.b.this
                    long r4 = chat.ola.vn.balloon.a.b.a(r0)
                    long r6 = r2 - r4
                    chat.ola.vn.balloon.a.b r0 = chat.ola.vn.balloon.a.b.this
                    long r2 = r0.e
                    int r0 = (r6 > r2 ? 1 : (r6 == r2 ? 0 : -1))
                    r2 = 3
                    if (r0 < 0) goto L35
                    chat.ola.vn.balloon.a.b r0 = chat.ola.vn.balloon.a.b.this
                    chat.ola.vn.balloon.a.b r1 = chat.ola.vn.balloon.a.b.this
                    int r1 = chat.ola.vn.balloon.a.b.b(r1)
                    chat.ola.vn.balloon.a.b r3 = chat.ola.vn.balloon.a.b.this
                    int r3 = chat.ola.vn.balloon.a.b.c(r3)
                    chat.ola.vn.balloon.a.b.a(r0, r1, r3)
                L2f:
                    chat.ola.vn.balloon.a.b r0 = chat.ola.vn.balloon.a.b.this
                    r0.a(r2)
                    return
                L35:
                    float r0 = (float) r6
                    chat.ola.vn.balloon.a.b r3 = chat.ola.vn.balloon.a.b.this
                    long r3 = r3.e
                    float r3 = (float) r3
                    float r0 = r0 / r3
                    r3 = 1065353216(0x3f800000, float:1.0)
                    float r0 = java.lang.Math.min(r0, r3)
                    r4 = 0
                    float r0 = java.lang.Math.max(r0, r4)
                    chat.ola.vn.balloon.a.b r4 = chat.ola.vn.balloon.a.b.this
                    int r4 = chat.ola.vn.balloon.a.b.b(r4)
                    chat.ola.vn.balloon.a.b r5 = chat.ola.vn.balloon.a.b.this
                    int r5 = chat.ola.vn.balloon.a.b.d(r5)
                    int r4 = r4 - r5
                    chat.ola.vn.balloon.a.b r5 = chat.ola.vn.balloon.a.b.this
                    int r5 = chat.ola.vn.balloon.a.b.c(r5)
                    chat.ola.vn.balloon.a.b r6 = chat.ola.vn.balloon.a.b.this
                    int r6 = chat.ola.vn.balloon.a.b.e(r6)
                    int r5 = r5 - r6
                    chat.ola.vn.balloon.a.b r6 = chat.ola.vn.balloon.a.b.this
                    android.view.animation.Interpolator r6 = r6.d
                    float r6 = r6.getInterpolation(r0)
                    float r4 = (float) r4
                    float r4 = r4 * r6
                    int r4 = java.lang.Math.round(r4)
                    float r5 = (float) r5
                    float r5 = r5 * r6
                    int r5 = java.lang.Math.round(r5)
                    chat.ola.vn.balloon.a.b r6 = chat.ola.vn.balloon.a.b.this
                    int r6 = chat.ola.vn.balloon.a.b.d(r6)
                    int r6 = r6 + r4
                    chat.ola.vn.balloon.a.b r4 = chat.ola.vn.balloon.a.b.this
                    int r4 = chat.ola.vn.balloon.a.b.e(r4)
                    int r4 = r4 + r5
                    int r0 = (r0 > r3 ? 1 : (r0 == r3 ? 0 : -1))
                    if (r0 != 0) goto L8a
                    goto L2f
                L8a:
                    chat.ola.vn.balloon.a.b r0 = chat.ola.vn.balloon.a.b.this
                    boolean r0 = chat.ola.vn.balloon.a.b.a(r0, r6, r4)
                    if (r0 == 0) goto L9c
                    goto L2f
                L93:
                    chat.ola.vn.balloon.a.b r0 = chat.ola.vn.balloon.a.b.this
                    long r2 = java.lang.System.currentTimeMillis()
                    chat.ola.vn.balloon.a.b.a(r0, r2)
                L9c:
                    chat.ola.vn.balloon.a.b r0 = chat.ola.vn.balloon.a.b.this
                    r0.a(r1)
                La1:
                    return
                */
                throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.balloon.a.b.AnonymousClass1.run():void");
            }
        };
        b();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean a(int i, int i2) {
        if (!this.b.c() || this.f == null) {
            return true;
        }
        if (i < 0) {
            i = 0;
        } else if (i > this.b.getWindowWidth() - this.b.getBalloonWidth()) {
            i = this.b.getWindowWidth() - this.b.getBalloonWidth();
        }
        if (i2 < 0) {
            i2 = 0;
        } else if (i2 > this.b.getWindowHeight() - this.b.getBalloonHeight()) {
            i2 = this.b.getWindowHeight() - this.b.getBalloonHeight();
        }
        this.f.x = i;
        this.f.y = i2;
        this.b.a();
        return this.b.d();
    }

    private void b() {
    }

    public void a() {
        if (this.c == null || this.f == null) {
            return;
        }
        this.a = (short) 1;
        this.c.post(this.l);
    }

    public void a(int i, int i2, int i3, int i4) {
        this.g = i;
        this.i = i2;
        this.h = i3;
        this.j = i4;
    }

    @Override // chat.ola.vn.balloon.a.a
    protected void a(short s) {
        super.a(s);
        if (this.c != null) {
            this.c.post(this.l);
        } else {
            this.a = (short) 3;
        }
    }
}
