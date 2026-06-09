package com.mg.ola.common.b;

import android.content.Context;

/* JADX INFO: loaded from: classes2.dex */
public class d extends a<String> {
    public d(Context context, int i) {
        super(context, i);
    }

    public String a(String str) {
        return c().getString(a(), str);
    }

    public void b(String str) {
        b().putString(a(), str).commit();
    }
}
