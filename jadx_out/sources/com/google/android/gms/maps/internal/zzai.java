package com.google.android.gms.maps.internal;

import android.location.Location;
import android.os.IBinder;
import android.os.Parcel;

/* JADX INFO: loaded from: classes2.dex */
public final class zzai extends com.google.android.gms.internal.maps.zza implements zzah {
    zzai(IBinder iBinder) {
        super(iBinder, "com.google.android.gms.maps.internal.IOnLocationChangeListener");
    }

    @Override // com.google.android.gms.maps.internal.zzah
    public final void zza(Location location) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, location);
        transactAndReadExceptionReturnVoid(2, parcelObtainAndWriteInterfaceToken);
    }
}
