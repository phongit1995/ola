package com.google.android.gms.maps.internal;

import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import com.google.android.gms.dynamic.IObjectWrapper;

/* JADX INFO: loaded from: classes2.dex */
public final class zzk extends com.google.android.gms.internal.maps.zza implements IMapViewDelegate {
    zzk(IBinder iBinder) {
        super(iBinder, "com.google.android.gms.maps.internal.IMapViewDelegate");
    }

    @Override // com.google.android.gms.maps.internal.IMapViewDelegate
    public final IGoogleMapDelegate getMap() {
        IGoogleMapDelegate zzgVar;
        Parcel parcelTransactAndReadException = transactAndReadException(1, obtainAndWriteInterfaceToken());
        IBinder strongBinder = parcelTransactAndReadException.readStrongBinder();
        if (strongBinder == null) {
            zzgVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface = strongBinder.queryLocalInterface("com.google.android.gms.maps.internal.IGoogleMapDelegate");
            zzgVar = iInterfaceQueryLocalInterface instanceof IGoogleMapDelegate ? (IGoogleMapDelegate) iInterfaceQueryLocalInterface : new zzg(strongBinder);
        }
        parcelTransactAndReadException.recycle();
        return zzgVar;
    }

    @Override // com.google.android.gms.maps.internal.IMapViewDelegate
    public final void getMapAsync(zzap zzapVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, zzapVar);
        transactAndReadExceptionReturnVoid(9, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.maps.internal.IMapViewDelegate
    public final IObjectWrapper getView() {
        Parcel parcelTransactAndReadException = transactAndReadException(8, obtainAndWriteInterfaceToken());
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }

    @Override // com.google.android.gms.maps.internal.IMapViewDelegate
    public final void onCreate(Bundle bundle) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, bundle);
        transactAndReadExceptionReturnVoid(2, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.maps.internal.IMapViewDelegate
    public final void onDestroy() {
        transactAndReadExceptionReturnVoid(5, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IMapViewDelegate
    public final void onEnterAmbient(Bundle bundle) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, bundle);
        transactAndReadExceptionReturnVoid(10, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.maps.internal.IMapViewDelegate
    public final void onExitAmbient() {
        transactAndReadExceptionReturnVoid(11, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IMapViewDelegate
    public final void onLowMemory() {
        transactAndReadExceptionReturnVoid(6, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IMapViewDelegate
    public final void onPause() {
        transactAndReadExceptionReturnVoid(4, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IMapViewDelegate
    public final void onResume() {
        transactAndReadExceptionReturnVoid(3, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IMapViewDelegate
    public final void onSaveInstanceState(Bundle bundle) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, bundle);
        Parcel parcelTransactAndReadException = transactAndReadException(7, parcelObtainAndWriteInterfaceToken);
        if (parcelTransactAndReadException.readInt() != 0) {
            bundle.readFromParcel(parcelTransactAndReadException);
        }
        parcelTransactAndReadException.recycle();
    }

    @Override // com.google.android.gms.maps.internal.IMapViewDelegate
    public final void onStart() {
        transactAndReadExceptionReturnVoid(12, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IMapViewDelegate
    public final void onStop() {
        transactAndReadExceptionReturnVoid(13, obtainAndWriteInterfaceToken());
    }
}
