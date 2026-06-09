package com.mg.ola.a.a.b;

import android.view.View;
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
public final class j extends n {
    private static final Map<String, com.mg.ola.a.a.a.c> h = new HashMap();
    private Object i;
    private String j;
    private com.mg.ola.a.a.a.c k;

    static {
        h.put("alpha", k.a);
        h.put("pivotX", k.b);
        h.put("pivotY", k.c);
        h.put("translationX", k.d);
        h.put("translationY", k.e);
        h.put("rotation", k.f);
        h.put("rotationX", k.g);
        h.put("rotationY", k.h);
        h.put("scaleX", k.i);
        h.put("scaleY", k.j);
        h.put("scrollX", k.k);
        h.put("scrollY", k.l);
        h.put("x", k.m);
        h.put("y", k.n);
    }

    public j() {
    }

    private j(Object obj, String str) {
        this.i = obj;
        a(str);
    }

    public static j a(Object obj, String str, float... fArr) {
        j jVar = new j(obj, str);
        jVar.a(fArr);
        return jVar;
    }

    @Override // com.mg.ola.a.a.b.n, com.mg.ola.a.a.b.a
    public void a() {
        super.a();
    }

    @Override // com.mg.ola.a.a.b.n
    void a(float f) {
        super.a(f);
        int length = this.f.length;
        for (int i = 0; i < length; i++) {
            this.f[i].b(this.i);
        }
    }

    public void a(com.mg.ola.a.a.a.c cVar) {
        if (this.f != null) {
            l lVar = this.f[0];
            String strC = lVar.c();
            lVar.a(cVar);
            this.g.remove(strC);
            this.g.put(this.j, lVar);
        }
        if (this.k != null) {
            this.j = cVar.a();
        }
        this.k = cVar;
        this.e = false;
    }

    public void a(String str) {
        if (this.f != null) {
            l lVar = this.f[0];
            String strC = lVar.c();
            lVar.a(str);
            this.g.remove(strC);
            this.g.put(str, lVar);
        }
        this.j = str;
        this.e = false;
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // com.mg.ola.a.a.b.n
    public void a(float... fArr) {
        if (this.f == null || this.f.length == 0) {
            a(this.k != null ? new l[]{l.a((com.mg.ola.a.a.a.c<?, Float>) this.k, fArr)} : new l[]{l.a(this.j, fArr)});
        } else {
            super.a(fArr);
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // com.mg.ola.a.a.b.n
    public void a(int... iArr) {
        if (this.f == null || this.f.length == 0) {
            a(this.k != null ? new l[]{l.a((com.mg.ola.a.a.a.c<?, Integer>) this.k, iArr)} : new l[]{l.a(this.j, iArr)});
        } else {
            super.a(iArr);
        }
    }

    @Override // com.mg.ola.a.a.b.n
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public j a(long j) {
        super.a(j);
        return this;
    }

    @Override // com.mg.ola.a.a.b.n
    void h() {
        if (this.e) {
            return;
        }
        if (this.k == null && com.mg.ola.a.a.c.a.a && (this.i instanceof View) && h.containsKey(this.j)) {
            a(h.get(this.j));
        }
        int length = this.f.length;
        for (int i = 0; i < length; i++) {
            this.f[i].a(this.i);
        }
        super.h();
    }

    @Override // com.mg.ola.a.a.b.n
    /* JADX INFO: renamed from: i, reason: merged with bridge method [inline-methods] */
    public j clone() {
        return (j) super.clone();
    }

    @Override // com.mg.ola.a.a.b.n
    public String toString() {
        String str = "ObjectAnimator@" + Integer.toHexString(hashCode()) + ", target " + this.i;
        if (this.f != null) {
            for (int i = 0; i < this.f.length; i++) {
                str = str + "\n    " + this.f[i].toString();
            }
        }
        return str;
    }
}
