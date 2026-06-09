package com.mg.ola.common.b;

import android.content.Context;

/* JADX INFO: loaded from: classes2.dex */
public class c extends a<Long> {
    public c(Context context, int i) {
        super(context, i);
    }

    public Long a(Long l) {
        return Long.valueOf(c().getLong(a(), l.longValue()));
    }

    public void b(Long l) {
        b().putLong(a(), l.longValue()).commit();
    }
}
