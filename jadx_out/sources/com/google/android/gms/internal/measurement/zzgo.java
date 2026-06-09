package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzgo implements Runnable {
    private final /* synthetic */ zzhl zzaoz;
    private final /* synthetic */ zzgn zzapa;

    zzgo(zzgn zzgnVar, zzhl zzhlVar) {
        this.zzapa = zzgnVar;
        this.zzaoz = zzhlVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzapa.zza(this.zzaoz);
        this.zzapa.start();
    }
}
