package com.google.android.gms.internal.measurement;

import java.util.concurrent.Callable;

/* JADX INFO: loaded from: classes2.dex */
final class zzhc implements Callable<byte[]> {
    private final /* synthetic */ zzgp zzape;
    private final /* synthetic */ String zzapg;
    private final /* synthetic */ zzex zzaph;

    zzhc(zzgp zzgpVar, zzex zzexVar, String str) {
        this.zzape = zzgpVar;
        this.zzaph = zzexVar;
        this.zzapg = str;
    }

    @Override // java.util.concurrent.Callable
    public final /* synthetic */ byte[] call() {
        this.zzape.zzalo.zzlj();
        return this.zzape.zzalo.zza(this.zzaph, this.zzapg);
    }
}
