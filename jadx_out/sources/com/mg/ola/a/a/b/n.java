package com.mg.ola.a.a.b;

import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.util.AndroidRuntimeException;
import android.view.animation.AccelerateDecelerateInterpolator;
import android.view.animation.AnimationUtils;
import android.view.animation.Interpolator;
import android.view.animation.LinearInterpolator;
import com.mg.ola.a.a.b.a;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

/* JADX INFO: loaded from: classes2.dex */
public class n extends com.mg.ola.a.a.b.a {
    private static ThreadLocal<a> h = new ThreadLocal<>();
    private static final ThreadLocal<ArrayList<n>> i = new ThreadLocal<ArrayList<n>>() { // from class: com.mg.ola.a.a.b.n.1
        /* JADX INFO: Access modifiers changed from: protected */
        @Override // java.lang.ThreadLocal
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public ArrayList<n> initialValue() {
            return new ArrayList<>();
        }
    };
    private static final ThreadLocal<ArrayList<n>> j = new ThreadLocal<ArrayList<n>>() { // from class: com.mg.ola.a.a.b.n.2
        /* JADX INFO: Access modifiers changed from: protected */
        @Override // java.lang.ThreadLocal
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public ArrayList<n> initialValue() {
            return new ArrayList<>();
        }
    };
    private static final ThreadLocal<ArrayList<n>> k = new ThreadLocal<ArrayList<n>>() { // from class: com.mg.ola.a.a.b.n.3
        /* JADX INFO: Access modifiers changed from: protected */
        @Override // java.lang.ThreadLocal
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public ArrayList<n> initialValue() {
            return new ArrayList<>();
        }
    };
    private static final ThreadLocal<ArrayList<n>> l = new ThreadLocal<ArrayList<n>>() { // from class: com.mg.ola.a.a.b.n.4
        /* JADX INFO: Access modifiers changed from: protected */
        @Override // java.lang.ThreadLocal
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public ArrayList<n> initialValue() {
            return new ArrayList<>();
        }
    };
    private static final ThreadLocal<ArrayList<n>> m = new ThreadLocal<ArrayList<n>>() { // from class: com.mg.ola.a.a.b.n.5
        /* JADX INFO: Access modifiers changed from: protected */
        @Override // java.lang.ThreadLocal
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public ArrayList<n> initialValue() {
            return new ArrayList<>();
        }
    };
    private static final Interpolator n = new AccelerateDecelerateInterpolator();
    private static final m o = new f();
    private static final m p = new d();
    private static long z = 10;
    long b;
    l[] f;
    HashMap<String, l> g;
    private long u;
    long c = -1;
    private boolean q = false;
    private int r = 0;
    private float s = 0.0f;
    private boolean t = false;
    int d = 0;
    private boolean v = false;
    private boolean w = false;
    boolean e = false;
    private long x = 300;
    private long y = 0;
    private int A = 0;
    private int B = 1;
    private Interpolator C = n;
    private ArrayList<b> D = null;

    private static class a extends Handler {
        private a() {
        }

        @Override // android.os.Handler
        public void handleMessage(Message message) {
            boolean z;
            ArrayList arrayList = (ArrayList) n.i.get();
            ArrayList arrayList2 = (ArrayList) n.k.get();
            switch (message.what) {
                case 0:
                    ArrayList arrayList3 = (ArrayList) n.j.get();
                    z = arrayList.size() <= 0 && arrayList2.size() <= 0;
                    while (arrayList3.size() > 0) {
                        ArrayList arrayList4 = (ArrayList) arrayList3.clone();
                        arrayList3.clear();
                        int size = arrayList4.size();
                        for (int i = 0; i < size; i++) {
                            n nVar = (n) arrayList4.get(i);
                            if (nVar.y == 0) {
                                nVar.t();
                            } else {
                                arrayList2.add(nVar);
                            }
                        }
                    }
                    break;
                case 1:
                    z = true;
                    break;
                default:
                    return;
            }
            long jCurrentAnimationTimeMillis = AnimationUtils.currentAnimationTimeMillis();
            ArrayList arrayList5 = (ArrayList) n.m.get();
            ArrayList arrayList6 = (ArrayList) n.l.get();
            int size2 = arrayList2.size();
            for (int i2 = 0; i2 < size2; i2++) {
                n nVar2 = (n) arrayList2.get(i2);
                if (nVar2.b(jCurrentAnimationTimeMillis)) {
                    arrayList5.add(nVar2);
                }
            }
            int size3 = arrayList5.size();
            if (size3 > 0) {
                for (int i3 = 0; i3 < size3; i3++) {
                    n nVar3 = (n) arrayList5.get(i3);
                    nVar3.t();
                    nVar3.v = true;
                    arrayList2.remove(nVar3);
                }
                arrayList5.clear();
            }
            int size4 = arrayList.size();
            int i4 = 0;
            while (i4 < size4) {
                n nVar4 = (n) arrayList.get(i4);
                if (nVar4.f(jCurrentAnimationTimeMillis)) {
                    arrayList6.add(nVar4);
                }
                if (arrayList.size() == size4) {
                    i4++;
                } else {
                    size4--;
                    arrayList6.remove(nVar4);
                }
            }
            if (arrayList6.size() > 0) {
                for (int i5 = 0; i5 < arrayList6.size(); i5++) {
                    ((n) arrayList6.get(i5)).i();
                }
                arrayList6.clear();
            }
            if (z) {
                if (arrayList.isEmpty() && arrayList2.isEmpty()) {
                    return;
                }
                sendEmptyMessageDelayed(1, Math.max(0L, n.z - (AnimationUtils.currentAnimationTimeMillis() - jCurrentAnimationTimeMillis)));
            }
        }
    }

    public interface b {
        void a(n nVar);
    }

    private void a(boolean z2) {
        if (Looper.myLooper() == null) {
            throw new AndroidRuntimeException("Animators may only be run on Looper threads");
        }
        this.q = z2;
        this.r = 0;
        this.d = 0;
        this.w = true;
        this.t = false;
        j.get().add(this);
        if (this.y == 0) {
            d(k());
            this.d = 0;
            this.v = true;
            if (this.a != null) {
                ArrayList arrayList = (ArrayList) this.a.clone();
                int size = arrayList.size();
                for (int i2 = 0; i2 < size; i2++) {
                    ((a.InterfaceC0079a) arrayList.get(i2)).c(this);
                }
            }
        }
        a aVar = h.get();
        if (aVar == null) {
            aVar = new a();
            h.set(aVar);
        }
        aVar.sendEmptyMessage(0);
    }

    public static n b(float... fArr) {
        n nVar = new n();
        nVar.a(fArr);
        return nVar;
    }

    public static n b(int... iArr) {
        n nVar = new n();
        nVar.a(iArr);
        return nVar;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean b(long j2) {
        if (!this.t) {
            this.t = true;
            this.u = j2;
            return false;
        }
        long j3 = j2 - this.u;
        if (j3 <= this.y) {
            return false;
        }
        this.b = j2 - (j3 - this.y);
        this.d = 1;
        return true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void i() {
        i.get().remove(this);
        j.get().remove(this);
        k.get().remove(this);
        this.d = 0;
        if (this.v && this.a != null) {
            ArrayList arrayList = (ArrayList) this.a.clone();
            int size = arrayList.size();
            for (int i2 = 0; i2 < size; i2++) {
                ((a.InterfaceC0079a) arrayList.get(i2)).a(this);
            }
        }
        this.v = false;
        this.w = false;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void t() {
        h();
        i.get().add(this);
        if (this.y <= 0 || this.a == null) {
            return;
        }
        ArrayList arrayList = (ArrayList) this.a.clone();
        int size = arrayList.size();
        for (int i2 = 0; i2 < size; i2++) {
            ((a.InterfaceC0079a) arrayList.get(i2)).c(this);
        }
    }

    @Override // com.mg.ola.a.a.b.a
    public void a() {
        a(false);
    }

    void a(float f) {
        float interpolation = this.C.getInterpolation(f);
        this.s = interpolation;
        int length = this.f.length;
        for (int i2 = 0; i2 < length; i2++) {
            this.f[i2].a(interpolation);
        }
        if (this.D != null) {
            int size = this.D.size();
            for (int i3 = 0; i3 < size; i3++) {
                this.D.get(i3).a(this);
            }
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // com.mg.ola.a.a.b.a
    public void a(Interpolator interpolator) {
        if (interpolator == null) {
            interpolator = new LinearInterpolator();
        }
        this.C = interpolator;
    }

    public void a(b bVar) {
        if (this.D == null) {
            this.D = new ArrayList<>();
        }
        this.D.add(bVar);
    }

    public void a(float... fArr) {
        if (fArr == null || fArr.length == 0) {
            return;
        }
        if (this.f == null || this.f.length == 0) {
            a(l.a("", fArr));
        } else {
            this.f[0].a(fArr);
        }
        this.e = false;
    }

    public void a(int... iArr) {
        if (iArr == null || iArr.length == 0) {
            return;
        }
        if (this.f == null || this.f.length == 0) {
            a(l.a("", iArr));
        } else {
            this.f[0].a(iArr);
        }
        this.e = false;
    }

    public void a(l... lVarArr) {
        int length = lVarArr.length;
        this.f = lVarArr;
        this.g = new HashMap<>(length);
        for (l lVar : lVarArr) {
            this.g.put(lVar.c(), lVar);
        }
        this.e = false;
    }

    @Override // com.mg.ola.a.a.b.a
    public void b() {
        if (this.d != 0 || j.get().contains(this) || k.get().contains(this)) {
            if (this.v && this.a != null) {
                Iterator it2 = ((ArrayList) this.a.clone()).iterator();
                while (it2.hasNext()) {
                    ((a.InterfaceC0079a) it2.next()).b(this);
                }
            }
            i();
        }
    }

    @Override // com.mg.ola.a.a.b.a
    /* JADX INFO: renamed from: c, reason: merged with bridge method [inline-methods] */
    public n a(long j2) {
        if (j2 >= 0) {
            this.x = j2;
            return this;
        }
        throw new IllegalArgumentException("Animators cannot have negative duration: " + j2);
    }

    @Override // com.mg.ola.a.a.b.a
    public void c() {
        if (!i.get().contains(this) && !j.get().contains(this)) {
            this.t = false;
            t();
        } else if (!this.e) {
            h();
        }
        a((this.A <= 0 || (this.A & 1) != 1) ? 1.0f : 0.0f);
        i();
    }

    public void d(long j2) {
        h();
        long jCurrentAnimationTimeMillis = AnimationUtils.currentAnimationTimeMillis();
        if (this.d != 1) {
            this.c = j2;
            this.d = 2;
        }
        this.b = jCurrentAnimationTimeMillis - j2;
        f(jCurrentAnimationTimeMillis);
    }

    @Override // com.mg.ola.a.a.b.a
    public boolean d() {
        return this.d == 1 || this.v;
    }

    public void e(long j2) {
        this.y = j2;
    }

    @Override // com.mg.ola.a.a.b.a
    public boolean e() {
        return this.w;
    }

    boolean f(long j2) {
        if (this.d == 0) {
            this.d = 1;
            if (this.c < 0) {
                this.b = j2;
            } else {
                this.b = j2 - this.c;
                this.c = -1L;
            }
        }
        boolean z2 = false;
        switch (this.d) {
            case 1:
            case 2:
                float fMin = this.x > 0 ? (j2 - this.b) / this.x : 1.0f;
                if (fMin >= 1.0f) {
                    if (this.r < this.A || this.A == -1) {
                        if (this.a != null) {
                            int size = this.a.size();
                            for (int i2 = 0; i2 < size; i2++) {
                                this.a.get(i2).d(this);
                            }
                        }
                        if (this.B == 2) {
                            this.q = !this.q;
                        }
                        this.r += (int) fMin;
                        fMin %= 1.0f;
                        this.b += this.x;
                    } else {
                        fMin = Math.min(fMin, 1.0f);
                        z2 = true;
                    }
                }
                if (this.q) {
                    fMin = 1.0f - fMin;
                }
                a(fMin);
                return z2;
            default:
                return false;
        }
    }

    void h() {
        if (this.e) {
            return;
        }
        int length = this.f.length;
        for (int i2 = 0; i2 < length; i2++) {
            this.f[i2].b();
        }
        this.e = true;
    }

    @Override // com.mg.ola.a.a.b.a
    /* JADX INFO: renamed from: j, reason: merged with bridge method [inline-methods] */
    public n clone() {
        n nVar = (n) super.clone();
        if (this.D != null) {
            ArrayList<b> arrayList = this.D;
            nVar.D = new ArrayList<>();
            int size = arrayList.size();
            for (int i2 = 0; i2 < size; i2++) {
                nVar.D.add(arrayList.get(i2));
            }
        }
        nVar.c = -1L;
        nVar.q = false;
        nVar.r = 0;
        nVar.e = false;
        nVar.d = 0;
        nVar.t = false;
        l[] lVarArr = this.f;
        if (lVarArr != null) {
            int length = lVarArr.length;
            nVar.f = new l[length];
            nVar.g = new HashMap<>(length);
            for (int i3 = 0; i3 < length; i3++) {
                l lVarClone = lVarArr[i3].clone();
                nVar.f[i3] = lVarClone;
                nVar.g.put(lVarClone.c(), lVarClone);
            }
        }
        return nVar;
    }

    public long k() {
        if (!this.e || this.d == 0) {
            return 0L;
        }
        return AnimationUtils.currentAnimationTimeMillis() - this.b;
    }

    public Object l() {
        if (this.f == null || this.f.length <= 0) {
            return null;
        }
        return this.f[0].d();
    }

    public float m() {
        return this.s;
    }

    public String toString() {
        String str = "ValueAnimator@" + Integer.toHexString(hashCode());
        if (this.f != null) {
            for (int i2 = 0; i2 < this.f.length; i2++) {
                str = str + "\n    " + this.f[i2].toString();
            }
        }
        return str;
    }
}
