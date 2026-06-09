package com.google.android.gms.internal.measurement;

import android.content.ComponentName;
import android.content.Context;

/* JADX INFO: loaded from: classes2.dex */
final class zzjc implements Runnable {
    private final /* synthetic */ zziy zzare;

    zzjc(zziy zziyVar) {
        this.zzare = zziyVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        zzik zzikVar = this.zzare.zzaqv;
        Context context = this.zzare.zzaqv.getContext();
        this.zzare.zzaqv.zzgl();
        zzikVar.onServiceDisconnected(new ComponentName(context, "com.google.android.gms.measurement.AppMeasurementService"));
    }
}
