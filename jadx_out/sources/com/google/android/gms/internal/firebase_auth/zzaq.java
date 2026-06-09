package com.google.android.gms.internal.firebase_auth;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "ProviderUserInfoCreator")
@SafeParcelable.Reserved({1})
public final class zzaq extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzaq> CREATOR = new zzar();

    @SafeParcelable.Field(getter = "getEmail", id = 8)
    private String zzah;

    @SafeParcelable.Field(getter = "getPhoneNumber", id = 7)
    private String zzbd;

    @SafeParcelable.Field(getter = "getDisplayName", id = 3)
    private String zzbh;

    @SafeParcelable.Field(getter = "getPhotoUrl", id = 4)
    private String zzbr;

    @SafeParcelable.Field(getter = "getFederatedId", id = 2)
    private String zzcg;

    @SafeParcelable.Field(getter = "getRawUserInfo", id = 6)
    private String zzdf;

    @SafeParcelable.Field(getter = "getProviderId", id = 5)
    private String zzj;

    public zzaq() {
    }

    @SafeParcelable.Constructor
    zzaq(@SafeParcelable.Param(id = 2) String str, @SafeParcelable.Param(id = 3) String str2, @SafeParcelable.Param(id = 4) String str3, @SafeParcelable.Param(id = 5) String str4, @SafeParcelable.Param(id = 6) String str5, @SafeParcelable.Param(id = 7) String str6, @SafeParcelable.Param(id = 8) String str7) {
        this.zzcg = str;
        this.zzbh = str2;
        this.zzbr = str3;
        this.zzj = str4;
        this.zzdf = str5;
        this.zzbd = str6;
        this.zzah = str7;
    }

    @Nullable
    public final String getDisplayName() {
        return this.zzbh;
    }

    @Nullable
    public final String getEmail() {
        return this.zzah;
    }

    public final String getPhoneNumber() {
        return this.zzbd;
    }

    @Nullable
    public final Uri getPhotoUri() {
        if (TextUtils.isEmpty(this.zzbr)) {
            return null;
        }
        return Uri.parse(this.zzbr);
    }

    public final String getProviderId() {
        return this.zzj;
    }

    @Nullable
    public final String getRawUserInfo() {
        return this.zzdf;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 2, this.zzcg, false);
        SafeParcelWriter.writeString(parcel, 3, this.zzbh, false);
        SafeParcelWriter.writeString(parcel, 4, this.zzbr, false);
        SafeParcelWriter.writeString(parcel, 5, this.zzj, false);
        SafeParcelWriter.writeString(parcel, 6, this.zzdf, false);
        SafeParcelWriter.writeString(parcel, 7, this.zzbd, false);
        SafeParcelWriter.writeString(parcel, 8, this.zzah, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final String zzaz() {
        return this.zzcg;
    }

    public final void zzt(String str) {
        this.zzdf = str;
    }
}
