package com.google.android.gms.ads.internal.gmsg;

import android.content.Context;
import android.support.annotation.Keep;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import com.google.android.gms.common.annotation.KeepName;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.internal.ads.zzadh;
import com.google.android.gms.internal.ads.zzakb;
import com.google.android.gms.internal.ads.zzaki;
import com.google.android.gms.internal.ads.zzang;
import com.google.android.gms.internal.ads.zzue;
import com.google.firebase.analytics.FirebaseAnalytics;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@Keep
@KeepName
@zzadh
public class HttpClient implements zzv<zzue> {
    private final Context mContext;
    private final zzang zzyf;

    @VisibleForTesting
    @zzadh
    static class zza {
        private final String mKey;
        private final String mValue;

        public zza(String str, String str2) {
            this.mKey = str;
            this.mValue = str2;
        }

        public final String getKey() {
            return this.mKey;
        }

        public final String getValue() {
            return this.mValue;
        }
    }

    @VisibleForTesting
    @zzadh
    static class zzb {
        private final String zzbmm;
        private final URL zzbmn;
        private final ArrayList<zza> zzbmo;
        private final String zzbmp;

        zzb(String str, URL url, ArrayList<zza> arrayList, String str2) {
            this.zzbmm = str;
            this.zzbmn = url;
            this.zzbmo = arrayList;
            this.zzbmp = str2;
        }

        public final String zzkv() {
            return this.zzbmm;
        }

        public final URL zzkw() {
            return this.zzbmn;
        }

        public final ArrayList<zza> zzkx() {
            return this.zzbmo;
        }

        public final String zzky() {
            return this.zzbmp;
        }
    }

    @VisibleForTesting
    @zzadh
    class zzc {
        private final zzd zzbmq;
        private final boolean zzbmr;
        private final String zzbms;

        public zzc(HttpClient httpClient, boolean z, zzd zzdVar, String str) {
            this.zzbmr = z;
            this.zzbmq = zzdVar;
            this.zzbms = str;
        }

        public final String getReason() {
            return this.zzbms;
        }

        public final boolean isSuccess() {
            return this.zzbmr;
        }

        public final zzd zzkz() {
            return this.zzbmq;
        }
    }

    @VisibleForTesting
    @zzadh
    static class zzd {
        private final String zzbhy;
        private final String zzbmm;
        private final int zzbmt;
        private final List<zza> zzcf;

        zzd(String str, int i, List<zza> list, String str2) {
            this.zzbmm = str;
            this.zzbmt = i;
            this.zzcf = list;
            this.zzbhy = str2;
        }

        public final String getBody() {
            return this.zzbhy;
        }

        public final int getResponseCode() {
            return this.zzbmt;
        }

        public final String zzkv() {
            return this.zzbmm;
        }

        public final Iterable<zza> zzla() {
            return this.zzcf;
        }
    }

    public HttpClient(Context context, zzang zzangVar) {
        this.mContext = context;
        this.zzyf = zzangVar;
    }

    /* JADX WARN: Removed duplicated region for block: B:36:0x0104  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final com.google.android.gms.ads.internal.gmsg.HttpClient.zzc zza(com.google.android.gms.ads.internal.gmsg.HttpClient.zzb r13) throws java.lang.Throwable {
        /*
            Method dump skipped, instruction units count: 264
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.ads.internal.gmsg.HttpClient.zza(com.google.android.gms.ads.internal.gmsg.HttpClient$zzb):com.google.android.gms.ads.internal.gmsg.HttpClient$zzc");
    }

    private static JSONObject zza(zzd zzdVar) {
        JSONObject jSONObject = new JSONObject();
        try {
            jSONObject.put("http_request_id", zzdVar.zzkv());
            if (zzdVar.getBody() != null) {
                jSONObject.put(AccountKitGraphConstants.BODY_KEY, zzdVar.getBody());
            }
            JSONArray jSONArray = new JSONArray();
            for (zza zzaVar : zzdVar.zzla()) {
                jSONArray.put(new JSONObject().put("key", zzaVar.getKey()).put(FirebaseAnalytics.Param.VALUE, zzaVar.getValue()));
            }
            jSONObject.put("headers", jSONArray);
            jSONObject.put("response_code", zzdVar.getResponseCode());
            return jSONObject;
        } catch (JSONException e) {
            zzakb.zzb("Error constructing JSON for http response.", e);
            return jSONObject;
        }
    }

    private static zzb zzc(JSONObject jSONObject) {
        String strOptString = jSONObject.optString("http_request_id");
        String strOptString2 = jSONObject.optString("url");
        URL url = null;
        String strOptString3 = jSONObject.optString("post_body", null);
        try {
            url = new URL(strOptString2);
        } catch (MalformedURLException e) {
            zzakb.zzb("Error constructing http request.", e);
        }
        ArrayList arrayList = new ArrayList();
        JSONArray jSONArrayOptJSONArray = jSONObject.optJSONArray("headers");
        if (jSONArrayOptJSONArray == null) {
            jSONArrayOptJSONArray = new JSONArray();
        }
        for (int i = 0; i < jSONArrayOptJSONArray.length(); i++) {
            JSONObject jSONObjectOptJSONObject = jSONArrayOptJSONArray.optJSONObject(i);
            if (jSONObjectOptJSONObject != null) {
                arrayList.add(new zza(jSONObjectOptJSONObject.optString("key"), jSONObjectOptJSONObject.optString(FirebaseAnalytics.Param.VALUE)));
            }
        }
        return new zzb(strOptString, url, arrayList, strOptString3);
    }

    @Keep
    @KeepName
    public JSONObject send(JSONObject jSONObject) throws Throwable {
        String strOptString;
        JSONObject jSONObject2 = new JSONObject();
        try {
            strOptString = jSONObject.optString("http_request_id");
            try {
                zzc zzcVarZza = zza(zzc(jSONObject));
                if (zzcVarZza.isSuccess()) {
                    jSONObject2.put("response", zza(zzcVarZza.zzkz()));
                    jSONObject2.put("success", true);
                    return jSONObject2;
                }
                jSONObject2.put("response", new JSONObject().put("http_request_id", strOptString));
                jSONObject2.put("success", false);
                jSONObject2.put("reason", zzcVarZza.getReason());
                return jSONObject2;
            } catch (Exception e) {
                e = e;
                zzakb.zzb("Error executing http request.", e);
                try {
                    jSONObject2.put("response", new JSONObject().put("http_request_id", strOptString));
                    jSONObject2.put("success", false);
                    jSONObject2.put("reason", e.toString());
                    return jSONObject2;
                } catch (JSONException e2) {
                    zzakb.zzb("Error executing http request.", e2);
                    return jSONObject2;
                }
            }
        } catch (Exception e3) {
            e = e3;
            strOptString = "";
        }
    }

    @Override // com.google.android.gms.ads.internal.gmsg.zzv
    public final /* synthetic */ void zza(zzue zzueVar, Map map) {
        zzaki.zzb(new zzw(this, map, zzueVar));
    }
}
