package com.google.android.gms.auth.account;

import android.accounts.Account;
import android.os.Parcel;

/* JADX INFO: loaded from: classes.dex */
public abstract class zze extends com.google.android.gms.internal.auth.zze implements zzd {
    public zze() {
        super("com.google.android.gms.auth.account.IWorkAccountCallback");
    }

    @Override // com.google.android.gms.internal.auth.zze
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) {
        switch (i) {
            case 1:
                zzf((Account) com.google.android.gms.internal.auth.zzf.zzd(parcel, Account.CREATOR));
                return true;
            case 2:
                zzd(com.google.android.gms.internal.auth.zzf.zzd(parcel));
                return true;
            default:
                return false;
        }
    }
}
