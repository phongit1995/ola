package com.google.android.gms.ads.internal;

import com.google.android.gms.internal.ads.zzjj;

/* JADX INFO: loaded from: classes.dex */
final class zzai implements Runnable {
    private final /* synthetic */ zzjj zzyh;
    private final /* synthetic */ zzah zzyi;

    zzai(zzah zzahVar, zzjj zzjjVar) {
        this.zzyi = zzahVar;
        this.zzyh = zzjjVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        synchronized (this.zzyi.mLock) {
            if (this.zzyi.zzde()) {
                this.zzyi.zze(this.zzyh);
            } else {
                this.zzyi.zzb(this.zzyh, 1);
            }
        }
    }
}
