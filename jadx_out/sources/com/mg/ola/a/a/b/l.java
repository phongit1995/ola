package com.mg.ola.a.a.b;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.concurrent.locks.ReentrantReadWriteLock;

/* JADX INFO: loaded from: classes2.dex */
public class l implements Cloneable {
    private static final m i = new f();
    private static final m j = new d();
    private static Class[] k = {Float.TYPE, Float.class, Double.TYPE, Integer.TYPE, Double.class, Integer.class};
    private static Class[] l = {Integer.TYPE, Integer.class, Float.TYPE, Double.TYPE, Float.class, Double.class};
    private static Class[] m = {Double.TYPE, Double.class, Float.TYPE, Integer.TYPE, Float.class, Integer.class};
    private static final HashMap<Class, HashMap<String, Method>> n = new HashMap<>();
    private static final HashMap<Class, HashMap<String, Method>> o = new HashMap<>();
    String a;
    protected com.mg.ola.a.a.a.c b;
    Method c;
    Class d;
    i e;
    final ReentrantReadWriteLock f;
    final Object[] g;
    private Method h;
    private m p;
    private Object q;

    static class a extends l {
        e h;
        float i;
        private com.mg.ola.a.a.a.a j;

        public a(com.mg.ola.a.a.a.c cVar, float... fArr) {
            super(cVar);
            a(fArr);
            if (cVar instanceof com.mg.ola.a.a.a.a) {
                this.j = (com.mg.ola.a.a.a.a) this.b;
            }
        }

        public a(String str, float... fArr) {
            super(str);
            a(fArr);
        }

        @Override // com.mg.ola.a.a.b.l
        void a(float f) {
            this.i = this.h.b(f);
        }

        @Override // com.mg.ola.a.a.b.l
        void a(Class cls) {
            if (this.b != null) {
                return;
            }
            super.a(cls);
        }

        @Override // com.mg.ola.a.a.b.l
        public void a(float... fArr) {
            super.a(fArr);
            this.h = (e) this.e;
        }

        @Override // com.mg.ola.a.a.b.l
        void b(Object obj) {
            if (this.j != null) {
                this.j.a(obj, this.i);
                return;
            }
            if (this.b != null) {
                this.b.a(obj, Float.valueOf(this.i));
                return;
            }
            if (this.c != null) {
                try {
                    this.g[0] = Float.valueOf(this.i);
                    this.c.invoke(obj, this.g);
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        }

        @Override // com.mg.ola.a.a.b.l
        Object d() {
            return Float.valueOf(this.i);
        }

        @Override // com.mg.ola.a.a.b.l
        /* JADX INFO: renamed from: e, reason: merged with bridge method [inline-methods] and merged with bridge method [inline-methods] */
        public a clone() {
            a aVar = (a) super.clone();
            aVar.h = (e) aVar.e;
            return aVar;
        }
    }

    static class b extends l {
        g h;
        int i;
        private com.mg.ola.a.a.a.b j;

        public b(com.mg.ola.a.a.a.c cVar, int... iArr) {
            super(cVar);
            a(iArr);
            if (cVar instanceof com.mg.ola.a.a.a.b) {
                this.j = (com.mg.ola.a.a.a.b) this.b;
            }
        }

        public b(String str, int... iArr) {
            super(str);
            a(iArr);
        }

        @Override // com.mg.ola.a.a.b.l
        void a(float f) {
            this.i = this.h.b(f);
        }

        @Override // com.mg.ola.a.a.b.l
        void a(Class cls) {
            if (this.b != null) {
                return;
            }
            super.a(cls);
        }

        @Override // com.mg.ola.a.a.b.l
        public void a(int... iArr) {
            super.a(iArr);
            this.h = (g) this.e;
        }

        @Override // com.mg.ola.a.a.b.l
        void b(Object obj) {
            if (this.j != null) {
                this.j.a(obj, this.i);
                return;
            }
            if (this.b != null) {
                this.b.a(obj, Integer.valueOf(this.i));
                return;
            }
            if (this.c != null) {
                try {
                    this.g[0] = Integer.valueOf(this.i);
                    this.c.invoke(obj, this.g);
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        }

        @Override // com.mg.ola.a.a.b.l
        Object d() {
            return Integer.valueOf(this.i);
        }

        @Override // com.mg.ola.a.a.b.l
        /* JADX INFO: renamed from: e, reason: merged with bridge method [inline-methods] */
        public b clone() {
            b bVar = (b) super.clone();
            bVar.h = (g) bVar.e;
            return bVar;
        }
    }

    private l(com.mg.ola.a.a.a.c cVar) {
        this.c = null;
        this.h = null;
        this.e = null;
        this.f = new ReentrantReadWriteLock();
        this.g = new Object[1];
        this.b = cVar;
        if (cVar != null) {
            this.a = cVar.a();
        }
    }

    private l(String str) {
        this.c = null;
        this.h = null;
        this.e = null;
        this.f = new ReentrantReadWriteLock();
        this.g = new Object[1];
        this.a = str;
    }

    public static l a(com.mg.ola.a.a.a.c<?, Float> cVar, float... fArr) {
        return new a(cVar, fArr);
    }

    public static l a(com.mg.ola.a.a.a.c<?, Integer> cVar, int... iArr) {
        return new b(cVar, iArr);
    }

    public static l a(String str, float... fArr) {
        return new a(str, fArr);
    }

    public static l a(String str, int... iArr) {
        return new b(str, iArr);
    }

    static String a(String str, String str2) {
        if (str2 == null || str2.length() == 0) {
            return str;
        }
        return str + Character.toUpperCase(str2.charAt(0)) + str2.substring(1);
    }

    private Method a(Class cls, String str, Class cls2) {
        Method declaredMethod;
        Method method;
        String strA = a(str, this.a);
        if (cls2 == null) {
            try {
                try {
                    return cls.getMethod(strA, null);
                } catch (NoSuchMethodException unused) {
                    declaredMethod = cls.getDeclaredMethod(strA, null);
                    try {
                        declaredMethod.setAccessible(true);
                    } catch (Throwable th) {
                        th = th;
                        th.printStackTrace();
                        return declaredMethod;
                    }
                    return declaredMethod;
                }
            } catch (Throwable th2) {
                th = th2;
                declaredMethod = null;
                th.printStackTrace();
                return declaredMethod;
            }
        }
        Class<?>[] clsArr = new Class[1];
        Method method2 = null;
        for (Class<?> cls3 : this.d.equals(Float.class) ? k : this.d.equals(Integer.class) ? l : this.d.equals(Double.class) ? m : new Class[]{this.d}) {
            clsArr[0] = cls3;
            try {
                method = cls.getMethod(strA, clsArr);
            } catch (NoSuchMethodException unused2) {
            }
            try {
                this.d = cls3;
                return method;
            } catch (NoSuchMethodException unused3) {
                method2 = method;
                try {
                    Method declaredMethod2 = cls.getDeclaredMethod(strA, clsArr);
                    try {
                        declaredMethod2.setAccessible(true);
                        this.d = cls3;
                        return declaredMethod2;
                    } catch (NoSuchMethodException unused4) {
                        method2 = declaredMethod2;
                    }
                } catch (NoSuchMethodException unused5) {
                }
            }
        }
        return method2;
    }

    private Method a(Class cls, HashMap<Class, HashMap<String, Method>> map, String str, Class cls2) {
        try {
            this.f.writeLock().lock();
            HashMap<String, Method> map2 = map.get(cls);
            Method methodA = map2 != null ? map2.get(this.a) : null;
            if (methodA == null) {
                methodA = a(cls, str, cls2);
                if (map2 == null) {
                    map2 = new HashMap<>();
                    map.put(cls, map2);
                }
                map2.put(this.a, methodA);
            }
            return methodA;
        } finally {
            this.f.writeLock().unlock();
        }
    }

    private void b(Class cls) {
        this.h = a(cls, o, "get", null);
    }

    @Override // 
    /* JADX INFO: renamed from: a */
    public l clone() {
        try {
            l lVar = (l) super.clone();
            lVar.a = this.a;
            lVar.b = this.b;
            lVar.e = this.e.clone();
            lVar.p = this.p;
            return lVar;
        } catch (CloneNotSupportedException unused) {
            return null;
        }
    }

    void a(float f) {
        this.q = this.e.a(f);
    }

    public void a(com.mg.ola.a.a.a.c cVar) {
        this.b = cVar;
    }

    void a(Class cls) {
        this.c = a(cls, n, "set", this.d);
    }

    void a(Object obj) {
        if (this.b != null) {
            try {
                this.b.a(obj);
                for (h hVar : this.e.e) {
                    if (!hVar.a()) {
                        hVar.a(this.b.a(obj));
                    }
                }
                return;
            } catch (Throwable th) {
                this.b = null;
                th.printStackTrace();
            }
        }
        Class<?> cls = obj.getClass();
        if (this.c == null) {
            a((Class) cls);
        }
        for (h hVar2 : this.e.e) {
            if (!hVar2.a()) {
                if (this.h == null) {
                    b((Class) cls);
                }
                try {
                    hVar2.a(this.h.invoke(obj, new Object[0]));
                } catch (Throwable th2) {
                    th2.printStackTrace();
                }
            }
        }
    }

    public void a(String str) {
        this.a = str;
    }

    public void a(float... fArr) {
        this.d = Float.TYPE;
        this.e = i.a(fArr);
    }

    public void a(int... iArr) {
        this.d = Integer.TYPE;
        this.e = i.a(iArr);
    }

    void b() {
        if (this.p == null) {
            this.p = this.d == Integer.class ? i : this.d == Float.class ? j : null;
        }
        if (this.p != null) {
            this.e.a(this.p);
        }
    }

    void b(Object obj) {
        if (this.b != null) {
            this.b.a(obj, d());
        }
        if (this.c != null) {
            try {
                this.g[0] = d();
                this.c.invoke(obj, this.g);
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
    }

    public String c() {
        return this.a;
    }

    Object d() {
        return this.q;
    }

    public String toString() {
        return this.a + ": " + this.e.toString();
    }
}
