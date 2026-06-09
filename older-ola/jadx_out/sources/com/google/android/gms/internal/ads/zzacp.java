package com.google.android.gms.internal.ads;

import android.support.v4.util.SimpleArrayMap;
import com.facebook.share.internal.MessengerShareContentUtility;
import java.util.concurrent.Future;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzacp implements zzacd<zzos> {
    private final boolean zzcbk;

    public zzacp(boolean z) {
        this.zzcbk = z;
    }

    @Override // com.google.android.gms.internal.ads.zzacd
    public final /* synthetic */ zzpb zza(zzabv zzabvVar, JSONObject jSONObject) throws JSONException {
        SimpleArrayMap simpleArrayMap = new SimpleArrayMap();
        SimpleArrayMap simpleArrayMap2 = new SimpleArrayMap();
        zzanz<zzoj> zzanzVarZzg = zzabvVar.zzg(jSONObject);
        zzanz<zzaqw> zzanzVarZzc = zzabvVar.zzc(jSONObject, "video");
        JSONArray jSONArray = jSONObject.getJSONArray("custom_assets");
        for (int i = 0; i < jSONArray.length(); i++) {
            JSONObject jSONObject2 = jSONArray.getJSONObject(i);
            String string = jSONObject2.getString("type");
            if ("string".equals(string)) {
                simpleArrayMap2.put(jSONObject2.getString("name"), jSONObject2.getString("string_value"));
            } else if (MessengerShareContentUtility.MEDIA_IMAGE.equals(string)) {
                simpleArrayMap.put(jSONObject2.getString("name"), zzabvVar.zza(jSONObject2, "image_value", this.zzcbk));
            } else {
                String strValueOf = String.valueOf(string);
                zzakb.zzdk(strValueOf.length() != 0 ? "Unknown custom asset type: ".concat(strValueOf) : new String("Unknown custom asset type: "));
            }
        }
        zzaqw zzaqwVarZzc = zzabv.zzc(zzanzVarZzc);
        String string2 = jSONObject.getString("custom_template_id");
        SimpleArrayMap simpleArrayMap3 = new SimpleArrayMap();
        for (int i2 = 0; i2 < simpleArrayMap.size(); i2++) {
            simpleArrayMap3.put(simpleArrayMap.keyAt(i2), ((Future) simpleArrayMap.valueAt(i2)).get());
        }
        return new zzos(string2, simpleArrayMap3, simpleArrayMap2, zzanzVarZzg.get(), zzaqwVarZzc != null ? zzaqwVarZzc.zztm() : null, zzaqwVarZzc != null ? zzaqwVarZzc.getView() : null);
    }
}
