package com.google.firebase.iid;

import android.content.Intent;

/* JADX INFO: loaded from: classes2.dex */
final class zzc implements Runnable {
    private final /* synthetic */ Intent zzp;
    private final /* synthetic */ Intent zzq;
    private final /* synthetic */ zzb zzr;

    zzc(zzb zzbVar, Intent intent, Intent intent2) {
        this.zzr = zzbVar;
        this.zzp = intent;
        this.zzq = intent2;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzr.zzd(this.zzp);
        this.zzr.zza(this.zzq);
    }
}
