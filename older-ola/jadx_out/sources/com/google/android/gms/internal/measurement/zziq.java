package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zziq extends zzep {
    private final /* synthetic */ zzik zzaqv;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zziq(zzik zzikVar, zzhk zzhkVar) {
        super(zzhkVar);
        this.zzaqv = zzikVar;
    }

    @Override // com.google.android.gms.internal.measurement.zzep
    public final void run() {
        this.zzaqv.zzgi().zziy().log("Tasks have been queued for a long time");
    }
}
