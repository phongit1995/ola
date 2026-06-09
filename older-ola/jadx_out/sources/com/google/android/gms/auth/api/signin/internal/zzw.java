package com.google.android.gms.auth.api.signin.internal;

import android.os.IBinder;
import android.os.Parcel;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;

/* JADX INFO: loaded from: classes.dex */
public final class zzw extends com.google.android.gms.internal.auth.zzd implements zzv {
    zzw(IBinder iBinder) {
        super(iBinder, "com.google.android.gms.auth.api.signin.internal.ISignInService");
    }

    @Override // com.google.android.gms.auth.api.signin.internal.zzv
    public final void zzd(zzt zztVar, GoogleSignInOptions googleSignInOptions) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.auth.zzf.zzd(parcelObtainAndWriteInterfaceToken, zztVar);
        com.google.android.gms.internal.auth.zzf.zzd(parcelObtainAndWriteInterfaceToken, googleSignInOptions);
        transactAndReadExceptionReturnVoid(101, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.auth.api.signin.internal.zzv
    public final void zze(zzt zztVar, GoogleSignInOptions googleSignInOptions) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.auth.zzf.zzd(parcelObtainAndWriteInterfaceToken, zztVar);
        com.google.android.gms.internal.auth.zzf.zzd(parcelObtainAndWriteInterfaceToken, googleSignInOptions);
        transactAndReadExceptionReturnVoid(102, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.auth.api.signin.internal.zzv
    public final void zzf(zzt zztVar, GoogleSignInOptions googleSignInOptions) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.auth.zzf.zzd(parcelObtainAndWriteInterfaceToken, zztVar);
        com.google.android.gms.internal.auth.zzf.zzd(parcelObtainAndWriteInterfaceToken, googleSignInOptions);
        transactAndReadExceptionReturnVoid(103, parcelObtainAndWriteInterfaceToken);
    }
}
