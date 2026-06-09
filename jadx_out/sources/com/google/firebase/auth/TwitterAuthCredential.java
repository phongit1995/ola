package com.google.firebase.auth;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.internal.firebase_auth.zzbf;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "TwitterAuthCredentialCreator")
public class TwitterAuthCredential extends AuthCredential {
    public static final Parcelable.Creator<TwitterAuthCredential> CREATOR = new zzx();

    @SafeParcelable.Field(getter = "getToken", id = 1)
    private String zzdh;

    @SafeParcelable.Field(getter = "getSecret", id = 2)
    private String zzfe;

    @SafeParcelable.Constructor
    TwitterAuthCredential(@SafeParcelable.Param(id = 1) @NonNull String str, @SafeParcelable.Param(id = 2) @NonNull String str2) {
        this.zzdh = Preconditions.checkNotEmpty(str);
        this.zzfe = Preconditions.checkNotEmpty(str2);
    }

    public static zzbf zza(@NonNull TwitterAuthCredential twitterAuthCredential) {
        Preconditions.checkNotNull(twitterAuthCredential);
        return new zzbf(null, twitterAuthCredential.zzdh, twitterAuthCredential.getProvider(), null, twitterAuthCredential.zzfe);
    }

    @Override // com.google.firebase.auth.AuthCredential
    public String getProvider() {
        return "twitter.com";
    }

    @Override // com.google.firebase.auth.AuthCredential
    public String getSignInMethod() {
        return "twitter.com";
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzdh, false);
        SafeParcelWriter.writeString(parcel, 2, this.zzfe, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
