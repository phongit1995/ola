package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzhb implements Runnable {
    private final /* synthetic */ zzgp zzape;
    private final /* synthetic */ String zzapg;
    private final /* synthetic */ zzex zzaph;

    zzhb(zzgp zzgpVar, zzex zzexVar, String str) {
        this.zzape = zzgpVar;
        this.zzaph = zzexVar;
        this.zzapg = str;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzape.zzalo.zzlj();
        this.zzape.zzalo.zzc(this.zzaph, this.zzapg);
    }
}
