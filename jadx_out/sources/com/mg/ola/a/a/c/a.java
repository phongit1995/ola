package com.mg.ola.a.a.c;

import android.graphics.Camera;
import android.graphics.Matrix;
import android.graphics.RectF;
import android.os.Build;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.Transformation;
import java.lang.ref.WeakReference;
import java.util.WeakHashMap;

/* JADX INFO: loaded from: classes2.dex */
public final class a extends Animation {
    public static final boolean a;
    private static final WeakHashMap<View, a> b;
    private final WeakReference<View> c;
    private boolean e;
    private float g;
    private float h;
    private float i;
    private float j;
    private float k;
    private float n;
    private float o;
    private final Camera d = new Camera();
    private float f = 1.0f;
    private float l = 1.0f;
    private float m = 1.0f;
    private final RectF p = new RectF();
    private final RectF q = new RectF();
    private final Matrix r = new Matrix();

    static {
        a = Integer.valueOf(Build.VERSION.SDK).intValue() < 11;
        b = new WeakHashMap<>();
    }

    private a(View view) {
        setDuration(0L);
        setFillAfter(true);
        view.setAnimation(this);
        this.c = new WeakReference<>(view);
    }

    public static a a(View view) {
        a aVar = b.get(view);
        if (aVar != null && aVar == view.getAnimation()) {
            return aVar;
        }
        a aVar2 = new a(view);
        b.put(view, aVar2);
        return aVar2;
    }

    private void a(Matrix matrix, View view) {
        float width = view.getWidth();
        float height = view.getHeight();
        boolean z = this.e;
        float f = z ? this.g : width / 2.0f;
        float f2 = z ? this.h : height / 2.0f;
        float f3 = this.i;
        float f4 = this.j;
        float f5 = this.k;
        if (f3 != 0.0f || f4 != 0.0f || f5 != 0.0f) {
            Camera camera = this.d;
            camera.save();
            camera.rotateX(f3);
            camera.rotateY(f4);
            camera.rotateZ(-f5);
            camera.getMatrix(matrix);
            camera.restore();
            matrix.preTranslate(-f, -f2);
            matrix.postTranslate(f, f2);
        }
        float f6 = this.l;
        float f7 = this.m;
        if (f6 != 1.0f || f7 != 1.0f) {
            matrix.postScale(f6, f7);
            matrix.postTranslate((-(f / width)) * ((f6 * width) - width), (-(f2 / height)) * ((f7 * height) - height));
        }
        matrix.postTranslate(this.n, this.o);
    }

    private void a(RectF rectF, View view) {
        rectF.set(0.0f, 0.0f, view.getWidth(), view.getHeight());
        Matrix matrix = this.r;
        matrix.reset();
        a(matrix, view);
        this.r.mapRect(rectF);
        rectF.offset(view.getLeft(), view.getTop());
        if (rectF.right < rectF.left) {
            float f = rectF.right;
            rectF.right = rectF.left;
            rectF.left = f;
        }
        if (rectF.bottom < rectF.top) {
            float f2 = rectF.top;
            rectF.top = rectF.bottom;
            rectF.bottom = f2;
        }
    }

    private void o() {
        View view = this.c.get();
        if (view != null) {
            a(this.p, view);
        }
    }

    private void p() {
        View view = this.c.get();
        if (view == null || view.getParent() == null) {
            return;
        }
        RectF rectF = this.q;
        a(rectF, view);
        rectF.union(this.p);
        ((View) view.getParent()).invalidate((int) Math.floor(rectF.left), (int) Math.floor(rectF.top), (int) Math.ceil(rectF.right), (int) Math.ceil(rectF.bottom));
    }

    public float a() {
        return this.f;
    }

    public void a(float f) {
        if (this.f != f) {
            this.f = f;
            View view = this.c.get();
            if (view != null) {
                view.invalidate();
            }
        }
    }

    public void a(int i) {
        View view = this.c.get();
        if (view != null) {
            view.scrollTo(i, view.getScrollY());
        }
    }

    @Override // android.view.animation.Animation
    protected void applyTransformation(float f, Transformation transformation) {
        View view = this.c.get();
        if (view != null) {
            transformation.setAlpha(this.f);
            a(transformation.getMatrix(), view);
        }
    }

    public float b() {
        return this.g;
    }

    public void b(float f) {
        if (this.e && this.g == f) {
            return;
        }
        o();
        this.e = true;
        this.g = f;
        p();
    }

    public void b(int i) {
        View view = this.c.get();
        if (view != null) {
            view.scrollTo(view.getScrollX(), i);
        }
    }

    public float c() {
        return this.h;
    }

    public void c(float f) {
        if (this.e && this.h == f) {
            return;
        }
        o();
        this.e = true;
        this.h = f;
        p();
    }

    public float d() {
        return this.k;
    }

    public void d(float f) {
        if (this.k != f) {
            o();
            this.k = f;
            p();
        }
    }

    public float e() {
        return this.i;
    }

    public void e(float f) {
        if (this.i != f) {
            o();
            this.i = f;
            p();
        }
    }

    public float f() {
        return this.j;
    }

    public void f(float f) {
        if (this.j != f) {
            o();
            this.j = f;
            p();
        }
    }

    public float g() {
        return this.l;
    }

    public void g(float f) {
        if (this.l != f) {
            o();
            this.l = f;
            p();
        }
    }

    public float h() {
        return this.m;
    }

    public void h(float f) {
        if (this.m != f) {
            o();
            this.m = f;
            p();
        }
    }

    public int i() {
        View view = this.c.get();
        if (view == null) {
            return 0;
        }
        return view.getScrollX();
    }

    public void i(float f) {
        if (this.n != f) {
            o();
            this.n = f;
            p();
        }
    }

    public int j() {
        View view = this.c.get();
        if (view == null) {
            return 0;
        }
        return view.getScrollY();
    }

    public void j(float f) {
        if (this.o != f) {
            o();
            this.o = f;
            p();
        }
    }

    public float k() {
        return this.n;
    }

    public void k(float f) {
        if (this.c.get() != null) {
            i(f - r0.getLeft());
        }
    }

    public float l() {
        return this.o;
    }

    public void l(float f) {
        if (this.c.get() != null) {
            j(f - r0.getTop());
        }
    }

    public float m() {
        if (this.c.get() == null) {
            return 0.0f;
        }
        return r0.getLeft() + this.n;
    }

    public float n() {
        if (this.c.get() == null) {
            return 0.0f;
        }
        return r0.getTop() + this.o;
    }
}
