package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzgs implements Runnable {
    private final /* synthetic */ zzeb zzapd;
    private final /* synthetic */ zzgp zzape;
    private final /* synthetic */ zzef zzapf;

    zzgs(zzgp zzgpVar, zzef zzefVar, zzeb zzebVar) {
        this.zzape = zzgpVar;
        this.zzapf = zzefVar;
        this.zzapd = zzebVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzape.zzalo.zzlj();
        this.zzape.zzalo.zzb(this.zzapf, this.zzapd);
    }
}
