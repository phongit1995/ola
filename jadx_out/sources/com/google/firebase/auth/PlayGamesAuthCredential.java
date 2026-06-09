package com.google.firebase.auth;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.internal.firebase_auth.zzbf;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "PlayGamesAuthCredentialCreator")
public class PlayGamesAuthCredential extends AuthCredential {
    public static final Parcelable.Creator<PlayGamesAuthCredential> CREATOR = new zzw();

    @SafeParcelable.Field(getter = "getServerAuthCode", id = 1)
    private final String zzfd;

    @SafeParcelable.Constructor
    PlayGamesAuthCredential(@SafeParcelable.Param(id = 1) @NonNull String str) {
        this.zzfd = Preconditions.checkNotEmpty(str);
    }

    public static zzbf zza(@NonNull PlayGamesAuthCredential playGamesAuthCredential) {
        Preconditions.checkNotNull(playGamesAuthCredential);
        return new zzbf(null, null, playGamesAuthCredential.getProvider(), null, null, playGamesAuthCredential.zzfd);
    }

    @Override // com.google.firebase.auth.AuthCredential
    public String getProvider() {
        return "playgames.google.com";
    }

    @Override // com.google.firebase.auth.AuthCredential
    public String getSignInMethod() {
        return "playgames.google.com";
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzfd, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
