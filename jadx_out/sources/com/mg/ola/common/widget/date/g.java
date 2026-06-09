package com.mg.ola.common.widget.date;

import android.util.Log;

/* JADX INFO: loaded from: classes2.dex */
class g {
    private boolean a;
    private boolean b;
    private boolean c;
    private float d;
    private float e;
    private float f;
    private float g;
    private float h;
    private float i;
    private float j;
    private float k;

    private void a(int i, float f) {
        boolean z;
        this.k = i * this.i;
        float f2 = this.k;
        if (this.b) {
            this.k %= this.h;
            f2 %= this.h;
            float f3 = this.j % this.h;
            float f4 = f2 < f3 ? this.h + f2 : f2 - this.h;
            if (Math.abs(f3 - f2) > Math.abs(f3 - f4)) {
                f2 = f4;
            }
            if (this.k < 0.0f) {
                this.k += this.h;
            }
        }
        if (f2 < this.j) {
            this.f = -f;
        } else {
            if (f2 <= this.j) {
                z = false;
                this.c = z;
            }
            this.f = f;
        }
        this.e = Math.abs(this.f);
        z = true;
        this.c = z;
    }

    private void c(float f) {
        this.j = f;
        if (this.b) {
            this.j %= this.h;
            if (this.j < 0.0f) {
                this.j += this.h;
            }
        }
    }

    private boolean h() {
        float f;
        if (!this.b) {
            if (this.j < this.g) {
                this.f = 50.0f;
                f = this.g;
            } else if (this.j > this.h) {
                this.f = -50.0f;
                f = this.h;
            }
            this.k = f;
            this.e = Math.abs(this.f);
            this.c = true;
            return true;
        }
        return false;
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private void i() {
        a((int) ((this.j < 0.0f ? this.j - (this.i / 2.0f) : this.j + (this.i / 2.0f)) / this.i), 5.0f);
    }

    public void a() {
        this.a = false;
        this.c = false;
        this.d = 0.0f;
        this.f = 0.0f;
    }

    public void a(float f) {
        this.a = false;
        this.c = false;
        c(this.j + f);
        h();
    }

    public void a(float f, float f2, boolean z) {
        a();
        this.b = z;
        this.g = 0.0f;
        this.i = f2;
        this.h = f;
        if (z) {
            this.h += f2 - 1.0f;
        }
    }

    public void a(int i) {
        a(i, Math.min(Math.abs(((i * this.i) - this.j) / 3.0f), 80.0f));
    }

    public void b() {
        this.a = false;
        this.c = false;
    }

    public void b(float f) {
        if (this.c) {
            this.a = false;
            return;
        }
        float f2 = f / 30.0f;
        if (Math.abs(f2) < 7.0f) {
            this.a = false;
        } else {
            this.d = f2;
            this.a = true;
        }
    }

    public void b(int i) {
        this.j = i * this.i;
    }

    public void c() {
        if (d()) {
            return;
        }
        i();
    }

    public boolean d() {
        return this.a || this.c;
    }

    public int e() {
        return (int) (this.j / this.i);
    }

    public int f() {
        return (int) (this.j % this.i);
    }

    public boolean g() {
        Log.i("update", toString());
        if (!this.a) {
            if (!this.c) {
                return false;
            }
            if (Math.abs(this.k - this.j) >= this.e) {
                c(this.j + this.f);
                return true;
            }
            c(this.k);
            this.c = false;
            return d();
        }
        if (Math.abs(this.d) < 7.0f) {
            this.a = false;
            if (!d()) {
                i();
            }
            return d();
        }
        c(this.j - this.d);
        this.d *= 0.92f;
        if (h()) {
            this.d *= 0.6f;
        }
        return true;
    }

    public String toString() {
        return "pos:" + this.j + ", isFl:" + this.a + ", isMv:" + this.c;
    }
}
