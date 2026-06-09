package com.google.android.gms.internal.measurement;

import java.util.List;
import java.util.concurrent.Callable;

/* JADX INFO: loaded from: classes2.dex */
final class zzhf implements Callable<List<zzkc>> {
    private final /* synthetic */ zzeb zzapd;
    private final /* synthetic */ zzgp zzape;

    zzhf(zzgp zzgpVar, zzeb zzebVar) {
        this.zzape = zzgpVar;
        this.zzapd = zzebVar;
    }

    @Override // java.util.concurrent.Callable
    public final /* synthetic */ List<zzkc> call() {
        this.zzape.zzalo.zzlj();
        return this.zzape.zzalo.zzjh().zzbe(this.zzapd.packageName);
    }
}
