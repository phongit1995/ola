package com.google.android.gms.internal.firebase_auth;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "GetAccountInfoUserCreator")
@SafeParcelable.Reserved({1})
public final class zzaj extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzaj> CREATOR = new zzak();

    @SafeParcelable.Field(getter = "getLocalId", id = 2)
    private String zzad;

    @SafeParcelable.Field(getter = "getEmail", id = 3)
    private String zzah;

    @SafeParcelable.Field(getter = "isNewUser", id = 12)
    private boolean zzak;

    @SafeParcelable.Field(getter = "getPhoneNumber", id = 9)
    private String zzbd;

    @SafeParcelable.Field(getter = "getDisplayName", id = 5)
    private String zzbh;

    @SafeParcelable.Field(getter = "getPassword", id = 8)
    private String zzbi;

    @SafeParcelable.Field(getter = "getPhotoUrl", id = 6)
    private String zzbr;

    @SafeParcelable.Field(getter = "isEmailVerified", id = 4)
    private boolean zzjq;

    @SafeParcelable.Field(getter = "getProviderInfoList", id = 7)
    private zzas zzjr;

    @SafeParcelable.Field(getter = "getCreationTimestamp", id = 10)
    private long zzjs;

    @SafeParcelable.Field(getter = "getLastSignInTimestamp", id = 11)
    private long zzjt;

    @SafeParcelable.Field(getter = "getDefaultOAuthCredential", id = 13)
    private com.google.firebase.auth.zzd zzju;

    public zzaj() {
        this.zzjr = new zzas();
    }

    @SafeParcelable.Constructor
    public zzaj(@SafeParcelable.Param(id = 2) String str, @SafeParcelable.Param(id = 3) String str2, @SafeParcelable.Param(id = 4) boolean z, @SafeParcelable.Param(id = 5) String str3, @SafeParcelable.Param(id = 6) String str4, @SafeParcelable.Param(id = 7) zzas zzasVar, @SafeParcelable.Param(id = 8) String str5, @SafeParcelable.Param(id = 9) String str6, @SafeParcelable.Param(id = 10) long j, @SafeParcelable.Param(id = 11) long j2, @SafeParcelable.Param(id = 12) boolean z2, @SafeParcelable.Param(id = 13) com.google.firebase.auth.zzd zzdVar) {
        this.zzad = str;
        this.zzah = str2;
        this.zzjq = z;
        this.zzbh = str3;
        this.zzbr = str4;
        this.zzjr = zzasVar == null ? new zzas() : zzas.zza(zzasVar);
        this.zzbi = str5;
        this.zzbd = str6;
        this.zzjs = j;
        this.zzjt = j2;
        this.zzak = z2;
        this.zzju = zzdVar;
    }

    public final long getCreationTimestamp() {
        return this.zzjs;
    }

    @Nullable
    public final String getDisplayName() {
        return this.zzbh;
    }

    @Nullable
    public final String getEmail() {
        return this.zzah;
    }

    public final long getLastSignInTimestamp() {
        return this.zzjt;
    }

    @NonNull
    public final String getLocalId() {
        return this.zzad;
    }

    @Nullable
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

    public final boolean isEmailVerified() {
        return this.zzjq;
    }

    public final boolean isNewUser() {
        return this.zzak;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 2, this.zzad, false);
        SafeParcelWriter.writeString(parcel, 3, this.zzah, false);
        SafeParcelWriter.writeBoolean(parcel, 4, this.zzjq);
        SafeParcelWriter.writeString(parcel, 5, this.zzbh, false);
        SafeParcelWriter.writeString(parcel, 6, this.zzbr, false);
        SafeParcelWriter.writeParcelable(parcel, 7, this.zzjr, i, false);
        SafeParcelWriter.writeString(parcel, 8, this.zzbi, false);
        SafeParcelWriter.writeString(parcel, 9, this.zzbd, false);
        SafeParcelWriter.writeLong(parcel, 10, this.zzjs);
        SafeParcelWriter.writeLong(parcel, 11, this.zzjt);
        SafeParcelWriter.writeBoolean(parcel, 12, this.zzak);
        SafeParcelWriter.writeParcelable(parcel, 13, this.zzju, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    @NonNull
    public final List<zzaq> zzat() {
        return this.zzjr.zzat();
    }

    public final zzas zzau() {
        return this.zzjr;
    }

    @Nullable
    public final com.google.firebase.auth.zzd zzav() {
        return this.zzju;
    }

    @NonNull
    public final zzaj zzb(com.google.firebase.auth.zzd zzdVar) {
        this.zzju = zzdVar;
        return this;
    }

    @NonNull
    public final zzaj zzb(@NonNull List<zzaq> list) {
        Preconditions.checkNotNull(list);
        this.zzjr = new zzas();
        this.zzjr.zzat().addAll(list);
        return this;
    }

    public final zzaj zzc(boolean z) {
        this.zzak = z;
        return this;
    }

    @NonNull
    public final zzaj zzl(@Nullable String str) {
        this.zzah = str;
        return this;
    }

    @NonNull
    public final zzaj zzm(@Nullable String str) {
        this.zzbh = str;
        return this;
    }

    @NonNull
    public final zzaj zzn(@Nullable String str) {
        this.zzbr = str;
        return this;
    }

    @NonNull
    public final zzaj zzo(@NonNull String str) {
        Preconditions.checkNotEmpty(str);
        this.zzbi = str;
        return this;
    }
}
