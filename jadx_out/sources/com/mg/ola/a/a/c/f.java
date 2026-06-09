package com.mg.ola.a.a.c;

import android.support.v4.app.FrameMetricsAggregator;
import android.view.View;
import android.view.animation.Interpolator;
import com.mg.ola.a.a.b.a;
import com.mg.ola.a.a.b.n;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

/* JADX INFO: loaded from: classes2.dex */
class f extends com.mg.ola.a.a.c.c {
    private final com.mg.ola.a.a.c.a b;
    private final WeakReference<View> c;
    private long d;
    private Interpolator h;
    private boolean e = false;
    private long f = 0;
    private boolean g = false;
    private boolean i = false;
    private a.InterfaceC0079a j = null;
    private a k = new a();
    ArrayList<b> a = new ArrayList<>();
    private Runnable l = new Runnable() { // from class: com.mg.ola.a.a.c.f.1
        @Override // java.lang.Runnable
        public void run() {
            f.this.a();
        }
    };
    private HashMap<com.mg.ola.a.a.b.a, c> m = new HashMap<>();

    private class a implements a.InterfaceC0079a, n.b {
        private a() {
        }

        @Override // com.mg.ola.a.a.b.a.InterfaceC0079a
        public void a(com.mg.ola.a.a.b.a aVar) {
            if (f.this.j != null) {
                f.this.j.a(aVar);
            }
            f.this.m.remove(aVar);
            if (f.this.m.isEmpty()) {
                f.this.j = null;
            }
        }

        @Override // com.mg.ola.a.a.b.n.b
        public void a(n nVar) {
            View view;
            float fM = nVar.m();
            c cVar = (c) f.this.m.get(nVar);
            if ((cVar.a & FrameMetricsAggregator.EVERY_DURATION) != 0 && (view = (View) f.this.c.get()) != null) {
                view.invalidate();
            }
            ArrayList<b> arrayList = cVar.b;
            if (arrayList != null) {
                int size = arrayList.size();
                for (int i = 0; i < size; i++) {
                    b bVar = arrayList.get(i);
                    f.this.b(bVar.a, bVar.b + (bVar.c * fM));
                }
            }
            View view2 = (View) f.this.c.get();
            if (view2 != null) {
                view2.invalidate();
            }
        }

        @Override // com.mg.ola.a.a.b.a.InterfaceC0079a
        public void b(com.mg.ola.a.a.b.a aVar) {
            if (f.this.j != null) {
                f.this.j.b(aVar);
            }
        }

        @Override // com.mg.ola.a.a.b.a.InterfaceC0079a
        public void c(com.mg.ola.a.a.b.a aVar) {
            if (f.this.j != null) {
                f.this.j.c(aVar);
            }
        }

        @Override // com.mg.ola.a.a.b.a.InterfaceC0079a
        public void d(com.mg.ola.a.a.b.a aVar) {
            if (f.this.j != null) {
                f.this.j.d(aVar);
            }
        }
    }

    private static class b {
        int a;
        float b;
        float c;

        b(int i, float f, float f2) {
            this.a = i;
            this.b = f;
            this.c = f2;
        }
    }

    private static class c {
        int a;
        ArrayList<b> b;

        c(int i, ArrayList<b> arrayList) {
            this.a = i;
            this.b = arrayList;
        }

        boolean a(int i) {
            if ((this.a & i) != 0 && this.b != null) {
                int size = this.b.size();
                for (int i2 = 0; i2 < size; i2++) {
                    if (this.b.get(i2).a == i) {
                        this.b.remove(i2);
                        this.a = (i ^ (-1)) & this.a;
                        return true;
                    }
                }
            }
            return false;
        }
    }

    f(View view) {
        this.c = new WeakReference<>(view);
        this.b = com.mg.ola.a.a.c.a.a(view);
    }

    private float a(int i) {
        if (i == 4) {
            return this.b.g();
        }
        if (i == 8) {
            return this.b.h();
        }
        if (i == 16) {
            return this.b.d();
        }
        if (i == 32) {
            return this.b.e();
        }
        if (i == 64) {
            return this.b.f();
        }
        if (i == 128) {
            return this.b.m();
        }
        if (i == 256) {
            return this.b.n();
        }
        if (i == 512) {
            return this.b.a();
        }
        switch (i) {
            case 1:
                return this.b.k();
            case 2:
                return this.b.l();
            default:
                return 0.0f;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a() {
        n nVarB = n.b(1.0f);
        ArrayList arrayList = (ArrayList) this.a.clone();
        this.a.clear();
        int size = arrayList.size();
        int i = 0;
        for (int i2 = 0; i2 < size; i2++) {
            i |= ((b) arrayList.get(i2)).a;
        }
        this.m.put(nVarB, new c(i, arrayList));
        nVarB.a((n.b) this.k);
        nVarB.a((a.InterfaceC0079a) this.k);
        if (this.g) {
            nVarB.e(this.f);
        }
        if (this.e) {
            nVarB.a(this.d);
        }
        if (this.i) {
            nVarB.a(this.h);
        }
        nVarB.a();
    }

    private void a(int i, float f) {
        float fA = a(i);
        a(i, fA, f - fA);
    }

    private void a(int i, float f, float f2) {
        if (this.m.size() > 0) {
            com.mg.ola.a.a.b.a aVar = null;
            Iterator<com.mg.ola.a.a.b.a> it2 = this.m.keySet().iterator();
            while (true) {
                if (!it2.hasNext()) {
                    break;
                }
                com.mg.ola.a.a.b.a next = it2.next();
                c cVar = this.m.get(next);
                if (cVar.a(i) && cVar.a == 0) {
                    aVar = next;
                    break;
                }
            }
            if (aVar != null) {
                aVar.b();
            }
        }
        this.a.add(new b(i, f, f2));
        View view = this.c.get();
        if (view != null) {
            view.removeCallbacks(this.l);
            view.post(this.l);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void b(int i, float f) {
        if (i == 4) {
            this.b.g(f);
            return;
        }
        if (i == 8) {
            this.b.h(f);
            return;
        }
        if (i == 16) {
            this.b.d(f);
            return;
        }
        if (i == 32) {
            this.b.e(f);
            return;
        }
        if (i == 64) {
            this.b.f(f);
            return;
        }
        if (i == 128) {
            this.b.k(f);
            return;
        }
        if (i == 256) {
            this.b.l(f);
            return;
        }
        if (i == 512) {
            this.b.a(f);
            return;
        }
        switch (i) {
            case 1:
                this.b.i(f);
                break;
            case 2:
                this.b.j(f);
                break;
        }
    }

    @Override // com.mg.ola.a.a.c.c
    public com.mg.ola.a.a.c.c a(float f) {
        a(1, f);
        return this;
    }

    @Override // com.mg.ola.a.a.c.c
    public com.mg.ola.a.a.c.c a(long j) {
        if (j >= 0) {
            this.e = true;
            this.d = j;
            return this;
        }
        throw new IllegalArgumentException("Animators cannot have negative duration: " + j);
    }

    @Override // com.mg.ola.a.a.c.c
    public com.mg.ola.a.a.c.c a(a.InterfaceC0079a interfaceC0079a) {
        this.j = interfaceC0079a;
        return this;
    }

    @Override // com.mg.ola.a.a.c.c
    public com.mg.ola.a.a.c.c b(float f) {
        a(512, f);
        return this;
    }
}
