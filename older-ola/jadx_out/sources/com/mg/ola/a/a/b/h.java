package com.mg.ola.a.a.b;

import android.view.animation.Interpolator;

/* JADX INFO: loaded from: classes2.dex */
public abstract class h implements Cloneable {
    float a;
    Class b;
    private Interpolator d = null;
    boolean c = false;

    static class a extends h {
        float d;

        a(float f) {
            this.a = f;
            this.b = Float.TYPE;
        }

        a(float f, float f2) {
            this.a = f;
            this.d = f2;
            this.b = Float.TYPE;
            this.c = true;
        }

        @Override // com.mg.ola.a.a.b.h
        public void a(Object obj) {
            if (obj == null || obj.getClass() != Float.class) {
                return;
            }
            this.d = ((Float) obj).floatValue();
            this.c = true;
        }

        @Override // com.mg.ola.a.a.b.h
        public Object b() {
            return Float.valueOf(this.d);
        }

        public float f() {
            return this.d;
        }

        @Override // com.mg.ola.a.a.b.h
        /* JADX INFO: renamed from: g, reason: merged with bridge method [inline-methods] and merged with bridge method [inline-methods] */
        public a e() {
            a aVar = new a(c(), this.d);
            aVar.a(d());
            return aVar;
        }
    }

    static class b extends h {
        int d;

        b(float f) {
            this.a = f;
            this.b = Integer.TYPE;
        }

        b(float f, int i) {
            this.a = f;
            this.d = i;
            this.b = Integer.TYPE;
            this.c = true;
        }

        @Override // com.mg.ola.a.a.b.h
        public void a(Object obj) {
            if (obj == null || obj.getClass() != Integer.class) {
                return;
            }
            this.d = ((Integer) obj).intValue();
            this.c = true;
        }

        @Override // com.mg.ola.a.a.b.h
        public Object b() {
            return Integer.valueOf(this.d);
        }

        public int f() {
            return this.d;
        }

        @Override // com.mg.ola.a.a.b.h
        /* JADX INFO: renamed from: g, reason: merged with bridge method [inline-methods] */
        public b e() {
            b bVar = new b(c(), this.d);
            bVar.a(d());
            return bVar;
        }
    }

    public static h a(float f) {
        return new b(f);
    }

    public static h a(float f, float f2) {
        return new a(f, f2);
    }

    public static h a(float f, int i) {
        return new b(f, i);
    }

    public static h b(float f) {
        return new a(f);
    }

    public void a(Interpolator interpolator) {
        this.d = interpolator;
    }

    public abstract void a(Object obj);

    public boolean a() {
        return this.c;
    }

    public abstract Object b();

    public float c() {
        return this.a;
    }

    public Interpolator d() {
        return this.d;
    }

    @Override // 
    public abstract h e();
}
