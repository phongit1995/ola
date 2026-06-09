package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzhg implements Runnable {
    private final /* synthetic */ zzeb zzapd;
    private final /* synthetic */ zzgp zzape;

    zzhg(zzgp zzgpVar, zzeb zzebVar) {
        this.zzape = zzgpVar;
        this.zzapd = zzebVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzape.zzalo.zzlj();
        this.zzape.zzalo.zzf(this.zzapd);
    }
}
