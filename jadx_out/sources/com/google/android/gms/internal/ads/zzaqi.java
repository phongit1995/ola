package com.google.android.gms.internal.ads;

import android.support.v4.app.NotificationCompat;
import com.facebook.appevents.AppEventsConstants;
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
final class zzaqi implements Runnable {
    private final /* synthetic */ String zzcce;
    private final /* synthetic */ String zzdba;
    private final /* synthetic */ int zzdbb;
    private final /* synthetic */ int zzdbc;
    private final /* synthetic */ boolean zzdbd = false;
    private final /* synthetic */ zzaqh zzdbe;

    zzaqi(zzaqh zzaqhVar, String str, String str2, int i, int i2, boolean z) {
        this.zzdbe = zzaqhVar;
        this.zzcce = str;
        this.zzdba = str2;
        this.zzdbb = i;
        this.zzdbc = i2;
    }

    @Override // java.lang.Runnable
    public final void run() {
        HashMap map = new HashMap();
        map.put(NotificationCompat.CATEGORY_EVENT, "precacheProgress");
        map.put("src", this.zzcce);
        map.put("cachedSrc", this.zzdba);
        map.put("bytesLoaded", Integer.toString(this.zzdbb));
        map.put("totalBytes", Integer.toString(this.zzdbc));
        map.put("cacheReady", this.zzdbd ? "1" : AppEventsConstants.EVENT_PARAM_VALUE_NO);
        this.zzdbe.zza("onPrecacheEvent", (Map<String, String>) map);
    }
}
