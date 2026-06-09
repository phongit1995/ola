package com.google.android.gms.ads.internal.gmsg;

import android.os.Bundle;
import com.google.android.gms.internal.ads.zzadh;
import com.google.android.gms.internal.ads.zzakb;
import java.util.Iterator;
import java.util.Map;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zza implements zzv<Object> {
    private final zzb zzbll;

    public zza(zzb zzbVar) {
        this.zzbll = zzbVar;
    }

    private static Bundle zzar(String str) {
        if (str == null) {
            return null;
        }
        try {
            JSONObject jSONObject = new JSONObject(str);
            Iterator<String> itKeys = jSONObject.keys();
            Bundle bundle = new Bundle();
            while (itKeys.hasNext()) {
                String next = itKeys.next();
                Object obj = jSONObject.get(next);
                if (obj != null) {
                    if (obj instanceof Boolean) {
                        bundle.putBoolean(next, ((Boolean) obj).booleanValue());
                    } else if (obj instanceof Double) {
                        bundle.putDouble(next, ((Double) obj).doubleValue());
                    } else if (obj instanceof Integer) {
                        bundle.putInt(next, ((Integer) obj).intValue());
                    } else if (obj instanceof Long) {
                        bundle.putLong(next, ((Long) obj).longValue());
                    } else if (obj instanceof String) {
                        bundle.putString(next, (String) obj);
                    } else {
                        String strValueOf = String.valueOf(next);
                        zzakb.zzdk(strValueOf.length() != 0 ? "Unsupported type for key:".concat(strValueOf) : new String("Unsupported type for key:"));
                    }
                }
            }
            return bundle;
        } catch (JSONException e) {
            zzakb.zzb("Failed to convert ad metadata to JSON.", e);
            return null;
        }
    }

    @Override // com.google.android.gms.ads.internal.gmsg.zzv
    public final void zza(Object obj, Map<String, String> map) {
        if (this.zzbll == null) {
            return;
        }
        String str = map.get("name");
        if (str == null) {
            zzakb.zzdj("Ad metadata with no name parameter.");
            str = "";
        }
        Bundle bundleZzar = zzar(map.get("info"));
        if (bundleZzar == null) {
            zzakb.e("Failed to convert ad metadata to Bundle.");
        } else {
            this.zzbll.zza(str, bundleZzar);
        }
    }
}
