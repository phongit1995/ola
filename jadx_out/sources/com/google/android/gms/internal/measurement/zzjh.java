package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzjh implements Runnable {
    private final /* synthetic */ Runnable zzabs;
    private final /* synthetic */ zzjt zzark;

    zzjh(zzje zzjeVar, zzjt zzjtVar, Runnable runnable) {
        this.zzark = zzjtVar;
        this.zzabs = runnable;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzark.zzlj();
        this.zzark.zzg(this.zzabs);
        this.zzark.zzle();
    }
}
