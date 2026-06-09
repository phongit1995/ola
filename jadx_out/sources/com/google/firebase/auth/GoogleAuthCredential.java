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
@SafeParcelable.Class(creator = "GoogleAuthCredentialCreator")
public class GoogleAuthCredential extends AuthCredential {
    public static final Parcelable.Creator<GoogleAuthCredential> CREATOR = new zzt();

    @SafeParcelable.Field(getter = "getIdToken", id = 1)
    private final String zzaf;

    @SafeParcelable.Field(getter = "getAccessToken", id = 2)
    private final String zzdv;

    @SafeParcelable.Constructor
    GoogleAuthCredential(@SafeParcelable.Param(id = 1) @Nullable String str, @SafeParcelable.Param(id = 2) @Nullable String str2) {
        if (str == null && str2 == null) {
            throw new IllegalArgumentException("Must specify an idToken or an accessToken.");
        }
        this.zzaf = zza(str, "idToken");
        this.zzdv = zza(str2, "accessToken");
    }

    public static zzbf zza(@NonNull GoogleAuthCredential googleAuthCredential) {
        Preconditions.checkNotNull(googleAuthCredential);
        return new zzbf(googleAuthCredential.zzaf, googleAuthCredential.zzdv, googleAuthCredential.getProvider(), null, null);
    }

    private static String zza(String str, String str2) {
        if (str == null || !TextUtils.isEmpty(str)) {
            return str;
        }
        throw new IllegalArgumentException(String.valueOf(str2).concat(" must not be empty"));
    }

    @Override // com.google.firebase.auth.AuthCredential
    public String getProvider() {
        return "google.com";
    }

    @Override // com.google.firebase.auth.AuthCredential
    public String getSignInMethod() {
        return "google.com";
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzaf, false);
        SafeParcelWriter.writeString(parcel, 2, this.zzdv, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
