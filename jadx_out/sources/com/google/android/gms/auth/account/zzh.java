package com.google.android.gms.auth.account;

import android.accounts.Account;
import android.os.IBinder;
import android.os.Parcel;

/* JADX INFO: loaded from: classes.dex */
public final class zzh extends com.google.android.gms.internal.auth.zzd implements zzf {
    zzh(IBinder iBinder) {
        super(iBinder, "com.google.android.gms.auth.account.IWorkAccountService");
    }

    @Override // com.google.android.gms.auth.account.zzf
    public final void zzd(zzd zzdVar, Account account) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.auth.zzf.zzd(parcelObtainAndWriteInterfaceToken, zzdVar);
        com.google.android.gms.internal.auth.zzf.zzd(parcelObtainAndWriteInterfaceToken, account);
        transactAndReadExceptionReturnVoid(3, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.auth.account.zzf
    public final void zzd(zzd zzdVar, String str) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.auth.zzf.zzd(parcelObtainAndWriteInterfaceToken, zzdVar);
        parcelObtainAndWriteInterfaceToken.writeString(str);
        transactAndReadExceptionReturnVoid(2, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.auth.account.zzf
    public final void zze(boolean z) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.auth.zzf.zzd(parcelObtainAndWriteInterfaceToken, z);
        transactAndReadExceptionReturnVoid(1, parcelObtainAndWriteInterfaceToken);
    }
}
