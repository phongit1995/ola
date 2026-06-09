package com.google.firebase.auth.api.internal;

/* JADX INFO: loaded from: classes2.dex */
final class zzdg implements Runnable {
    private final /* synthetic */ zzdh zzja;
    private final /* synthetic */ zzdb zzjb;

    zzdg(zzdb zzdbVar, zzdh zzdhVar) {
        this.zzjb = zzdbVar;
        this.zzja = zzdhVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        synchronized (this.zzjb.zziw.zzih) {
            if (!this.zzjb.zziw.zzih.isEmpty()) {
                this.zzja.zza(this.zzjb.zziw.zzih.get(0), new Object[0]);
            }
        }
    }
}
