package com.google.android.gms.internal.maps;

import android.os.IBinder;
import android.os.Parcel;
import com.google.android.gms.dynamic.IObjectWrapper;
import com.google.android.gms.maps.model.LatLng;

/* JADX INFO: loaded from: classes2.dex */
public final class zzv extends zza implements zzt {
    zzv(IBinder iBinder) {
        super(iBinder, "com.google.android.gms.maps.model.internal.IMarkerDelegate");
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final float getAlpha() {
        Parcel parcelTransactAndReadException = transactAndReadException(26, obtainAndWriteInterfaceToken());
        float f = parcelTransactAndReadException.readFloat();
        parcelTransactAndReadException.recycle();
        return f;
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final String getId() {
        Parcel parcelTransactAndReadException = transactAndReadException(2, obtainAndWriteInterfaceToken());
        String string = parcelTransactAndReadException.readString();
        parcelTransactAndReadException.recycle();
        return string;
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final LatLng getPosition() {
        Parcel parcelTransactAndReadException = transactAndReadException(4, obtainAndWriteInterfaceToken());
        LatLng latLng = (LatLng) zzc.zza(parcelTransactAndReadException, LatLng.CREATOR);
        parcelTransactAndReadException.recycle();
        return latLng;
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final float getRotation() {
        Parcel parcelTransactAndReadException = transactAndReadException(23, obtainAndWriteInterfaceToken());
        float f = parcelTransactAndReadException.readFloat();
        parcelTransactAndReadException.recycle();
        return f;
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final String getSnippet() {
        Parcel parcelTransactAndReadException = transactAndReadException(8, obtainAndWriteInterfaceToken());
        String string = parcelTransactAndReadException.readString();
        parcelTransactAndReadException.recycle();
        return string;
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final String getTitle() {
        Parcel parcelTransactAndReadException = transactAndReadException(6, obtainAndWriteInterfaceToken());
        String string = parcelTransactAndReadException.readString();
        parcelTransactAndReadException.recycle();
        return string;
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final float getZIndex() {
        Parcel parcelTransactAndReadException = transactAndReadException(28, obtainAndWriteInterfaceToken());
        float f = parcelTransactAndReadException.readFloat();
        parcelTransactAndReadException.recycle();
        return f;
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final void hideInfoWindow() {
        transactAndReadExceptionReturnVoid(12, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final boolean isDraggable() {
        Parcel parcelTransactAndReadException = transactAndReadException(10, obtainAndWriteInterfaceToken());
        boolean zZza = zzc.zza(parcelTransactAndReadException);
        parcelTransactAndReadException.recycle();
        return zZza;
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final boolean isFlat() {
        Parcel parcelTransactAndReadException = transactAndReadException(21, obtainAndWriteInterfaceToken());
        boolean zZza = zzc.zza(parcelTransactAndReadException);
        parcelTransactAndReadException.recycle();
        return zZza;
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final boolean isInfoWindowShown() {
        Parcel parcelTransactAndReadException = transactAndReadException(13, obtainAndWriteInterfaceToken());
        boolean zZza = zzc.zza(parcelTransactAndReadException);
        parcelTransactAndReadException.recycle();
        return zZza;
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final boolean isVisible() {
        Parcel parcelTransactAndReadException = transactAndReadException(15, obtainAndWriteInterfaceToken());
        boolean zZza = zzc.zza(parcelTransactAndReadException);
        parcelTransactAndReadException.recycle();
        return zZza;
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final void remove() {
        transactAndReadExceptionReturnVoid(1, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final void setAlpha(float f) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        transactAndReadExceptionReturnVoid(25, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final void setAnchor(float f, float f2) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        parcelObtainAndWriteInterfaceToken.writeFloat(f2);
        transactAndReadExceptionReturnVoid(19, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final void setDraggable(boolean z) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, z);
        transactAndReadExceptionReturnVoid(9, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final void setFlat(boolean z) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, z);
        transactAndReadExceptionReturnVoid(20, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final void setInfoWindowAnchor(float f, float f2) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        parcelObtainAndWriteInterfaceToken.writeFloat(f2);
        transactAndReadExceptionReturnVoid(24, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final void setPosition(LatLng latLng) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, latLng);
        transactAndReadExceptionReturnVoid(3, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final void setRotation(float f) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        transactAndReadExceptionReturnVoid(22, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final void setSnippet(String str) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        transactAndReadExceptionReturnVoid(7, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final void setTitle(String str) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeString(str);
        transactAndReadExceptionReturnVoid(5, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final void setVisible(boolean z) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, z);
        transactAndReadExceptionReturnVoid(14, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final void setZIndex(float f) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        transactAndReadExceptionReturnVoid(27, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final void showInfoWindow() {
        transactAndReadExceptionReturnVoid(11, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final void zze(IObjectWrapper iObjectWrapper) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, iObjectWrapper);
        transactAndReadExceptionReturnVoid(29, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final void zzg(IObjectWrapper iObjectWrapper) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, iObjectWrapper);
        transactAndReadExceptionReturnVoid(18, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final int zzi() {
        Parcel parcelTransactAndReadException = transactAndReadException(17, obtainAndWriteInterfaceToken());
        int i = parcelTransactAndReadException.readInt();
        parcelTransactAndReadException.recycle();
        return i;
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final IObjectWrapper zzj() {
        Parcel parcelTransactAndReadException = transactAndReadException(30, obtainAndWriteInterfaceToken());
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }

    @Override // com.google.android.gms.internal.maps.zzt
    public final boolean zzj(zzt zztVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, zztVar);
        Parcel parcelTransactAndReadException = transactAndReadException(16, parcelObtainAndWriteInterfaceToken);
        boolean zZza = zzc.zza(parcelTransactAndReadException);
        parcelTransactAndReadException.recycle();
        return zZza;
    }
}
