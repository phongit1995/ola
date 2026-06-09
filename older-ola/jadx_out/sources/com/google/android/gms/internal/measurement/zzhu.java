package com.google.android.gms.internal.measurement;

import com.google.android.gms.measurement.AppMeasurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzhu implements Runnable {
    private final /* synthetic */ zzhm zzaps;
    private final /* synthetic */ AppMeasurement.ConditionalUserProperty zzapw;

    zzhu(zzhm zzhmVar, AppMeasurement.ConditionalUserProperty conditionalUserProperty) {
        this.zzaps = zzhmVar;
        this.zzapw = conditionalUserProperty;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzaps.zzc(this.zzapw);
    }
}
