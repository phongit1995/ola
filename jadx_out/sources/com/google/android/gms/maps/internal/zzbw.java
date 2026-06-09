package com.google.android.gms.maps.internal;

import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import com.google.android.gms.dynamic.IObjectWrapper;

/* JADX INFO: loaded from: classes2.dex */
public final class zzbw extends com.google.android.gms.internal.maps.zza implements IStreetViewPanoramaViewDelegate {
    zzbw(IBinder iBinder) {
        super(iBinder, "com.google.android.gms.maps.internal.IStreetViewPanoramaViewDelegate");
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaViewDelegate
    public final IStreetViewPanoramaDelegate getStreetViewPanorama() {
        IStreetViewPanoramaDelegate zzbuVar;
        Parcel parcelTransactAndReadException = transactAndReadException(1, obtainAndWriteInterfaceToken());
        IBinder strongBinder = parcelTransactAndReadException.readStrongBinder();
        if (strongBinder == null) {
            zzbuVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface = strongBinder.queryLocalInterface("com.google.android.gms.maps.internal.IStreetViewPanoramaDelegate");
            zzbuVar = iInterfaceQueryLocalInterface instanceof IStreetViewPanoramaDelegate ? (IStreetViewPanoramaDelegate) iInterfaceQueryLocalInterface : new zzbu(strongBinder);
        }
        parcelTransactAndReadException.recycle();
        return zzbuVar;
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaViewDelegate
    public final void getStreetViewPanoramaAsync(zzbp zzbpVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, zzbpVar);
        transactAndReadExceptionReturnVoid(9, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaViewDelegate
    public final IObjectWrapper getView() {
        Parcel parcelTransactAndReadException = transactAndReadException(8, obtainAndWriteInterfaceToken());
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaViewDelegate
    public final void onCreate(Bundle bundle) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, bundle);
        transactAndReadExceptionReturnVoid(2, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaViewDelegate
    public final void onDestroy() {
        transactAndReadExceptionReturnVoid(5, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaViewDelegate
    public final void onLowMemory() {
        transactAndReadExceptionReturnVoid(6, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaViewDelegate
    public final void onPause() {
        transactAndReadExceptionReturnVoid(4, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaViewDelegate
    public final void onResume() {
        transactAndReadExceptionReturnVoid(3, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaViewDelegate
    public final void onSaveInstanceState(Bundle bundle) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, bundle);
        Parcel parcelTransactAndReadException = transactAndReadException(7, parcelObtainAndWriteInterfaceToken);
        if (parcelTransactAndReadException.readInt() != 0) {
            bundle.readFromParcel(parcelTransactAndReadException);
        }
        parcelTransactAndReadException.recycle();
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaViewDelegate
    public final void onStart() {
        transactAndReadExceptionReturnVoid(10, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaViewDelegate
    public final void onStop() {
        transactAndReadExceptionReturnVoid(11, obtainAndWriteInterfaceToken());
    }
}
