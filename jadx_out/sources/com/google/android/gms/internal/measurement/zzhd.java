package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzhd implements Runnable {
    private final /* synthetic */ zzeb zzapd;
    private final /* synthetic */ zzgp zzape;
    private final /* synthetic */ zzka zzapi;

    zzhd(zzgp zzgpVar, zzka zzkaVar, zzeb zzebVar) {
        this.zzape = zzgpVar;
        this.zzapi = zzkaVar;
        this.zzapd = zzebVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzape.zzalo.zzlj();
        this.zzape.zzalo.zzc(this.zzapi, this.zzapd);
    }
}
