package com.mg.ola.a.a.a;

/* JADX INFO: loaded from: classes2.dex */
public abstract class c<T, V> {
    private final String a;
    private final Class<V> b;

    public c(Class<V> cls, String str) {
        this.a = str;
        this.b = cls;
    }

    public abstract V a(T t);

    public String a() {
        return this.a;
    }

    public void a(T t, V v) {
        throw new UnsupportedOperationException("Property " + a() + " is read-only");
    }
}
