package com.google.firebase.auth;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.internal.firebase_auth.zzbf;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "GithubAuthCredentialCreator")
public class GithubAuthCredential extends AuthCredential {
    public static final Parcelable.Creator<GithubAuthCredential> CREATOR = new zzs();

    @SafeParcelable.Field(getter = "getToken", id = 1)
    private String zzdh;

    @SafeParcelable.Constructor
    GithubAuthCredential(@SafeParcelable.Param(id = 1) @NonNull String str) {
        this.zzdh = Preconditions.checkNotEmpty(str);
    }

    public static zzbf zza(@NonNull GithubAuthCredential githubAuthCredential) {
        Preconditions.checkNotNull(githubAuthCredential);
        return new zzbf(null, githubAuthCredential.zzdh, githubAuthCredential.getProvider(), null, null);
    }

    @Override // com.google.firebase.auth.AuthCredential
    public String getProvider() {
        return "github.com";
    }

    @Override // com.google.firebase.auth.AuthCredential
    public String getSignInMethod() {
        return "github.com";
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzdh, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
