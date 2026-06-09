package com.mg.ola.a.a.c;

import android.view.View;
import com.mg.ola.a.a.b.a;
import com.mg.ola.common.d.g;
import java.util.WeakHashMap;

/* JADX INFO: loaded from: classes2.dex */
public abstract class c {
    private static final WeakHashMap<View, c> a = new WeakHashMap<>(0);

    public static c a(View view) {
        c eVar = a.get(view);
        if (eVar == null) {
            eVar = g.f() ? new e(view) : g.c() ? new d(view) : new f(view);
            a.put(view, eVar);
        }
        return eVar;
    }

    public abstract c a(float f);

    public abstract c a(long j);

    public abstract c a(a.InterfaceC0079a interfaceC0079a);

    public abstract c b(float f);
}
