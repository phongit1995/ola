package com.mg.ola.a.a.b;

import android.view.animation.Interpolator;
import com.mg.ola.a.a.b.h;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes2.dex */
class g extends i {
    private int g;
    private int h;
    private int i;
    private boolean j;

    public g(h.b... bVarArr) {
        super(bVarArr);
        this.j = true;
    }

    @Override // com.mg.ola.a.a.b.i
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public g clone() {
        ArrayList<h> arrayList = this.e;
        int size = this.e.size();
        h.b[] bVarArr = new h.b[size];
        for (int i = 0; i < size; i++) {
            bVarArr[i] = (h.b) arrayList.get(i).e();
        }
        return new g(bVarArr);
    }

    @Override // com.mg.ola.a.a.b.i
    public Object a(float f) {
        return Integer.valueOf(b(f));
    }

    public int b(float f) {
        Object objB;
        if (this.a == 2) {
            if (this.j) {
                this.j = false;
                this.g = ((h.b) this.e.get(0)).f();
                this.h = ((h.b) this.e.get(1)).f();
                this.i = this.h - this.g;
            }
            if (this.d != null) {
                f = this.d.getInterpolation(f);
            }
            if (this.f == null) {
                return this.g + ((int) (f * this.i));
            }
            objB = this.f.a(f, Integer.valueOf(this.g), Integer.valueOf(this.h));
        } else {
            if (f <= 0.0f) {
                h.b bVar = (h.b) this.e.get(0);
                h.b bVar2 = (h.b) this.e.get(1);
                int iF = bVar.f();
                int iF2 = bVar2.f();
                float fC = bVar.c();
                float fC2 = bVar2.c();
                Interpolator interpolatorD = bVar2.d();
                if (interpolatorD != null) {
                    f = interpolatorD.getInterpolation(f);
                }
                float f2 = (f - fC) / (fC2 - fC);
                return this.f == null ? iF + ((int) (f2 * (iF2 - iF))) : ((Number) this.f.a(f2, Integer.valueOf(iF), Integer.valueOf(iF2))).intValue();
            }
            if (f >= 1.0f) {
                h.b bVar3 = (h.b) this.e.get(this.a - 2);
                h.b bVar4 = (h.b) this.e.get(this.a - 1);
                int iF3 = bVar3.f();
                int iF4 = bVar4.f();
                float fC3 = bVar3.c();
                float fC4 = bVar4.c();
                Interpolator interpolatorD2 = bVar4.d();
                if (interpolatorD2 != null) {
                    f = interpolatorD2.getInterpolation(f);
                }
                float f3 = (f - fC3) / (fC4 - fC3);
                return this.f == null ? iF3 + ((int) (f3 * (iF4 - iF3))) : ((Number) this.f.a(f3, Integer.valueOf(iF3), Integer.valueOf(iF4))).intValue();
            }
            h.b bVar5 = (h.b) this.e.get(0);
            int i = 1;
            while (i < this.a) {
                h.b bVar6 = (h.b) this.e.get(i);
                if (f < bVar6.c()) {
                    Interpolator interpolatorD3 = bVar6.d();
                    if (interpolatorD3 != null) {
                        f = interpolatorD3.getInterpolation(f);
                    }
                    float fC5 = (f - bVar5.c()) / (bVar6.c() - bVar5.c());
                    int iF5 = bVar5.f();
                    return this.f == null ? iF5 + ((int) (fC5 * (r1 - iF5))) : ((Number) this.f.a(fC5, Integer.valueOf(iF5), Integer.valueOf(bVar6.f()))).intValue();
                }
                i++;
                bVar5 = bVar6;
            }
            objB = this.e.get(this.a - 1).b();
        }
        return ((Number) objB).intValue();
    }
}
