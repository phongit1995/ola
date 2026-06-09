package com.google.firebase.analytics.connector.internal;

import com.google.android.gms.measurement.AppMeasurement;
import com.google.firebase.analytics.connector.AnalyticsConnector;
import java.util.HashSet;
import java.util.Set;

/* JADX INFO: loaded from: classes2.dex */
public final class zzd implements zza {
    private AppMeasurement zzbqh;
    Set<String> zzbqr;
    private AnalyticsConnector.AnalyticsConnectorListener zzbqs;
    private zze zzbqt = new zze(this);

    public zzd(AppMeasurement appMeasurement, AnalyticsConnector.AnalyticsConnectorListener analyticsConnectorListener) {
        this.zzbqs = analyticsConnectorListener;
        this.zzbqh = appMeasurement;
        this.zzbqh.registerOnMeasurementEventListener(this.zzbqt);
        this.zzbqr = new HashSet();
    }

    @Override // com.google.firebase.analytics.connector.internal.zza
    public final void registerEventNames(Set<String> set) {
        this.zzbqr.clear();
        Set<String> set2 = this.zzbqr;
        HashSet hashSet = new HashSet();
        for (String str : set) {
            if (hashSet.size() >= 50) {
                break;
            } else if (zzc.zzfh(str) && zzc.zzfg(str)) {
                hashSet.add(zzc.zzfj(str));
            }
        }
        set2.addAll(hashSet);
    }

    @Override // com.google.firebase.analytics.connector.internal.zza
    public final void unregisterEventNames() {
        this.zzbqr.clear();
    }

    @Override // com.google.firebase.analytics.connector.internal.zza
    public final AnalyticsConnector.AnalyticsConnectorListener zzss() {
        return this.zzbqs;
    }
}
