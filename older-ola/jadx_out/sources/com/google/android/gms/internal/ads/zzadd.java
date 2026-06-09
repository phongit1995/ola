package com.google.android.gms.internal.ads;

import java.lang.Thread;

/* JADX INFO: loaded from: classes.dex */
final class zzadd implements Thread.UncaughtExceptionHandler {
    private final /* synthetic */ zzadb zzccb;
    private final /* synthetic */ Thread.UncaughtExceptionHandler zzccc;

    zzadd(zzadb zzadbVar, Thread.UncaughtExceptionHandler uncaughtExceptionHandler) {
        this.zzccb = zzadbVar;
        this.zzccc = uncaughtExceptionHandler;
    }

    @Override // java.lang.Thread.UncaughtExceptionHandler
    public final void uncaughtException(Thread thread, Throwable th) {
        try {
            try {
                this.zzccb.zza(thread, th);
                if (this.zzccc == null) {
                    return;
                }
            } catch (Throwable unused) {
                zzane.e("AdMob exception reporter failed reporting the exception.");
                if (this.zzccc == null) {
                    return;
                }
            }
            this.zzccc.uncaughtException(thread, th);
        } catch (Throwable th2) {
            if (this.zzccc != null) {
                this.zzccc.uncaughtException(thread, th);
            }
            throw th2;
        }
    }
}
