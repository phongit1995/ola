package com.google.android.gms.internal.maps;

import android.os.IBinder;
import android.os.Parcel;
import com.google.android.gms.dynamic.IObjectWrapper;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.LatLngBounds;

/* JADX INFO: loaded from: classes2.dex */
public final class zzm extends zza implements zzk {
    zzm(IBinder iBinder) {
        super(iBinder, "com.google.android.gms.maps.model.internal.IGroundOverlayDelegate");
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final float getBearing() {
        Parcel parcelTransactAndReadException = transactAndReadException(12, obtainAndWriteInterfaceToken());
        float f = parcelTransactAndReadException.readFloat();
        parcelTransactAndReadException.recycle();
        return f;
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final LatLngBounds getBounds() {
        Parcel parcelTransactAndReadException = transactAndReadException(10, obtainAndWriteInterfaceToken());
        LatLngBounds latLngBounds = (LatLngBounds) zzc.zza(parcelTransactAndReadException, LatLngBounds.CREATOR);
        parcelTransactAndReadException.recycle();
        return latLngBounds;
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final float getHeight() {
        Parcel parcelTransactAndReadException = transactAndReadException(8, obtainAndWriteInterfaceToken());
        float f = parcelTransactAndReadException.readFloat();
        parcelTransactAndReadException.recycle();
        return f;
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final String getId() {
        Parcel parcelTransactAndReadException = transactAndReadException(2, obtainAndWriteInterfaceToken());
        String string = parcelTransactAndReadException.readString();
        parcelTransactAndReadException.recycle();
        return string;
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final LatLng getPosition() {
        Parcel parcelTransactAndReadException = transactAndReadException(4, obtainAndWriteInterfaceToken());
        LatLng latLng = (LatLng) zzc.zza(parcelTransactAndReadException, LatLng.CREATOR);
        parcelTransactAndReadException.recycle();
        return latLng;
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final float getTransparency() {
        Parcel parcelTransactAndReadException = transactAndReadException(18, obtainAndWriteInterfaceToken());
        float f = parcelTransactAndReadException.readFloat();
        parcelTransactAndReadException.recycle();
        return f;
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final float getWidth() {
        Parcel parcelTransactAndReadException = transactAndReadException(7, obtainAndWriteInterfaceToken());
        float f = parcelTransactAndReadException.readFloat();
        parcelTransactAndReadException.recycle();
        return f;
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final float getZIndex() {
        Parcel parcelTransactAndReadException = transactAndReadException(14, obtainAndWriteInterfaceToken());
        float f = parcelTransactAndReadException.readFloat();
        parcelTransactAndReadException.recycle();
        return f;
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final boolean isClickable() {
        Parcel parcelTransactAndReadException = transactAndReadException(23, obtainAndWriteInterfaceToken());
        boolean zZza = zzc.zza(parcelTransactAndReadException);
        parcelTransactAndReadException.recycle();
        return zZza;
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final boolean isVisible() {
        Parcel parcelTransactAndReadException = transactAndReadException(16, obtainAndWriteInterfaceToken());
        boolean zZza = zzc.zza(parcelTransactAndReadException);
        parcelTransactAndReadException.recycle();
        return zZza;
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final void remove() {
        transactAndReadExceptionReturnVoid(1, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final void setBearing(float f) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        transactAndReadExceptionReturnVoid(11, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final void setClickable(boolean z) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, z);
        transactAndReadExceptionReturnVoid(22, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final void setDimensions(float f) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        transactAndReadExceptionReturnVoid(5, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final void setPosition(LatLng latLng) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, latLng);
        transactAndReadExceptionReturnVoid(3, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final void setPositionFromBounds(LatLngBounds latLngBounds) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, latLngBounds);
        transactAndReadExceptionReturnVoid(9, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final void setTransparency(float f) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        transactAndReadExceptionReturnVoid(17, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final void setVisible(boolean z) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, z);
        transactAndReadExceptionReturnVoid(15, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final void setZIndex(float f) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        transactAndReadExceptionReturnVoid(13, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final void zza(float f, float f2) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        parcelObtainAndWriteInterfaceToken.writeFloat(f2);
        transactAndReadExceptionReturnVoid(6, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final boolean zzb(zzk zzkVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, zzkVar);
        Parcel parcelTransactAndReadException = transactAndReadException(19, parcelObtainAndWriteInterfaceToken);
        boolean zZza = zzc.zza(parcelTransactAndReadException);
        parcelTransactAndReadException.recycle();
        return zZza;
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final void zze(IObjectWrapper iObjectWrapper) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, iObjectWrapper);
        transactAndReadExceptionReturnVoid(24, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final void zzf(IObjectWrapper iObjectWrapper) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, iObjectWrapper);
        transactAndReadExceptionReturnVoid(21, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final int zzi() {
        Parcel parcelTransactAndReadException = transactAndReadException(20, obtainAndWriteInterfaceToken());
        int i = parcelTransactAndReadException.readInt();
        parcelTransactAndReadException.recycle();
        return i;
    }

    @Override // com.google.android.gms.internal.maps.zzk
    public final IObjectWrapper zzj() {
        Parcel parcelTransactAndReadException = transactAndReadException(25, obtainAndWriteInterfaceToken());
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }
}
