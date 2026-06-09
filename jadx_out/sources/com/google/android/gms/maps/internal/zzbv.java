package com.google.android.gms.maps.internal;

import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import com.google.android.gms.dynamic.IObjectWrapper;
import com.google.android.gms.maps.StreetViewPanoramaOptions;

/* JADX INFO: loaded from: classes2.dex */
public final class zzbv extends com.google.android.gms.internal.maps.zza implements IStreetViewPanoramaFragmentDelegate {
    zzbv(IBinder iBinder) {
        super(iBinder, "com.google.android.gms.maps.internal.IStreetViewPanoramaFragmentDelegate");
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaFragmentDelegate
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

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaFragmentDelegate
    public final void getStreetViewPanoramaAsync(zzbp zzbpVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, zzbpVar);
        transactAndReadExceptionReturnVoid(12, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaFragmentDelegate
    public final boolean isReady() {
        Parcel parcelTransactAndReadException = transactAndReadException(11, obtainAndWriteInterfaceToken());
        boolean zZza = com.google.android.gms.internal.maps.zzc.zza(parcelTransactAndReadException);
        parcelTransactAndReadException.recycle();
        return zZza;
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaFragmentDelegate
    public final void onCreate(Bundle bundle) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, bundle);
        transactAndReadExceptionReturnVoid(3, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaFragmentDelegate
    public final IObjectWrapper onCreateView(IObjectWrapper iObjectWrapper, IObjectWrapper iObjectWrapper2, Bundle bundle) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, iObjectWrapper);
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, iObjectWrapper2);
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, bundle);
        Parcel parcelTransactAndReadException = transactAndReadException(4, parcelObtainAndWriteInterfaceToken);
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaFragmentDelegate
    public final void onDestroy() {
        transactAndReadExceptionReturnVoid(8, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaFragmentDelegate
    public final void onDestroyView() {
        transactAndReadExceptionReturnVoid(7, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaFragmentDelegate
    public final void onInflate(IObjectWrapper iObjectWrapper, StreetViewPanoramaOptions streetViewPanoramaOptions, Bundle bundle) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, iObjectWrapper);
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, streetViewPanoramaOptions);
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, bundle);
        transactAndReadExceptionReturnVoid(2, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaFragmentDelegate
    public final void onLowMemory() {
        transactAndReadExceptionReturnVoid(9, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaFragmentDelegate
    public final void onPause() {
        transactAndReadExceptionReturnVoid(6, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaFragmentDelegate
    public final void onResume() {
        transactAndReadExceptionReturnVoid(5, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaFragmentDelegate
    public final void onSaveInstanceState(Bundle bundle) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, bundle);
        Parcel parcelTransactAndReadException = transactAndReadException(10, parcelObtainAndWriteInterfaceToken);
        if (parcelTransactAndReadException.readInt() != 0) {
            bundle.readFromParcel(parcelTransactAndReadException);
        }
        parcelTransactAndReadException.recycle();
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaFragmentDelegate
    public final void onStart() {
        transactAndReadExceptionReturnVoid(13, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.maps.internal.IStreetViewPanoramaFragmentDelegate
    public final void onStop() {
        transactAndReadExceptionReturnVoid(14, obtainAndWriteInterfaceToken());
    }
}
