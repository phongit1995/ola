package com.google.android.gms.auth.api.signin.internal;

import android.os.Parcel;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzs extends com.google.android.gms.internal.auth.zze implements zzr {
    public zzs() {
        super("com.google.android.gms.auth.api.signin.internal.IRevocationService");
    }

    @Override // com.google.android.gms.internal.auth.zze
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) {
        switch (i) {
            case 1:
                zzq();
                return true;
            case 2:
                zzr();
                return true;
            default:
                return false;
        }
    }
}
