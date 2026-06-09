package com.google.android.gms.measurement;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.support.annotation.MainThread;
import android.support.v4.content.WakefulBroadcastReceiver;
import com.google.android.gms.internal.measurement.zzgd;
import com.google.android.gms.internal.measurement.zzgg;

/* JADX INFO: loaded from: classes2.dex */
public final class AppMeasurementReceiver extends WakefulBroadcastReceiver implements zzgg {
    private zzgd zzadc;

    @Override // com.google.android.gms.internal.measurement.zzgg
    public final BroadcastReceiver.PendingResult doGoAsync() {
        return goAsync();
    }

    @Override // com.google.android.gms.internal.measurement.zzgg
    @MainThread
    public final void doStartService(Context context, Intent intent) {
        startWakefulService(context, intent);
    }

    @Override // android.content.BroadcastReceiver
    @MainThread
    public final void onReceive(Context context, Intent intent) {
        if (this.zzadc == null) {
            this.zzadc = new zzgd(this);
        }
        this.zzadc.onReceive(context, intent);
    }
}
