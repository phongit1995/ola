package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzjm implements Runnable {
    private final /* synthetic */ long zzaex;
    private final /* synthetic */ zzjj zzaro;

    zzjm(zzjj zzjjVar, long j) {
        this.zzaro = zzjjVar;
        this.zzaex = j;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzaro.zzak(this.zzaex);
    }
}
