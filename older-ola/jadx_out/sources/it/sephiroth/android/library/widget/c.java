package it.sephiroth.android.library.widget;

import android.content.Context;
import android.util.Log;
import android.view.ViewConfiguration;
import android.view.animation.AnimationUtils;
import android.view.animation.Interpolator;

/* JADX INFO: loaded from: classes2.dex */
public class c {
    private static float f = 8.0f;
    private static float g = 1.0f / a(1.0f);
    private int a;
    private final a b;
    private final a c;
    private Interpolator d;
    private final boolean e;

    static class a {
        private static float p = (float) (Math.log(0.78d) / Math.log(0.9d));
        private static final float[] q = new float[101];
        private static final float[] r = new float[101];
        private int a;
        private int b;
        private int c;
        private int d;
        private float e;
        private float f;
        private long g;
        private int h;
        private int i;
        private int j;
        private int l;
        private float o;
        private float m = ViewConfiguration.getScrollFriction();
        private int n = 0;
        private boolean k = true;

        static {
            float f;
            float f2;
            float f3;
            float f4;
            float f5;
            float f6;
            float f7;
            float f8;
            float f9;
            float f10;
            float f11 = 0.0f;
            float f12 = 0.0f;
            for (int i = 0; i < 100; i++) {
                float f13 = i / 100.0f;
                float f14 = 1.0f;
                while (true) {
                    f = 2.0f;
                    f2 = ((f14 - f11) / 2.0f) + f11;
                    f3 = 3.0f;
                    f4 = 1.0f - f2;
                    f5 = f2 * 3.0f * f4;
                    f6 = f2 * f2 * f2;
                    float f15 = (((f4 * 0.175f) + (f2 * 0.35000002f)) * f5) + f6;
                    if (Math.abs(f15 - f13) < 1.0E-5d) {
                        break;
                    } else if (f15 > f13) {
                        f14 = f2;
                    } else {
                        f11 = f2;
                    }
                }
                q[i] = (f5 * ((f4 * 0.5f) + f2)) + f6;
                float f16 = 1.0f;
                while (true) {
                    f7 = ((f16 - f12) / f) + f12;
                    f8 = 1.0f - f7;
                    f9 = f7 * f3 * f8;
                    f10 = f7 * f7 * f7;
                    float f17 = (((f8 * 0.5f) + f7) * f9) + f10;
                    if (Math.abs(f17 - f13) < 1.0E-5d) {
                        break;
                    }
                    if (f17 > f13) {
                        f16 = f7;
                    } else {
                        f12 = f7;
                    }
                    f = 2.0f;
                    f3 = 3.0f;
                }
                r[i] = (f9 * ((f8 * 0.175f) + (f7 * 0.35000002f))) + f10;
            }
            float[] fArr = q;
            r[100] = 1.0f;
            fArr[100] = 1.0f;
        }

        a(Context context) {
            this.o = context.getResources().getDisplayMetrics().density * 160.0f * 386.0878f * 0.84f;
        }

        private static float a(int i) {
            return i > 0 ? -2000.0f : 2000.0f;
        }

        private void a(int i, int i2, int i3, int i4) {
            if (i > i2 && i < i3) {
                Log.e("OverScroller", "startAfterEdge called from a valid position");
                this.k = true;
                return;
            }
            boolean z = i > i3;
            int i5 = z ? i3 : i2;
            if ((i - i5) * i4 >= 0) {
                g(i, i5, i4);
            } else if (c(i4) > Math.abs(r9)) {
                a(i, i4, z ? i2 : i, z ? i : i3, this.l);
            } else {
                e(i, i5, i4);
            }
        }

        private double b(int i) {
            return Math.log((Math.abs(i) * 0.35f) / (this.m * this.o));
        }

        private double c(int i) {
            return ((double) (this.m * this.o)) * Math.exp((((double) p) / (((double) p) - 1.0d)) * b(i));
        }

        private int d(int i) {
            return (int) (Math.exp(b(i) / (((double) p) - 1.0d)) * 1000.0d);
        }

        private void d() {
            float fAbs = (this.d * this.d) / (Math.abs(this.f) * 2.0f);
            float fSignum = Math.signum(this.d);
            if (fAbs > this.l) {
                this.f = (((-fSignum) * this.d) * this.d) / (this.l * 2.0f);
                fAbs = this.l;
            }
            this.l = (int) fAbs;
            this.n = 2;
            int i = this.a;
            if (this.d <= 0) {
                fAbs = -fAbs;
            }
            this.c = i + ((int) fAbs);
            this.h = -((int) ((this.d * 1000.0f) / this.f));
        }

        private void d(int i, int i2, int i3) {
            float fAbs = Math.abs((i3 - i) / (i2 - i));
            int i4 = (int) (fAbs * 100.0f);
            if (i4 < 100) {
                float f = i4 / 100.0f;
                int i5 = i4 + 1;
                float f2 = r[i4];
                this.h = (int) (this.h * (f2 + (((fAbs - f) / ((i5 / 100.0f) - f)) * (r[i5] - f2))));
            }
        }

        private void e(int i, int i2, int i3) {
            this.k = false;
            this.n = 1;
            this.a = i;
            this.c = i2;
            int i4 = i - i2;
            this.f = a(i4);
            this.d = -i4;
            this.l = Math.abs(i4);
            this.h = (int) (Math.sqrt((((double) i4) * (-2.0d)) / ((double) this.f)) * 1000.0d);
        }

        private void f(int i, int i2, int i3) {
            float f = (-i3) / this.f;
            float fSqrt = (float) Math.sqrt((((double) ((((i3 * i3) / 2.0f) / Math.abs(this.f)) + Math.abs(i2 - i))) * 2.0d) / ((double) Math.abs(this.f)));
            this.g -= (long) ((int) ((fSqrt - f) * 1000.0f));
            this.a = i2;
            this.d = (int) ((-this.f) * fSqrt);
        }

        private void g(int i, int i2, int i3) {
            this.f = a(i3 == 0 ? i - i2 : i3);
            f(i, i2, i3);
            d();
        }

        void a() {
            this.b = this.c;
            this.k = true;
        }

        void a(float f) {
            this.m = f;
        }

        void a(int i, int i2, int i3) {
            this.k = false;
            this.a = i;
            this.c = i + i2;
            this.g = AnimationUtils.currentAnimationTimeMillis();
            this.h = i3;
            this.f = 0.0f;
            this.d = 0;
        }

        void a(int i, int i2, int i3, int i4, int i5) {
            this.l = i5;
            this.k = false;
            this.d = i2;
            float f = i2;
            this.e = f;
            this.i = 0;
            this.h = 0;
            this.g = AnimationUtils.currentAnimationTimeMillis();
            this.a = i;
            this.b = i;
            if (i > i4 || i < i3) {
                a(i, i3, i4, i2);
                return;
            }
            this.n = 0;
            double dC = 0.0d;
            if (i2 != 0) {
                int iD = d(i2);
                this.i = iD;
                this.h = iD;
                dC = c(i2);
            }
            this.j = (int) (dC * ((double) Math.signum(f)));
            this.c = i + this.j;
            if (this.c < i3) {
                d(this.a, this.c, i3);
                this.c = i3;
            }
            if (this.c > i4) {
                d(this.a, this.c, i4);
                this.c = i4;
            }
        }

        void b(float f) {
            this.b = this.a + Math.round(f * (this.c - this.a));
        }

        boolean b() {
            switch (this.n) {
                case 0:
                    if (this.h >= this.i) {
                        return false;
                    }
                    this.a = this.c;
                    this.d = (int) this.e;
                    this.f = a(this.d);
                    this.g += (long) this.h;
                    d();
                    break;
                    break;
                case 1:
                    return false;
                case 2:
                    this.g += (long) this.h;
                    e(this.c, this.a, 0);
                    break;
            }
            c();
            return true;
        }

        boolean b(int i, int i2, int i3) {
            this.k = true;
            this.c = i;
            this.a = i;
            this.d = 0;
            this.g = AnimationUtils.currentAnimationTimeMillis();
            this.h = 0;
            if (i < i2) {
                e(i, i2, 0);
            } else if (i > i3) {
                e(i, i3, 0);
            }
            return !this.k;
        }

        void c(int i, int i2, int i3) {
            if (this.n == 0) {
                this.l = i3;
                this.g = AnimationUtils.currentAnimationTimeMillis();
                a(i, i2, i2, (int) this.e);
            }
        }

        boolean c() {
            long jCurrentAnimationTimeMillis = AnimationUtils.currentAnimationTimeMillis() - this.g;
            if (jCurrentAnimationTimeMillis > this.h) {
                return false;
            }
            double d = 0.0d;
            switch (this.n) {
                case 0:
                    float f = jCurrentAnimationTimeMillis / this.i;
                    int i = (int) (f * 100.0f);
                    float f2 = 1.0f;
                    float f3 = 0.0f;
                    if (i < 100) {
                        float f4 = i / 100.0f;
                        int i2 = i + 1;
                        float f5 = q[i];
                        f3 = (q[i2] - f5) / ((i2 / 100.0f) - f4);
                        f2 = f5 + ((f - f4) * f3);
                    }
                    d = f2 * this.j;
                    this.e = ((f3 * this.j) / this.i) * 1000.0f;
                    break;
                case 1:
                    float f6 = jCurrentAnimationTimeMillis / this.h;
                    float f7 = f6 * f6;
                    float fSignum = Math.signum(this.d);
                    this.e = fSignum * this.l * 6.0f * ((-f6) + f7);
                    d = this.l * fSignum * ((3.0f * f7) - ((2.0f * f6) * f7));
                    break;
                case 2:
                    float f8 = jCurrentAnimationTimeMillis / 1000.0f;
                    this.e = this.d + (this.f * f8);
                    d = (this.d * f8) + (((this.f * f8) * f8) / 2.0f);
                    break;
            }
            this.b = this.a + ((int) Math.round(d));
            return true;
        }
    }

    public c(Context context) {
        this(context, null);
    }

    public c(Context context, Interpolator interpolator) {
        this(context, interpolator, true);
    }

    public c(Context context, Interpolator interpolator, boolean z) {
        this.d = interpolator;
        this.e = z;
        this.b = new a(context);
        this.c = new a(context);
    }

    public static float a(float f2) {
        float f3 = f2 * f;
        return (f3 < 1.0f ? f3 - (1.0f - ((float) Math.exp(-f3))) : ((1.0f - ((float) Math.exp(1.0f - f3))) * 0.63212055f) + 0.36787945f) * g;
    }

    public void a(int i, int i2, int i3) {
        this.b.c(i, i2, i3);
    }

    public void a(int i, int i2, int i3, int i4, int i5) {
        this.a = 0;
        this.b.a(i, i3, i5);
        this.c.a(i2, i4, i5);
    }

    public void a(int i, int i2, int i3, int i4, int i5, int i6, int i7, int i8) {
        a(i, i2, i3, i4, i5, i6, i7, i8, 0, 0);
    }

    public void a(int i, int i2, int i3, int i4, int i5, int i6, int i7, int i8, int i9, int i10) {
        int i11;
        int i12;
        int i13;
        int i14;
        if (this.e && !a()) {
            float f2 = this.b.e;
            float f3 = this.c.e;
            i11 = i3;
            float f4 = i11;
            if (Math.signum(f4) == Math.signum(f2)) {
                i12 = i4;
                float f5 = i12;
                if (Math.signum(f5) == Math.signum(f3)) {
                    i13 = (int) (f5 + f3);
                    i14 = (int) (f4 + f2);
                }
                this.a = 1;
                this.b.a(i, i14, i5, i6, i9);
                this.c.a(i2, i13, i7, i8, i10);
            }
            i13 = i12;
            i14 = i11;
            this.a = 1;
            this.b.a(i, i14, i5, i6, i9);
            this.c.a(i2, i13, i7, i8, i10);
        }
        i11 = i3;
        i12 = i4;
        i13 = i12;
        i14 = i11;
        this.a = 1;
        this.b.a(i, i14, i5, i6, i9);
        this.c.a(i2, i13, i7, i8, i10);
    }

    void a(Interpolator interpolator) {
        this.d = interpolator;
    }

    public final boolean a() {
        return this.b.k && this.c.k;
    }

    public boolean a(float f2, float f3) {
        return !a() && Math.signum(f2) == Math.signum((float) (this.b.c - this.b.a)) && Math.signum(f3) == Math.signum((float) (this.c.c - this.c.a));
    }

    public boolean a(int i, int i2, int i3, int i4, int i5, int i6) {
        this.a = 1;
        return this.b.b(i, i3, i4) || this.c.b(i2, i5, i6);
    }

    public final int b() {
        return this.b.b;
    }

    public final void b(float f2) {
        this.b.a(f2);
        this.c.a(f2);
    }

    public float c() {
        return (float) Math.sqrt((this.b.e * this.b.e) + (this.c.e * this.c.e));
    }

    public boolean d() {
        if (a()) {
            return false;
        }
        switch (this.a) {
            case 0:
                long jCurrentAnimationTimeMillis = AnimationUtils.currentAnimationTimeMillis() - this.b.g;
                int i = this.b.h;
                if (jCurrentAnimationTimeMillis >= i) {
                    e();
                    return true;
                }
                float f2 = jCurrentAnimationTimeMillis / i;
                float fA = this.d == null ? a(f2) : this.d.getInterpolation(f2);
                this.b.b(fA);
                this.c.b(fA);
                return true;
            case 1:
                if (!this.b.k && !this.b.c() && !this.b.b()) {
                    this.b.a();
                }
                if (this.c.k || this.c.c() || this.c.b()) {
                    return true;
                }
                this.c.a();
                return true;
            default:
                return true;
        }
    }

    public void e() {
        this.b.a();
        this.c.a();
    }
}
