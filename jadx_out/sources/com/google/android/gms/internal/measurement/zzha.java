package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzha implements Runnable {
    private final /* synthetic */ zzeb zzapd;
    private final /* synthetic */ zzgp zzape;
    private final /* synthetic */ zzex zzaph;

    zzha(zzgp zzgpVar, zzex zzexVar, zzeb zzebVar) {
        this.zzape = zzgpVar;
        this.zzaph = zzexVar;
        this.zzapd = zzebVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzape.zzalo.zzlj();
        this.zzape.zzalo.zzb(this.zzaph, this.zzapd);
    }
}
