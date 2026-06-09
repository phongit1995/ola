package com.google.android.gms.internal.ads;

import android.os.RemoteException;
import com.google.android.gms.measurement.AppMeasurement;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
final class zzol implements com.google.android.gms.ads.internal.gmsg.zzv<Object> {
    private final /* synthetic */ zzok zzbhr;

    zzol(zzok zzokVar) {
        this.zzbhr = zzokVar;
    }

    @Override // com.google.android.gms.ads.internal.gmsg.zzv
    public final void zza(Object obj, Map<String, String> map) {
        try {
            this.zzbhr.zzbhp = Long.valueOf(Long.parseLong(map.get(AppMeasurement.Param.TIMESTAMP)));
        } catch (NumberFormatException unused) {
            zzakb.e("Failed to call parse unconfirmedClickTimestamp.");
        }
        this.zzbhr.zzbho = map.get("id");
        String str = map.get("asset_id");
        if (this.zzbhr.zzbhm == null) {
            zzakb.zzck("Received unconfirmed click but UnconfirmedClickListener is null.");
            return;
        }
        try {
            this.zzbhr.zzbhm.onUnconfirmedClickReceived(str);
        } catch (RemoteException e) {
            zzane.zzd("#007 Could not call remote method.", e);
        }
    }
}
