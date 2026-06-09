package com.google.firebase.analytics.connector.internal;

import android.os.Bundle;
import com.google.android.gms.measurement.AppMeasurement;

/* JADX INFO: loaded from: classes2.dex */
final class zze implements AppMeasurement.OnEventListener {
    private final /* synthetic */ zzd zzbqu;

    public zze(zzd zzdVar) {
        this.zzbqu = zzdVar;
    }

    @Override // com.google.android.gms.measurement.AppMeasurement.OnEventListener
    public final void onEvent(String str, String str2, Bundle bundle, long j) {
        if (this.zzbqu.zzbqr.contains(str2)) {
            Bundle bundle2 = new Bundle();
            bundle2.putString("events", zzc.zzfi(str2));
            this.zzbqu.zzbqs.onMessageTriggered(2, bundle2);
        }
    }
}
