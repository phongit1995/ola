package com.mg.ola.a.a.b;

import android.view.animation.Interpolator;
import com.mg.ola.a.a.b.h;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes2.dex */
class e extends i {
    private float g;
    private float h;
    private float i;
    private boolean j;

    public e(h.a... aVarArr) {
        super(aVarArr);
        this.j = true;
    }

    @Override // com.mg.ola.a.a.b.i
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] and merged with bridge method [inline-methods] */
    public e clone() {
        ArrayList<h> arrayList = this.e;
        int size = this.e.size();
        h.a[] aVarArr = new h.a[size];
        for (int i = 0; i < size; i++) {
            aVarArr[i] = (h.a) arrayList.get(i).e();
        }
        return new e(aVarArr);
    }

    @Override // com.mg.ola.a.a.b.i
    public Object a(float f) {
        return Float.valueOf(b(f));
    }

    public float b(float f) {
        Object objB;
        if (this.a == 2) {
            if (this.j) {
                this.j = false;
                this.g = ((h.a) this.e.get(0)).f();
                this.h = ((h.a) this.e.get(1)).f();
                this.i = this.h - this.g;
            }
            if (this.d != null) {
                f = this.d.getInterpolation(f);
            }
            if (this.f == null) {
                return this.g + (f * this.i);
            }
            objB = this.f.a(f, Float.valueOf(this.g), Float.valueOf(this.h));
        } else {
            if (f <= 0.0f) {
                h.a aVar = (h.a) this.e.get(0);
                h.a aVar2 = (h.a) this.e.get(1);
                float f2 = aVar.f();
                float f3 = aVar2.f();
                float fC = aVar.c();
                float fC2 = aVar2.c();
                Interpolator interpolatorD = aVar2.d();
                if (interpolatorD != null) {
                    f = interpolatorD.getInterpolation(f);
                }
                float f4 = (f - fC) / (fC2 - fC);
                return this.f == null ? f2 + (f4 * (f3 - f2)) : ((Number) this.f.a(f4, Float.valueOf(f2), Float.valueOf(f3))).floatValue();
            }
            if (f >= 1.0f) {
                h.a aVar3 = (h.a) this.e.get(this.a - 2);
                h.a aVar4 = (h.a) this.e.get(this.a - 1);
                float f5 = aVar3.f();
                float f6 = aVar4.f();
                float fC3 = aVar3.c();
                float fC4 = aVar4.c();
                Interpolator interpolatorD2 = aVar4.d();
                if (interpolatorD2 != null) {
                    f = interpolatorD2.getInterpolation(f);
                }
                float f7 = (f - fC3) / (fC4 - fC3);
                return this.f == null ? f5 + (f7 * (f6 - f5)) : ((Number) this.f.a(f7, Float.valueOf(f5), Float.valueOf(f6))).floatValue();
            }
            h.a aVar5 = (h.a) this.e.get(0);
            int i = 1;
            while (i < this.a) {
                h.a aVar6 = (h.a) this.e.get(i);
                if (f < aVar6.c()) {
                    Interpolator interpolatorD3 = aVar6.d();
                    if (interpolatorD3 != null) {
                        f = interpolatorD3.getInterpolation(f);
                    }
                    float fC5 = (f - aVar5.c()) / (aVar6.c() - aVar5.c());
                    float f8 = aVar5.f();
                    float f9 = aVar6.f();
                    return this.f == null ? f8 + (fC5 * (f9 - f8)) : ((Number) this.f.a(fC5, Float.valueOf(f8), Float.valueOf(f9))).floatValue();
                }
                i++;
                aVar5 = aVar6;
            }
            objB = this.e.get(this.a - 1).b();
        }
        return ((Number) objB).floatValue();
    }
}
