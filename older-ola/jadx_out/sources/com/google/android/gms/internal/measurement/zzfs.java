package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzfs implements Runnable {
    private final /* synthetic */ boolean zzalp;
    private final /* synthetic */ zzfr zzalq;

    zzfs(zzfr zzfrVar, boolean z) {
        this.zzalq = zzfrVar;
        this.zzalp = z;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzalq.zzalo.zzm(this.zzalp);
    }
}
