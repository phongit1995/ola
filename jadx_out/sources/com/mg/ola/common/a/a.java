package com.mg.ola.common.a;

import android.graphics.Bitmap;
import android.graphics.Matrix;

/* JADX INFO: loaded from: classes2.dex */
public class a {
    private Bitmap a;
    private int b = 0;

    public a(Bitmap bitmap) {
        this.a = bitmap;
    }

    public int a() {
        return this.b;
    }

    public void a(int i) {
        this.b = i;
    }

    public void a(Bitmap bitmap) {
        this.a = bitmap;
    }

    public Bitmap b() {
        return this.a;
    }

    public Matrix c() {
        Matrix matrix = new Matrix();
        if (this.b != 0) {
            matrix.preTranslate(-(this.a.getWidth() / 2), -(this.a.getHeight() / 2));
            matrix.postRotate(this.b);
            matrix.postTranslate(f() / 2, e() / 2);
        }
        return matrix;
    }

    public boolean d() {
        return (this.b / 90) % 2 != 0;
    }

    public int e() {
        if (this.a != null) {
            return d() ? this.a.getWidth() : this.a.getHeight();
        }
        return 1;
    }

    public int f() {
        if (this.a != null) {
            return d() ? this.a.getHeight() : this.a.getWidth();
        }
        return 1;
    }
}
