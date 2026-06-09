package com.mg.ola.a.a.a;

/* JADX INFO: loaded from: classes2.dex */
public abstract class b<T> extends c<T, Integer> {
    public b(String str) {
        super(Integer.class, str);
    }

    public abstract void a(T t, int i);

    @Override // com.mg.ola.a.a.a.c
    public final void a(T t, Integer num) {
        a((Object) t, Integer.valueOf(num.intValue()));
    }
}
