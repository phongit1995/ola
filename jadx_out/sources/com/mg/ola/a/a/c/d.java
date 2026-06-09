package com.mg.ola.a.a.c;

import android.annotation.TargetApi;
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
class d extends com.mg.ola.a.a.c.c {
    private final WeakReference<View> b;
    private long c;
    private Interpolator g;
    private boolean d = false;
    private long e = 0;
    private boolean f = false;
    private boolean h = false;
    private a.InterfaceC0079a i = null;
    private a j = new a();
    ArrayList<b> a = new ArrayList<>();
    private Runnable k = new Runnable() { // from class: com.mg.ola.a.a.c.d.1
        @Override // java.lang.Runnable
        public void run() {
            d.this.a();
        }
    };
    private HashMap<com.mg.ola.a.a.b.a, c> l = new HashMap<>();

    private class a implements a.InterfaceC0079a, n.b {
        private a() {
        }

        @Override // com.mg.ola.a.a.b.a.InterfaceC0079a
        public void a(com.mg.ola.a.a.b.a aVar) {
            if (d.this.i != null) {
                d.this.i.a(aVar);
            }
            d.this.l.remove(aVar);
            if (d.this.l.isEmpty()) {
                d.this.i = null;
            }
        }

        @Override // com.mg.ola.a.a.b.n.b
        public void a(n nVar) {
            View view;
            float fM = nVar.m();
            c cVar = (c) d.this.l.get(nVar);
            if ((cVar.a & FrameMetricsAggregator.EVERY_DURATION) != 0 && (view = (View) d.this.b.get()) != null) {
                view.invalidate();
            }
            ArrayList<b> arrayList = cVar.b;
            if (arrayList != null) {
                int size = arrayList.size();
                for (int i = 0; i < size; i++) {
                    b bVar = arrayList.get(i);
                    d.this.b(bVar.a, bVar.b + (bVar.c * fM));
                }
            }
            View view2 = (View) d.this.b.get();
            if (view2 != null) {
                view2.invalidate();
            }
        }

        @Override // com.mg.ola.a.a.b.a.InterfaceC0079a
        public void b(com.mg.ola.a.a.b.a aVar) {
            if (d.this.i != null) {
                d.this.i.b(aVar);
            }
        }

        @Override // com.mg.ola.a.a.b.a.InterfaceC0079a
        public void c(com.mg.ola.a.a.b.a aVar) {
            if (d.this.i != null) {
                d.this.i.c(aVar);
            }
        }

        @Override // com.mg.ola.a.a.b.a.InterfaceC0079a
        public void d(com.mg.ola.a.a.b.a aVar) {
            if (d.this.i != null) {
                d.this.i.d(aVar);
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

    d(View view) {
        this.b = new WeakReference<>(view);
    }

    @TargetApi(11)
    private float a(int i) {
        View view = this.b.get();
        if (view == null) {
            return 0.0f;
        }
        if (i == 4) {
            return view.getScaleX();
        }
        if (i == 8) {
            return view.getScaleY();
        }
        if (i == 16) {
            return view.getRotation();
        }
        if (i == 32) {
            return view.getRotationX();
        }
        if (i == 64) {
            return view.getRotationY();
        }
        if (i == 128) {
            return view.getX();
        }
        if (i == 256) {
            return view.getY();
        }
        if (i == 512) {
            return view.getAlpha();
        }
        switch (i) {
            case 1:
                return view.getTranslationX();
            case 2:
                return view.getTranslationY();
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
        this.l.put(nVarB, new c(i, arrayList));
        nVarB.a((n.b) this.j);
        nVarB.a((a.InterfaceC0079a) this.j);
        if (this.f) {
            nVarB.e(this.e);
        }
        if (this.d) {
            nVarB.a(this.c);
        }
        if (this.h) {
            nVarB.a(this.g);
        }
        nVarB.a();
    }

    private void a(int i, float f) {
        float fA = a(i);
        a(i, fA, f - fA);
    }

    private void a(int i, float f, float f2) {
        if (this.l.size() > 0) {
            com.mg.ola.a.a.b.a aVar = null;
            Iterator<com.mg.ola.a.a.b.a> it2 = this.l.keySet().iterator();
            while (true) {
                if (!it2.hasNext()) {
                    break;
                }
                com.mg.ola.a.a.b.a next = it2.next();
                c cVar = this.l.get(next);
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
        View view = this.b.get();
        if (view != null) {
            view.removeCallbacks(this.k);
            view.post(this.k);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    @TargetApi(11)
    public void b(int i, float f) {
        View view = this.b.get();
        if (view != null) {
            if (i == 4) {
                view.setScaleX(f);
                return;
            }
            if (i == 8) {
                view.setScaleY(f);
                return;
            }
            if (i == 16) {
                view.setRotation(f);
                return;
            }
            if (i == 32) {
                view.setRotationX(f);
                return;
            }
            if (i == 64) {
                view.setRotationY(f);
                return;
            }
            if (i == 128) {
                view.setX(f);
                return;
            }
            if (i == 256) {
                view.setY(f);
                return;
            }
            if (i == 512) {
                view.setAlpha(f);
                return;
            }
            switch (i) {
                case 1:
                    view.setTranslationX(f);
                    break;
                case 2:
                    view.setTranslationY(f);
                    break;
            }
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
            this.d = true;
            this.c = j;
            return this;
        }
        throw new IllegalArgumentException("Animators cannot have negative duration: " + j);
    }

    @Override // com.mg.ola.a.a.c.c
    public com.mg.ola.a.a.c.c a(a.InterfaceC0079a interfaceC0079a) {
        this.i = interfaceC0079a;
        return this;
    }

    @Override // com.mg.ola.a.a.c.c
    public com.mg.ola.a.a.c.c b(float f) {
        a(512, f);
        return this;
    }
}
