package com.mg.ola.common.b;

import android.content.Context;

/* JADX INFO: loaded from: classes2.dex */
public class b extends a<Integer> {
    public b(Context context, int i) {
        super(context, i);
    }

    public Integer a(Integer num) {
        return Integer.valueOf(c().getInt(a(), num.intValue()));
    }

    public void b(Integer num) {
        b().putInt(a(), num.intValue()).commit();
    }
}
