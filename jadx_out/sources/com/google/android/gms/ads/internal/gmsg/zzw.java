package com.google.android.gms.ads.internal.gmsg;

import com.google.android.gms.internal.ads.zzakb;
import com.google.android.gms.internal.ads.zzakk;
import com.google.android.gms.internal.ads.zzue;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
final class zzw implements Runnable {
    private final /* synthetic */ Map zzbmh;
    final /* synthetic */ zzue zzbmi;
    private final /* synthetic */ HttpClient zzbmj;

    zzw(HttpClient httpClient, Map map, zzue zzueVar) {
        this.zzbmj = httpClient;
        this.zzbmh = map;
        this.zzbmi = zzueVar;
    }

    @Override // java.lang.Runnable
    public final void run() throws Throwable {
        zzakb.zzck("Received Http request.");
        try {
            JSONObject jSONObjectSend = this.zzbmj.send(new JSONObject((String) this.zzbmh.get("http_request")));
            if (jSONObjectSend == null) {
                zzakb.e("Response should not be null.");
            } else {
                zzakk.zzcrm.post(new zzx(this, jSONObjectSend));
            }
        } catch (Exception e) {
            zzakb.zzb("Error converting request to json.", e);
        }
    }
}
