package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzic implements Runnable {
    private final /* synthetic */ long zzadq;
    private final /* synthetic */ zzhm zzaps;

    zzic(zzhm zzhmVar, long j) {
        this.zzaps = zzhmVar;
        this.zzadq = j;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzaps.zzgj().zzamh.set(this.zzadq);
        this.zzaps.zzgi().zzjb().zzg("Minimum session duration set", Long.valueOf(this.zzadq));
    }
}
