package com.mg.ola.a.a.b;

import android.view.animation.Interpolator;
import com.mg.ola.a.a.b.h;
import java.util.ArrayList;
import java.util.Arrays;

/* JADX INFO: loaded from: classes2.dex */
class i {
    int a;
    h b;
    h c;
    Interpolator d;
    ArrayList<h> e = new ArrayList<>();
    m f;

    public i(h... hVarArr) {
        this.a = hVarArr.length;
        this.e.addAll(Arrays.asList(hVarArr));
        this.b = this.e.get(0);
        this.c = this.e.get(this.a - 1);
        this.d = this.c.d();
    }

    public static i a(float... fArr) {
        int length = fArr.length;
        h.a[] aVarArr = new h.a[Math.max(length, 2)];
        if (length == 1) {
            aVarArr[0] = (h.a) h.b(0.0f);
            aVarArr[1] = (h.a) h.a(1.0f, fArr[0]);
        } else {
            aVarArr[0] = (h.a) h.a(0.0f, fArr[0]);
            for (int i = 1; i < length; i++) {
                aVarArr[i] = (h.a) h.a(i / (length - 1), fArr[i]);
            }
        }
        return new e(aVarArr);
    }

    public static i a(int... iArr) {
        int length = iArr.length;
        h.b[] bVarArr = new h.b[Math.max(length, 2)];
        if (length == 1) {
            bVarArr[0] = (h.b) h.a(0.0f);
            bVarArr[1] = (h.b) h.a(1.0f, iArr[0]);
        } else {
            bVarArr[0] = (h.b) h.a(0.0f, iArr[0]);
            for (int i = 1; i < length; i++) {
                bVarArr[i] = (h.b) h.a(i / (length - 1), iArr[i]);
            }
        }
        return new g(bVarArr);
    }

    public Object a(float f) {
        if (this.a == 2) {
            if (this.d != null) {
                f = this.d.getInterpolation(f);
            }
            return this.f.a(f, this.b.b(), this.c.b());
        }
        int i = 1;
        if (f <= 0.0f) {
            h hVar = this.e.get(1);
            Interpolator interpolatorD = hVar.d();
            if (interpolatorD != null) {
                f = interpolatorD.getInterpolation(f);
            }
            float fC = this.b.c();
            return this.f.a((f - fC) / (hVar.c() - fC), this.b.b(), hVar.b());
        }
        if (f >= 1.0f) {
            h hVar2 = this.e.get(this.a - 2);
            Interpolator interpolatorD2 = this.c.d();
            if (interpolatorD2 != null) {
                f = interpolatorD2.getInterpolation(f);
            }
            float fC2 = hVar2.c();
            return this.f.a((f - fC2) / (this.c.c() - fC2), hVar2.b(), this.c.b());
        }
        h hVar3 = this.b;
        while (i < this.a) {
            h hVar4 = this.e.get(i);
            if (f < hVar4.c()) {
                Interpolator interpolatorD3 = hVar4.d();
                if (interpolatorD3 != null) {
                    f = interpolatorD3.getInterpolation(f);
                }
                float fC3 = hVar3.c();
                return this.f.a((f - fC3) / (hVar4.c() - fC3), hVar3.b(), hVar4.b());
            }
            i++;
            hVar3 = hVar4;
        }
        return this.c.b();
    }

    public void a(m mVar) {
        this.f = mVar;
    }

    @Override // 
    /* JADX INFO: renamed from: b */
    public i clone() {
        ArrayList<h> arrayList = this.e;
        int size = this.e.size();
        h[] hVarArr = new h[size];
        for (int i = 0; i < size; i++) {
            hVarArr[i] = arrayList.get(i).e();
        }
        return new i(hVarArr);
    }

    public String toString() {
        String str = " ";
        for (int i = 0; i < this.a; i++) {
            str = str + this.e.get(i).b() + "  ";
        }
        return str;
    }
}
