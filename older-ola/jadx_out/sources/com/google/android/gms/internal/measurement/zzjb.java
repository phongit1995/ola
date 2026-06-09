package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzjb implements Runnable {
    private final /* synthetic */ zziy zzare;
    private final /* synthetic */ zzfa zzarf;

    zzjb(zziy zziyVar, zzfa zzfaVar) {
        this.zzare = zziyVar;
        this.zzarf = zzfaVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        synchronized (this.zzare) {
            zziy.zza(this.zzare, false);
            if (!this.zzare.zzaqv.isConnected()) {
                this.zzare.zzaqv.zzgi().zzjb().log("Connected to remote service");
                this.zzare.zzaqv.zza(this.zzarf);
            }
        }
    }
}
