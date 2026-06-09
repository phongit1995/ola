package com.google.android.gms.internal.firebase_auth;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.util.Log;
import com.facebook.AccessToken;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.DefaultClock;
import com.google.android.gms.common.util.Strings;
import com.google.android.gms.internal.firebase_auth.zzgy;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "GetTokenResponseCreator")
@SafeParcelable.Reserved({1})
public final class zzao extends AbstractSafeParcelable implements com.google.firebase.auth.api.internal.zzcg<zzao, zzgy.zza> {
    public static final Parcelable.Creator<zzao> CREATOR = new zzap();

    @SafeParcelable.Field(getter = "getRefreshToken", id = 2)
    private String zzai;

    @SafeParcelable.Field(getter = "getAccessToken", id = 3)
    private String zzdv;

    @SafeParcelable.Field(getter = "getExpiresIn", id = 4)
    private Long zzjx;

    @SafeParcelable.Field(getter = "getTokenType", id = 5)
    private String zzjy;

    @SafeParcelable.Field(getter = "getIssuedAt", id = 6)
    private Long zzjz;

    public zzao() {
        this.zzjz = Long.valueOf(System.currentTimeMillis());
    }

    public zzao(String str, String str2, Long l, String str3) {
        this(str, str2, l, str3, Long.valueOf(System.currentTimeMillis()));
    }

    @SafeParcelable.Constructor
    zzao(@SafeParcelable.Param(id = 2) String str, @SafeParcelable.Param(id = 3) String str2, @SafeParcelable.Param(id = 4) Long l, @SafeParcelable.Param(id = 5) String str3, @SafeParcelable.Param(id = 6) Long l2) {
        this.zzai = str;
        this.zzdv = str2;
        this.zzjx = l;
        this.zzjy = str3;
        this.zzjz = l2;
    }

    public static zzao zzs(@NonNull String str) {
        try {
            JSONObject jSONObject = new JSONObject(str);
            zzao zzaoVar = new zzao();
            zzaoVar.zzai = jSONObject.optString("refresh_token", null);
            zzaoVar.zzdv = jSONObject.optString("access_token", null);
            zzaoVar.zzjx = Long.valueOf(jSONObject.optLong(AccessToken.EXPIRES_IN_KEY));
            zzaoVar.zzjy = jSONObject.optString("token_type", null);
            zzaoVar.zzjz = Long.valueOf(jSONObject.optLong("issued_at"));
            return zzaoVar;
        } catch (JSONException e) {
            Log.d("GetTokenResponse", "Failed to read GetTokenResponse from JSONObject");
            throw new zzv(e);
        }
    }

    public final boolean isValid() {
        return DefaultClock.getInstance().currentTimeMillis() + 300000 < this.zzjz.longValue() + (this.zzjx.longValue() * 1000);
    }

    public final String toJson() {
        JSONObject jSONObject = new JSONObject();
        try {
            jSONObject.put("refresh_token", this.zzai);
            jSONObject.put("access_token", this.zzdv);
            jSONObject.put(AccessToken.EXPIRES_IN_KEY, this.zzjx);
            jSONObject.put("token_type", this.zzjy);
            jSONObject.put("issued_at", this.zzjz);
            return jSONObject.toString();
        } catch (JSONException e) {
            Log.d("GetTokenResponse", "Failed to convert GetTokenResponse to JSON");
            throw new zzv(e);
        }
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 2, this.zzai, false);
        SafeParcelWriter.writeString(parcel, 3, this.zzdv, false);
        SafeParcelWriter.writeLongObject(parcel, 4, Long.valueOf(zzaq()), false);
        SafeParcelWriter.writeString(parcel, 5, this.zzjy, false);
        SafeParcelWriter.writeLongObject(parcel, 6, Long.valueOf(this.zzjz.longValue()), false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    @Override // com.google.firebase.auth.api.internal.zzcg
    public final /* synthetic */ com.google.firebase.auth.api.internal.zzcg zza(zzgt zzgtVar) {
        zzgy.zza zzaVar = (zzgy.zza) zzgtVar;
        this.zzai = Strings.emptyToNull(zzaVar.zzai);
        this.zzdv = Strings.emptyToNull(zzaVar.zzdv);
        this.zzjx = Long.valueOf(zzaVar.zzaj);
        this.zzjy = Strings.emptyToNull(zzaVar.zzjy);
        this.zzjz = Long.valueOf(System.currentTimeMillis());
        return this;
    }

    @Override // com.google.firebase.auth.api.internal.zzcg
    public final Class<zzgy.zza> zzag() {
        return zzgy.zza.class;
    }

    public final String zzap() {
        return this.zzai;
    }

    public final long zzaq() {
        if (this.zzjx == null) {
            return 0L;
        }
        return this.zzjx.longValue();
    }

    public final String zzaw() {
        return this.zzdv;
    }

    @Nullable
    public final String zzax() {
        return this.zzjy;
    }

    public final long zzay() {
        return this.zzjz.longValue();
    }

    public final void zzr(@NonNull String str) {
        this.zzai = Preconditions.checkNotEmpty(str);
    }
}
