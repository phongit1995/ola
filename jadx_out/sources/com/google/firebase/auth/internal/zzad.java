package com.google.firebase.auth.internal;

import android.os.Handler;
import android.os.Looper;
import android.support.annotation.NonNull;
import java.util.concurrent.Executor;

/* JADX INFO: loaded from: classes2.dex */
public final class zzad implements Executor {
    private static zzad zzly = new zzad();
    private Handler handler = new Handler(Looper.getMainLooper());

    private zzad() {
    }

    public static zzad zzbn() {
        return zzly;
    }

    @Override // java.util.concurrent.Executor
    public final void execute(@NonNull Runnable runnable) {
        this.handler.post(runnable);
    }
}
