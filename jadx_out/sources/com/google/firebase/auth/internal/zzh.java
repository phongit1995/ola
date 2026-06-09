package com.google.firebase.auth.internal;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import android.util.Log;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.internal.firebase_auth.zzaj;
import com.google.android.gms.internal.firebase_auth.zzaq;
import com.google.firebase.auth.UserInfo;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "DefaultAuthUserInfoCreator")
public final class zzh extends AbstractSafeParcelable implements UserInfo {
    public static final Parcelable.Creator<zzh> CREATOR = new zzi();

    @Nullable
    @SafeParcelable.Field(getter = "getEmail", id = 5)
    private String zzah;

    @Nullable
    @SafeParcelable.Field(getter = "getPhoneNumber", id = 6)
    private String zzbd;

    @Nullable
    @SafeParcelable.Field(getter = "getDisplayName", id = 3)
    private String zzbh;

    @Nullable
    @SafeParcelable.Field(getter = "getPhotoUrlString", id = 4)
    private String zzbr;

    @Nullable
    @SafeParcelable.Field(getter = "getRawUserInfo", id = 8)
    private String zzdf;

    @Nullable
    private Uri zzfh;

    @NonNull
    @SafeParcelable.Field(getter = "getProviderId", id = 2)
    private String zzj;

    @SafeParcelable.Field(getter = "isEmailVerified", id = 7)
    private boolean zzjq;

    @NonNull
    @SafeParcelable.Field(getter = "getUid", id = 1)
    private String zzkv;

    public zzh(@NonNull zzaj zzajVar, @NonNull String str) {
        Preconditions.checkNotNull(zzajVar);
        Preconditions.checkNotEmpty(str);
        this.zzkv = Preconditions.checkNotEmpty(zzajVar.getLocalId());
        this.zzj = str;
        this.zzah = zzajVar.getEmail();
        this.zzbh = zzajVar.getDisplayName();
        Uri photoUri = zzajVar.getPhotoUri();
        if (photoUri != null) {
            this.zzbr = photoUri.toString();
            this.zzfh = photoUri;
        }
        this.zzjq = zzajVar.isEmailVerified();
        this.zzdf = null;
        this.zzbd = zzajVar.getPhoneNumber();
    }

    public zzh(@NonNull zzaq zzaqVar) {
        Preconditions.checkNotNull(zzaqVar);
        this.zzkv = zzaqVar.zzaz();
        this.zzj = Preconditions.checkNotEmpty(zzaqVar.getProviderId());
        this.zzbh = zzaqVar.getDisplayName();
        Uri photoUri = zzaqVar.getPhotoUri();
        if (photoUri != null) {
            this.zzbr = photoUri.toString();
            this.zzfh = photoUri;
        }
        this.zzah = zzaqVar.getEmail();
        this.zzbd = zzaqVar.getPhoneNumber();
        this.zzjq = false;
        this.zzdf = zzaqVar.getRawUserInfo();
    }

    @SafeParcelable.Constructor
    @VisibleForTesting
    public zzh(@SafeParcelable.Param(id = 1) @NonNull String str, @SafeParcelable.Param(id = 2) @NonNull String str2, @SafeParcelable.Param(id = 5) @Nullable String str3, @SafeParcelable.Param(id = 4) @Nullable String str4, @SafeParcelable.Param(id = 3) @Nullable String str5, @SafeParcelable.Param(id = 6) @Nullable String str6, @SafeParcelable.Param(id = 7) boolean z, @SafeParcelable.Param(id = 8) @Nullable String str7) {
        this.zzkv = str;
        this.zzj = str2;
        this.zzah = str3;
        this.zzbd = str4;
        this.zzbh = str5;
        this.zzbr = str6;
        if (!TextUtils.isEmpty(this.zzbr)) {
            this.zzfh = Uri.parse(this.zzbr);
        }
        this.zzjq = z;
        this.zzdf = str7;
    }

    @Nullable
    public static zzh zzad(@NonNull String str) {
        try {
            JSONObject jSONObject = new JSONObject(str);
            return new zzh(jSONObject.optString("userId"), jSONObject.optString("providerId"), jSONObject.optString("email"), jSONObject.optString("phoneNumber"), jSONObject.optString("displayName"), jSONObject.optString("photoUrl"), jSONObject.optBoolean("isEmailVerified"), jSONObject.optString("rawUserInfo"));
        } catch (JSONException e) {
            Log.d("DefaultAuthUserInfo", "Failed to unpack UserInfo from JSON");
            throw new com.google.android.gms.internal.firebase_auth.zzv(e);
        }
    }

    @Override // com.google.firebase.auth.UserInfo
    @Nullable
    public final String getDisplayName() {
        return this.zzbh;
    }

    @Override // com.google.firebase.auth.UserInfo
    @Nullable
    public final String getEmail() {
        return this.zzah;
    }

    @Override // com.google.firebase.auth.UserInfo
    @Nullable
    public final String getPhoneNumber() {
        return this.zzbd;
    }

    @Override // com.google.firebase.auth.UserInfo
    @Nullable
    public final Uri getPhotoUrl() {
        if (!TextUtils.isEmpty(this.zzbr) && this.zzfh == null) {
            this.zzfh = Uri.parse(this.zzbr);
        }
        return this.zzfh;
    }

    @Override // com.google.firebase.auth.UserInfo
    @NonNull
    public final String getProviderId() {
        return this.zzj;
    }

    @Nullable
    public final String getRawUserInfo() {
        return this.zzdf;
    }

    @Override // com.google.firebase.auth.UserInfo
    @NonNull
    public final String getUid() {
        return this.zzkv;
    }

    @Override // com.google.firebase.auth.UserInfo
    public final boolean isEmailVerified() {
        return this.zzjq;
    }

    @Nullable
    public final String toJson() {
        JSONObject jSONObject = new JSONObject();
        try {
            jSONObject.putOpt("userId", this.zzkv);
            jSONObject.putOpt("providerId", this.zzj);
            jSONObject.putOpt("displayName", this.zzbh);
            jSONObject.putOpt("photoUrl", this.zzbr);
            jSONObject.putOpt("email", this.zzah);
            jSONObject.putOpt("phoneNumber", this.zzbd);
            jSONObject.putOpt("isEmailVerified", Boolean.valueOf(this.zzjq));
            jSONObject.putOpt("rawUserInfo", this.zzdf);
            return jSONObject.toString();
        } catch (JSONException e) {
            Log.d("DefaultAuthUserInfo", "Failed to jsonify this object");
            throw new com.google.android.gms.internal.firebase_auth.zzv(e);
        }
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, getUid(), false);
        SafeParcelWriter.writeString(parcel, 2, getProviderId(), false);
        SafeParcelWriter.writeString(parcel, 3, getDisplayName(), false);
        SafeParcelWriter.writeString(parcel, 4, this.zzbr, false);
        SafeParcelWriter.writeString(parcel, 5, getEmail(), false);
        SafeParcelWriter.writeString(parcel, 6, getPhoneNumber(), false);
        SafeParcelWriter.writeBoolean(parcel, 7, isEmailVerified());
        SafeParcelWriter.writeString(parcel, 8, this.zzdf, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
