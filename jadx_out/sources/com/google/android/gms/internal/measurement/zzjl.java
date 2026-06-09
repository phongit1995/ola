package com.google.android.gms.internal.measurement;

import android.support.annotation.WorkerThread;

/* JADX INFO: loaded from: classes2.dex */
final class zzjl extends zzep {
    private final /* synthetic */ zzjj zzaro;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzjl(zzjj zzjjVar, zzhk zzhkVar) {
        super(zzhkVar);
        this.zzaro = zzjjVar;
    }

    @Override // com.google.android.gms.internal.measurement.zzep
    @WorkerThread
    public final void run() {
        this.zzaro.zzkw();
    }
}
