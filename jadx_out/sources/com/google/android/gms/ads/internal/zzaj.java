package com.google.android.gms.ads.internal;

import com.google.android.gms.internal.ads.zzjj;

/* JADX INFO: loaded from: classes.dex */
final class zzaj implements Runnable {
    private final /* synthetic */ zzjj zzyh;
    private final /* synthetic */ zzah zzyi;
    private final /* synthetic */ int zzyj;

    zzaj(zzah zzahVar, zzjj zzjjVar, int i) {
        this.zzyi = zzahVar;
        this.zzyh = zzjjVar;
        this.zzyj = i;
    }

    @Override // java.lang.Runnable
    public final void run() {
        synchronized (this.zzyi.mLock) {
            this.zzyi.zzb(this.zzyh, this.zzyj);
        }
    }
}
