package com.google.firebase.auth;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.internal.firebase_auth.zzbf;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "FacebookAuthCredentialCreator")
public class FacebookAuthCredential extends AuthCredential {
    public static final Parcelable.Creator<FacebookAuthCredential> CREATOR = new zzg();

    @SafeParcelable.Field(getter = "getAccessToken", id = 1)
    private final String zzdv;

    @SafeParcelable.Constructor
    FacebookAuthCredential(@SafeParcelable.Param(id = 1) @NonNull String str) {
        this.zzdv = Preconditions.checkNotEmpty(str);
    }

    public static zzbf zza(@NonNull FacebookAuthCredential facebookAuthCredential) {
        Preconditions.checkNotNull(facebookAuthCredential);
        return new zzbf(null, facebookAuthCredential.zzdv, facebookAuthCredential.getProvider(), null, null);
    }

    @Override // com.google.firebase.auth.AuthCredential
    public String getProvider() {
        return "facebook.com";
    }

    @Override // com.google.firebase.auth.AuthCredential
    public String getSignInMethod() {
        return "facebook.com";
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzdv, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
