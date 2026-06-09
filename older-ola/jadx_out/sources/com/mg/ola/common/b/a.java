package com.mg.ola.common.b;

import android.content.Context;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;

/* JADX INFO: loaded from: classes2.dex */
public abstract class a<T> {
    private String a;
    private Context b;

    public a(Context context, int i) {
        this.b = context;
        this.a = context.getString(i);
    }

    public String a() {
        return this.a;
    }

    protected SharedPreferences.Editor b() {
        return c().edit();
    }

    protected SharedPreferences c() {
        return PreferenceManager.getDefaultSharedPreferences(this.b);
    }
}
