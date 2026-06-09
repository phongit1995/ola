package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzgz implements Runnable {
    private final /* synthetic */ zzeb zzapd;
    private final /* synthetic */ zzgp zzape;

    zzgz(zzgp zzgpVar, zzeb zzebVar) {
        this.zzape = zzgpVar;
        this.zzapd = zzebVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzape.zzalo.zzlj();
        this.zzape.zzalo.zzd(this.zzapd);
    }
}
