package com.google.android.gms.ads.internal;

import com.google.android.gms.internal.ads.zzch;
import com.google.android.gms.internal.ads.zzci;
import java.util.concurrent.Callable;

/* JADX INFO: loaded from: classes.dex */
final class zzbs implements Callable<zzci> {
    private final /* synthetic */ zzbp zzaba;

    zzbs(zzbp zzbpVar) {
        this.zzaba = zzbpVar;
    }

    @Override // java.util.concurrent.Callable
    public final /* synthetic */ zzci call() {
        return new zzci(zzch.zza(this.zzaba.zzyf.zzcw, this.zzaba.mContext, false));
    }
}
