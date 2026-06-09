package com.google.firebase.auth.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.util.ArrayMap;
import android.text.TextUtils;
import android.util.Log;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.logging.Logger;
import com.google.android.gms.common.util.Base64Utils;
import com.google.android.gms.common.util.VisibleForTesting;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes2.dex */
final class zzz {
    private static final Logger zzdx = new Logger("JSONParser", new String[0]);

    @VisibleForTesting
    private static List<Object> zza(JSONArray jSONArray) throws JSONException {
        ArrayList arrayList = new ArrayList();
        for (int i = 0; i < jSONArray.length(); i++) {
            Object objZzb = jSONArray.get(i);
            if (objZzb instanceof JSONArray) {
                objZzb = zza((JSONArray) objZzb);
            } else if (objZzb instanceof JSONObject) {
                objZzb = zzb((JSONObject) objZzb);
            }
            arrayList.add(objZzb);
        }
        return arrayList;
    }

    @NonNull
    public static Map<String, Object> zzah(@NonNull String str) {
        Preconditions.checkNotEmpty(str);
        String[] strArrSplit = str.split("\\.");
        if (strArrSplit.length < 2) {
            Logger logger = zzdx;
            String strValueOf = String.valueOf(str);
            logger.e(strValueOf.length() != 0 ? "Invalid idToken ".concat(strValueOf) : new String("Invalid idToken "), new Object[0]);
        } else {
            try {
                Map<String, Object> mapZzai = zzai(new String(Base64Utils.decodeUrlSafeNoPadding(strArrSplit[1]), "UTF-8"));
                return mapZzai == null ? Collections.EMPTY_MAP : mapZzai;
            } catch (UnsupportedEncodingException e) {
                zzdx.e("Unable to decode token", e, new Object[0]);
            }
        }
        return Collections.EMPTY_MAP;
    }

    @Nullable
    public static Map<String, Object> zzai(String str) {
        if (TextUtils.isEmpty(str)) {
            return null;
        }
        try {
            JSONObject jSONObject = new JSONObject(str);
            if (jSONObject != JSONObject.NULL) {
                return zzb(jSONObject);
            }
            return null;
        } catch (Exception e) {
            Log.d("JSONParser", "Failed to parse JSONObject into Map.");
            throw new com.google.android.gms.internal.firebase_auth.zzv(e);
        }
    }

    @VisibleForTesting
    private static Map<String, Object> zzb(JSONObject jSONObject) throws JSONException {
        ArrayMap arrayMap = new ArrayMap();
        Iterator<String> itKeys = jSONObject.keys();
        while (itKeys.hasNext()) {
            String next = itKeys.next();
            Object objZzb = jSONObject.get(next);
            if (objZzb instanceof JSONArray) {
                objZzb = zza((JSONArray) objZzb);
            } else if (objZzb instanceof JSONObject) {
                objZzb = zzb((JSONObject) objZzb);
            }
            arrayMap.put(next, objZzb);
        }
        return arrayMap;
    }
}
