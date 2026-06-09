package com.google.android.gms.ads.internal;

import java.util.concurrent.Callable;

/* JADX INFO: loaded from: classes.dex */
final class zzh implements Callable<String> {
    private final /* synthetic */ zzd zzwk;

    zzh(zzd zzdVar) {
        this.zzwk = zzdVar;
    }

    @Override // java.util.concurrent.Callable
    public final /* synthetic */ String call() {
        return this.zzwk.zzvw.zzacq.zzaa().zza(this.zzwk.zzvw.zzrt);
    }
}
