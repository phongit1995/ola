package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzdw implements Runnable {
    private final /* synthetic */ String zzadr;
    private final /* synthetic */ long zzaex;
    private final /* synthetic */ zzdu zzaey;

    zzdw(zzdu zzduVar, String str, long j) {
        this.zzaey = zzduVar;
        this.zzadr = str;
        this.zzaex = j;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzaey.zzb(this.zzadr, this.zzaex);
    }
}
