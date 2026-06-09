package com.google.android.gms.internal.ads;

import java.lang.Thread;

/* JADX INFO: loaded from: classes.dex */
final class zzadc implements Thread.UncaughtExceptionHandler {
    private final /* synthetic */ Thread.UncaughtExceptionHandler zzcca;
    private final /* synthetic */ zzadb zzccb;

    zzadc(zzadb zzadbVar, Thread.UncaughtExceptionHandler uncaughtExceptionHandler) {
        this.zzccb = zzadbVar;
        this.zzcca = uncaughtExceptionHandler;
    }

    @Override // java.lang.Thread.UncaughtExceptionHandler
    public final void uncaughtException(Thread thread, Throwable th) {
        try {
            try {
                this.zzccb.zza(thread, th);
                if (this.zzcca == null) {
                    return;
                }
            } catch (Throwable unused) {
                zzane.e("AdMob exception reporter failed reporting the exception.");
                if (this.zzcca == null) {
                    return;
                }
            }
            this.zzcca.uncaughtException(thread, th);
        } catch (Throwable th2) {
            if (this.zzcca != null) {
                this.zzcca.uncaughtException(thread, th);
            }
            throw th2;
        }
    }
}
