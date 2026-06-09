package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzge implements Runnable {
    private final /* synthetic */ zzgn zzana;
    private final /* synthetic */ zzfi zzanb;

    zzge(zzgd zzgdVar, zzgn zzgnVar, zzfi zzfiVar) {
        this.zzana = zzgnVar;
        this.zzanb = zzfiVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        if (this.zzana.zzjz() == null) {
            this.zzanb.zziv().log("Install Referrer Reporter is null");
        } else {
            this.zzana.zzjz().zzjr();
        }
    }
}
