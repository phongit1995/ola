package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzgu implements Runnable {
    private final /* synthetic */ zzgp zzape;
    private final /* synthetic */ zzef zzapf;

    zzgu(zzgp zzgpVar, zzef zzefVar) {
        this.zzape = zzgpVar;
        this.zzapf = zzefVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzape.zzalo.zzlj();
        this.zzape.zzalo.zze(this.zzapf);
    }
}
