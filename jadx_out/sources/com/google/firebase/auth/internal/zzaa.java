package com.google.firebase.auth.internal;

import android.content.Context;
import android.content.SharedPreferences;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.logging.Logger;
import com.google.android.gms.internal.firebase_auth.zzao;
import com.google.firebase.FirebaseApp;
import com.google.firebase.auth.FirebaseUser;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes2.dex */
public final class zzaa {
    private Logger zzdx;
    private Context zzgs;
    private String zzlr;
    private SharedPreferences zzls;

    public zzaa(@NonNull Context context, @NonNull String str) {
        Preconditions.checkNotNull(context);
        this.zzlr = Preconditions.checkNotEmpty(str);
        this.zzgs = context.getApplicationContext();
        this.zzls = this.zzgs.getSharedPreferences(String.format("com.google.firebase.auth.api.Store.%s", this.zzlr), 0);
        this.zzdx = new Logger("StorageHelpers", new String[0]);
    }

    private final zzl zzc(@NonNull JSONObject jSONObject) {
        zzn zznVarZza;
        try {
            String string = jSONObject.getString("cachedTokenState");
            String string2 = jSONObject.getString("applicationName");
            boolean z = jSONObject.getBoolean("anonymous");
            String string3 = jSONObject.getString("version");
            String str = string3 != null ? string3 : "2";
            JSONArray jSONArray = jSONObject.getJSONArray("userInfos");
            int length = jSONArray.length();
            ArrayList arrayList = new ArrayList(length);
            for (int i = 0; i < length; i++) {
                arrayList.add(zzh.zzad(jSONArray.getString(i)));
            }
            zzl zzlVar = new zzl(FirebaseApp.getInstance(string2), arrayList);
            if (!TextUtils.isEmpty(string)) {
                zzlVar.zza(zzao.zzs(string));
            }
            if (!z) {
                zzlVar.zzn();
            }
            zzlVar.zzae(str);
            if (jSONObject.has("userMetadata") && (zznVarZza = zzn.zza(jSONObject.getJSONObject("userMetadata"))) != null) {
                zzlVar.zza(zznVarZza);
            }
            return zzlVar;
        } catch (com.google.android.gms.internal.firebase_auth.zzv | ArrayIndexOutOfBoundsException | IllegalArgumentException | JSONException e) {
            this.zzdx.wtf(e);
            return null;
        }
    }

    @Nullable
    private final String zzi(@NonNull FirebaseUser firebaseUser) {
        JSONObject jSONObject = new JSONObject();
        if (!zzl.class.isAssignableFrom(firebaseUser.getClass())) {
            return null;
        }
        zzl zzlVar = (zzl) firebaseUser;
        try {
            jSONObject.put("cachedTokenState", zzlVar.zzq());
            jSONObject.put("applicationName", zzlVar.zzo().getName());
            jSONObject.put("type", "com.google.firebase.auth.internal.DefaultFirebaseUser");
            if (zzlVar.zzbg() != null) {
                JSONArray jSONArray = new JSONArray();
                List<zzh> listZzbg = zzlVar.zzbg();
                for (int i = 0; i < listZzbg.size(); i++) {
                    jSONArray.put(listZzbg.get(i).toJson());
                }
                jSONObject.put("userInfos", jSONArray);
            }
            jSONObject.put("anonymous", zzlVar.isAnonymous());
            jSONObject.put("version", "2");
            if (zzlVar.getMetadata() != null) {
                jSONObject.put("userMetadata", ((zzn) zzlVar.getMetadata()).zzbh());
            }
            return jSONObject.toString();
        } catch (Exception e) {
            this.zzdx.wtf("Failed to turn object into JSON", e, new Object[0]);
            throw new com.google.android.gms.internal.firebase_auth.zzv(e);
        }
    }

    public final void clear(String str) {
        this.zzls.edit().remove(str).apply();
    }

    public final void zza(@NonNull FirebaseUser firebaseUser, @NonNull zzao zzaoVar) {
        Preconditions.checkNotNull(firebaseUser);
        Preconditions.checkNotNull(zzaoVar);
        this.zzls.edit().putString(String.format("com.google.firebase.auth.GET_TOKEN_RESPONSE.%s", firebaseUser.getUid()), zzaoVar.toJson()).apply();
    }

    @Nullable
    public final FirebaseUser zzbl() {
        String string = this.zzls.getString("com.google.firebase.auth.FIREBASE_USER", null);
        if (TextUtils.isEmpty(string)) {
            return null;
        }
        try {
            JSONObject jSONObject = new JSONObject(string);
            if (jSONObject.has("type") && "com.google.firebase.auth.internal.DefaultFirebaseUser".equalsIgnoreCase(jSONObject.optString("type"))) {
                return zzc(jSONObject);
            }
        } catch (Exception unused) {
        }
        return null;
    }

    public final void zzg(@NonNull FirebaseUser firebaseUser) {
        Preconditions.checkNotNull(firebaseUser);
        String strZzi = zzi(firebaseUser);
        if (TextUtils.isEmpty(strZzi)) {
            return;
        }
        this.zzls.edit().putString("com.google.firebase.auth.FIREBASE_USER", strZzi).apply();
    }

    public final zzao zzh(@NonNull FirebaseUser firebaseUser) {
        Preconditions.checkNotNull(firebaseUser);
        String string = this.zzls.getString(String.format("com.google.firebase.auth.GET_TOKEN_RESPONSE.%s", firebaseUser.getUid()), null);
        if (string != null) {
            return zzao.zzs(string);
        }
        return null;
    }
}
