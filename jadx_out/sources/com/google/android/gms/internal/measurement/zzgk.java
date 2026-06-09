package com.google.android.gms.internal.measurement;

import com.google.android.gms.common.internal.Preconditions;
import java.lang.Thread;

/* JADX INFO: loaded from: classes2.dex */
final class zzgk implements Thread.UncaughtExceptionHandler {
    private final String zzanw;
    private final /* synthetic */ zzgi zzanx;

    public zzgk(zzgi zzgiVar, String str) {
        this.zzanx = zzgiVar;
        Preconditions.checkNotNull(str);
        this.zzanw = str;
    }

    @Override // java.lang.Thread.UncaughtExceptionHandler
    public final synchronized void uncaughtException(Thread thread, Throwable th) {
        this.zzanx.zzgi().zziv().zzg(this.zzanw, th);
    }
}
