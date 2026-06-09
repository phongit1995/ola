package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzju implements Runnable {
    private final /* synthetic */ zzjy zzasm;
    private final /* synthetic */ zzjt zzasn;

    zzju(zzjt zzjtVar, zzjy zzjyVar) {
        this.zzasn = zzjtVar;
        this.zzasm = zzjyVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzasn.zza(this.zzasm);
        this.zzasn.start();
    }
}
