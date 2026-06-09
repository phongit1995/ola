package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzjq extends zzep {
    private final /* synthetic */ zzjt zzark;
    private final /* synthetic */ zzjp zzarq;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzjq(zzjp zzjpVar, zzhk zzhkVar, zzjt zzjtVar) {
        super(zzhkVar);
        this.zzarq = zzjpVar;
        this.zzark = zzjtVar;
    }

    @Override // com.google.android.gms.internal.measurement.zzep
    public final void run() {
        this.zzarq.cancel();
        this.zzarq.zzgi().zzjc().log("Starting upload from DelayedRunnable");
        this.zzark.zzle();
    }
}
