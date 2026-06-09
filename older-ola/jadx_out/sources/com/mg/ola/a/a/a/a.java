package com.mg.ola.a.a.a;

/* JADX INFO: loaded from: classes2.dex */
public abstract class a<T> extends c<T, Float> {
    public a(String str) {
        super(Float.class, str);
    }

    public abstract void a(T t, float f);

    @Override // com.mg.ola.a.a.a.c
    public final void a(T t, Float f) {
        a(t, f.floatValue());
    }
}
