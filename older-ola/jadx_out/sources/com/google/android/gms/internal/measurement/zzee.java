package com.google.android.gms.internal.measurement;

import android.content.Context;
import android.os.Looper;

/* JADX INFO: loaded from: classes2.dex */
public final class zzee {
    private final boolean zzagd = false;

    zzee(Context context) {
    }

    public static boolean isMainThread() {
        return Looper.myLooper() == Looper.getMainLooper();
    }
}
