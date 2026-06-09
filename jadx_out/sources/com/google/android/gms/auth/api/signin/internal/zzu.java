package com.google.android.gms.auth.api.signin.internal;

import android.os.Parcel;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.common.api.Status;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzu extends com.google.android.gms.internal.auth.zze implements zzt {
    public zzu() {
        super("com.google.android.gms.auth.api.signin.internal.ISignInCallbacks");
    }

    @Override // com.google.android.gms.internal.auth.zze
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) {
        switch (i) {
            case 101:
                zzd((GoogleSignInAccount) com.google.android.gms.internal.auth.zzf.zzd(parcel, GoogleSignInAccount.CREATOR), (Status) com.google.android.gms.internal.auth.zzf.zzd(parcel, Status.CREATOR));
                break;
            case 102:
                zzg((Status) com.google.android.gms.internal.auth.zzf.zzd(parcel, Status.CREATOR));
                break;
            case 103:
                zzh((Status) com.google.android.gms.internal.auth.zzf.zzd(parcel, Status.CREATOR));
                break;
            default:
                return false;
        }
        parcel2.writeNoException();
        return true;
    }
}
