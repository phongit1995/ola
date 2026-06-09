package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzeq implements Runnable {
    private final /* synthetic */ zzhk zzaha;
    private final /* synthetic */ zzep zzahb;

    zzeq(zzep zzepVar, zzhk zzhkVar) {
        this.zzahb = zzepVar;
        this.zzaha = zzhkVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzaha.zzgl();
        if (zzee.isMainThread()) {
            this.zzaha.zzgh().zzc(this);
            return;
        }
        boolean zZzef = this.zzahb.zzef();
        zzep.zza(this.zzahb, 0L);
        if (zZzef) {
            this.zzahb.run();
        }
    }
}
