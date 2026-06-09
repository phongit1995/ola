package com.google.android.gms.auth.account;

import android.os.IBinder;
import android.os.IInterface;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzg extends com.google.android.gms.internal.auth.zze implements zzf {
    public static zzf zzf(IBinder iBinder) {
        if (iBinder == null) {
            return null;
        }
        IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.auth.account.IWorkAccountService");
        return iInterfaceQueryLocalInterface instanceof zzf ? (zzf) iInterfaceQueryLocalInterface : new zzh(iBinder);
    }
}
