package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzij implements Runnable {
    private final /* synthetic */ zzih zzaqm;
    private final /* synthetic */ zzig zzaqn;

    zzij(zzih zzihVar, zzig zzigVar) {
        this.zzaqm = zzihVar;
        this.zzaqn = zzigVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzaqm.zza(this.zzaqn);
        this.zzaqm.zzaqd = null;
        this.zzaqm.zzga().zzb((zzig) null);
    }
}
