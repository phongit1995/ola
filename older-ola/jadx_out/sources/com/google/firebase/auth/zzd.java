package com.google.firebase.auth;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.internal.firebase_auth.zzbf;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "DefaultOAuthCredentialCreator")
public class zzd extends zzu {
    public static final Parcelable.Creator<zzd> CREATOR = new zze();

    @SafeParcelable.Field(getter = "getIdToken", id = 2)
    private final String zzaf;

    @SafeParcelable.Field(getter = "getAccessToken", id = 3)
    private final String zzdv;

    @SafeParcelable.Field(getter = "getWebSignInCredential", id = 4)
    private final zzbf zzdw;

    @SafeParcelable.Field(getter = "getProvider", id = 1)
    private final String zzj;

    @SafeParcelable.Constructor
    zzd(@SafeParcelable.Param(id = 1) @NonNull String str, @SafeParcelable.Param(id = 2) @Nullable String str2, @SafeParcelable.Param(id = 3) @Nullable String str3, @SafeParcelable.Param(id = 4) @Nullable zzbf zzbfVar) {
        this.zzj = str;
        this.zzaf = str2;
        this.zzdv = str3;
        this.zzdw = zzbfVar;
    }

    public static zzbf zza(@NonNull zzd zzdVar) {
        Preconditions.checkNotNull(zzdVar);
        return zzdVar.zzdw != null ? zzdVar.zzdw : new zzbf(zzdVar.zzaf, zzdVar.zzdv, zzdVar.getProvider(), null, null);
    }

    public static zzd zza(String str, String str2, String str3) {
        if (TextUtils.isEmpty(str2) && TextUtils.isEmpty(str3)) {
            throw new IllegalArgumentException("Must specify an idToken or an accessToken.");
        }
        return new zzd(Preconditions.checkNotEmpty(str, "Must specify a non-empty providerId"), str2, str3, null);
    }

    @Override // com.google.firebase.auth.AuthCredential
    public String getProvider() {
        return this.zzj;
    }

    @Override // com.google.firebase.auth.AuthCredential
    public String getSignInMethod() {
        return this.zzj;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, getProvider(), false);
        SafeParcelWriter.writeString(parcel, 2, this.zzaf, false);
        SafeParcelWriter.writeString(parcel, 3, this.zzdv, false);
        SafeParcelWriter.writeParcelable(parcel, 4, this.zzdw, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
