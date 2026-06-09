package com.google.android.gms.maps.internal;

import android.os.IBinder;
import android.os.Parcel;
import com.google.android.gms.dynamic.IObjectWrapper;
import com.google.android.gms.maps.model.CameraPosition;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.LatLngBounds;

/* JADX INFO: loaded from: classes2.dex */
public final class zzb extends com.google.android.gms.internal.maps.zza implements ICameraUpdateFactoryDelegate {
    zzb(IBinder iBinder) {
        super(iBinder, "com.google.android.gms.maps.internal.ICameraUpdateFactoryDelegate");
    }

    @Override // com.google.android.gms.maps.internal.ICameraUpdateFactoryDelegate
    public final IObjectWrapper newCameraPosition(CameraPosition cameraPosition) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, cameraPosition);
        Parcel parcelTransactAndReadException = transactAndReadException(7, parcelObtainAndWriteInterfaceToken);
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }

    @Override // com.google.android.gms.maps.internal.ICameraUpdateFactoryDelegate
    public final IObjectWrapper newLatLng(LatLng latLng) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, latLng);
        Parcel parcelTransactAndReadException = transactAndReadException(8, parcelObtainAndWriteInterfaceToken);
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }

    @Override // com.google.android.gms.maps.internal.ICameraUpdateFactoryDelegate
    public final IObjectWrapper newLatLngBounds(LatLngBounds latLngBounds, int i) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, latLngBounds);
        parcelObtainAndWriteInterfaceToken.writeInt(i);
        Parcel parcelTransactAndReadException = transactAndReadException(10, parcelObtainAndWriteInterfaceToken);
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }

    @Override // com.google.android.gms.maps.internal.ICameraUpdateFactoryDelegate
    public final IObjectWrapper newLatLngBoundsWithSize(LatLngBounds latLngBounds, int i, int i2, int i3) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, latLngBounds);
        parcelObtainAndWriteInterfaceToken.writeInt(i);
        parcelObtainAndWriteInterfaceToken.writeInt(i2);
        parcelObtainAndWriteInterfaceToken.writeInt(i3);
        Parcel parcelTransactAndReadException = transactAndReadException(11, parcelObtainAndWriteInterfaceToken);
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }

    @Override // com.google.android.gms.maps.internal.ICameraUpdateFactoryDelegate
    public final IObjectWrapper newLatLngZoom(LatLng latLng, float f) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.maps.zzc.zza(parcelObtainAndWriteInterfaceToken, latLng);
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        Parcel parcelTransactAndReadException = transactAndReadException(9, parcelObtainAndWriteInterfaceToken);
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }

    @Override // com.google.android.gms.maps.internal.ICameraUpdateFactoryDelegate
    public final IObjectWrapper scrollBy(float f, float f2) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        parcelObtainAndWriteInterfaceToken.writeFloat(f2);
        Parcel parcelTransactAndReadException = transactAndReadException(3, parcelObtainAndWriteInterfaceToken);
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }

    @Override // com.google.android.gms.maps.internal.ICameraUpdateFactoryDelegate
    public final IObjectWrapper zoomBy(float f) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        Parcel parcelTransactAndReadException = transactAndReadException(5, parcelObtainAndWriteInterfaceToken);
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }

    @Override // com.google.android.gms.maps.internal.ICameraUpdateFactoryDelegate
    public final IObjectWrapper zoomByWithFocus(float f, int i, int i2) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        parcelObtainAndWriteInterfaceToken.writeInt(i);
        parcelObtainAndWriteInterfaceToken.writeInt(i2);
        Parcel parcelTransactAndReadException = transactAndReadException(6, parcelObtainAndWriteInterfaceToken);
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }

    @Override // com.google.android.gms.maps.internal.ICameraUpdateFactoryDelegate
    public final IObjectWrapper zoomIn() {
        Parcel parcelTransactAndReadException = transactAndReadException(1, obtainAndWriteInterfaceToken());
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }

    @Override // com.google.android.gms.maps.internal.ICameraUpdateFactoryDelegate
    public final IObjectWrapper zoomOut() {
        Parcel parcelTransactAndReadException = transactAndReadException(2, obtainAndWriteInterfaceToken());
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }

    @Override // com.google.android.gms.maps.internal.ICameraUpdateFactoryDelegate
    public final IObjectWrapper zoomTo(float f) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        Parcel parcelTransactAndReadException = transactAndReadException(4, parcelObtainAndWriteInterfaceToken);
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }
}
