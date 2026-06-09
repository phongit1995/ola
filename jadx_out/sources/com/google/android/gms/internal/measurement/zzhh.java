package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzhh implements Runnable {
    private final /* synthetic */ String zzaem;
    private final /* synthetic */ zzgp zzape;
    private final /* synthetic */ String zzapg;
    private final /* synthetic */ String zzapj;
    private final /* synthetic */ long zzapk;

    zzhh(zzgp zzgpVar, String str, String str2, String str3, long j) {
        this.zzape = zzgpVar;
        this.zzapj = str;
        this.zzapg = str2;
        this.zzaem = str3;
        this.zzapk = j;
    }

    @Override // java.lang.Runnable
    public final void run() {
        if (this.zzapj == null) {
            this.zzape.zzalo.zzlm().zzgb().zza(this.zzapg, (zzig) null);
        } else {
            this.zzape.zzalo.zzlm().zzgb().zza(this.zzapg, new zzig(this.zzaem, this.zzapj, this.zzapk));
        }
    }
}
