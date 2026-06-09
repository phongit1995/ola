package com.google.android.gms.internal.measurement;

import java.util.concurrent.Callable;

/* JADX INFO: loaded from: classes2.dex */
final class zzjx implements Callable<String> {
    private final /* synthetic */ zzeb zzapd;
    private final /* synthetic */ zzjt zzasn;

    zzjx(zzjt zzjtVar, zzeb zzebVar) {
        this.zzasn = zzjtVar;
        this.zzapd = zzebVar;
    }

    @Override // java.util.concurrent.Callable
    public final /* synthetic */ String call() {
        zzea zzeaVarZzg = this.zzasn.zzgk().zzbc(this.zzapd.packageName) ? this.zzasn.zzg(this.zzapd) : this.zzasn.zzjh().zzbf(this.zzapd.packageName);
        if (zzeaVarZzg != null) {
            return zzeaVarZzg.getAppInstanceId();
        }
        this.zzasn.zzgi().zziy().log("App info was null when attempting to get app instance id");
        return null;
    }
}
