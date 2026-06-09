package com.google.android.gms.internal.firebase_auth;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "VerifyAssertionRequestCreator")
@SafeParcelable.Reserved({1})
public final class zzbf extends AbstractSafeParcelable implements com.google.firebase.auth.api.internal.zzdp<zzq> {
    public static final Parcelable.Creator<zzbf> CREATOR = new zzbg();

    @SafeParcelable.Field(getter = "getIdToken", id = 4)
    private String zzaf;

    @Nullable
    @SafeParcelable.Field(getter = "getEmail", id = 7)
    private String zzah;

    @SafeParcelable.Field(getter = "getReturnSecureToken", id = 10)
    private boolean zzbt;

    @SafeParcelable.Field(getter = "getRequestUri", id = 2)
    private String zzca;

    @SafeParcelable.Field(getter = "getPostBody", id = 8)
    private String zzcb;

    @SafeParcelable.Field(getter = "getAutoCreate", id = 11)
    private boolean zzcf;

    @SafeParcelable.Field(getter = "getOauthTokenSecret", id = 9)
    private String zzdc;

    @SafeParcelable.Field(getter = "getAccessToken", id = 5)
    private String zzdv;

    @SafeParcelable.Field(getter = "getProviderId", id = 6)
    private String zzj;

    @SafeParcelable.Field(getter = "getCurrentIdToken", id = 3)
    private String zzki;

    @SafeParcelable.Field(getter = "getAuthCode", id = 12)
    private String zzkj;

    @SafeParcelable.Field(getter = "getIdpResponseUrl", id = 14)
    private String zzkk;

    @SafeParcelable.Field(getter = "getSessionId", id = 13)
    private String zzr;

    public zzbf() {
        this.zzbt = true;
        this.zzcf = true;
    }

    public zzbf(@Nullable String str, @Nullable String str2, String str3, @Nullable String str4, @Nullable String str5) {
        this(str, str2, str3, null, str5, null);
    }

    public zzbf(@Nullable String str, @Nullable String str2, String str3, @Nullable String str4, @Nullable String str5, @Nullable String str6) {
        this.zzca = "http://localhost";
        this.zzaf = str;
        this.zzdv = str2;
        this.zzdc = str5;
        this.zzkj = str6;
        this.zzbt = true;
        if (TextUtils.isEmpty(this.zzaf) && TextUtils.isEmpty(this.zzdv) && TextUtils.isEmpty(this.zzkj)) {
            throw new IllegalArgumentException("idToken, accessToken and authCode cannot all be null");
        }
        this.zzj = Preconditions.checkNotEmpty(str3);
        this.zzah = null;
        StringBuilder sb = new StringBuilder();
        if (!TextUtils.isEmpty(this.zzaf)) {
            sb.append("id_token=");
            sb.append(this.zzaf);
            sb.append("&");
        }
        if (!TextUtils.isEmpty(this.zzdv)) {
            sb.append("access_token=");
            sb.append(this.zzdv);
            sb.append("&");
        }
        if (!TextUtils.isEmpty(this.zzah)) {
            sb.append("identifier=");
            sb.append(this.zzah);
            sb.append("&");
        }
        if (!TextUtils.isEmpty(this.zzdc)) {
            sb.append("oauth_token_secret=");
            sb.append(this.zzdc);
            sb.append("&");
        }
        if (!TextUtils.isEmpty(this.zzkj)) {
            sb.append("code=");
            sb.append(this.zzkj);
            sb.append("&");
        }
        sb.append("providerId=");
        sb.append(this.zzj);
        this.zzcb = sb.toString();
        this.zzcf = true;
    }

    @SafeParcelable.Constructor
    zzbf(@SafeParcelable.Param(id = 2) String str, @SafeParcelable.Param(id = 3) String str2, @SafeParcelable.Param(id = 4) String str3, @SafeParcelable.Param(id = 5) String str4, @SafeParcelable.Param(id = 6) String str5, @SafeParcelable.Param(id = 7) String str6, @SafeParcelable.Param(id = 8) String str7, @SafeParcelable.Param(id = 9) String str8, @SafeParcelable.Param(id = 10) boolean z, @SafeParcelable.Param(id = 11) boolean z2, @SafeParcelable.Param(id = 12) String str9, @SafeParcelable.Param(id = 13) String str10, @SafeParcelable.Param(id = 14) String str11) {
        this.zzca = str;
        this.zzki = str2;
        this.zzaf = str3;
        this.zzdv = str4;
        this.zzj = str5;
        this.zzah = str6;
        this.zzcb = str7;
        this.zzdc = str8;
        this.zzbt = z;
        this.zzcf = z2;
        this.zzkj = str9;
        this.zzr = str10;
        this.zzkk = str11;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 2, this.zzca, false);
        SafeParcelWriter.writeString(parcel, 3, this.zzki, false);
        SafeParcelWriter.writeString(parcel, 4, this.zzaf, false);
        SafeParcelWriter.writeString(parcel, 5, this.zzdv, false);
        SafeParcelWriter.writeString(parcel, 6, this.zzj, false);
        SafeParcelWriter.writeString(parcel, 7, this.zzah, false);
        SafeParcelWriter.writeString(parcel, 8, this.zzcb, false);
        SafeParcelWriter.writeString(parcel, 9, this.zzdc, false);
        SafeParcelWriter.writeBoolean(parcel, 10, this.zzbt);
        SafeParcelWriter.writeBoolean(parcel, 11, this.zzcf);
        SafeParcelWriter.writeString(parcel, 12, this.zzkj, false);
        SafeParcelWriter.writeString(parcel, 13, this.zzr, false);
        SafeParcelWriter.writeString(parcel, 14, this.zzkk, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final zzbf zzac(@NonNull String str) {
        this.zzki = Preconditions.checkNotEmpty(str);
        return this;
    }

    @Override // com.google.firebase.auth.api.internal.zzdp
    public final /* synthetic */ zzgt zzao() {
        zzq zzqVar = new zzq();
        zzqVar.zzaf = this.zzki;
        zzqVar.zzca = this.zzca;
        zzqVar.zzcb = this.zzcb;
        zzqVar.zzbt = this.zzbt;
        zzqVar.zzcf = this.zzcf;
        if (!TextUtils.isEmpty(this.zzr)) {
            zzqVar.zzr = this.zzr;
        }
        if (!TextUtils.isEmpty(this.zzkk)) {
            zzqVar.zzca = this.zzkk;
        }
        return zzqVar;
    }

    public final zzbf zzd(boolean z) {
        this.zzcf = false;
        return this;
    }
}
