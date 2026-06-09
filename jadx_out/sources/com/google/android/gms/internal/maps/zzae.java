package com.google.android.gms.internal.maps;

import android.os.IBinder;
import android.os.Parcel;

/* JADX INFO: loaded from: classes2.dex */
public final class zzae extends zza implements zzac {
    zzae(IBinder iBinder) {
        super(iBinder, "com.google.android.gms.maps.model.internal.ITileOverlayDelegate");
    }

    @Override // com.google.android.gms.internal.maps.zzac
    public final void clearTileCache() {
        transactAndReadExceptionReturnVoid(2, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.internal.maps.zzac
    public final boolean getFadeIn() {
        Parcel parcelTransactAndReadException = transactAndReadException(11, obtainAndWriteInterfaceToken());
        boolean zZza = zzc.zza(parcelTransactAndReadException);
        parcelTransactAndReadException.recycle();
        return zZza;
    }

    @Override // com.google.android.gms.internal.maps.zzac
    public final String getId() {
        Parcel parcelTransactAndReadException = transactAndReadException(3, obtainAndWriteInterfaceToken());
        String string = parcelTransactAndReadException.readString();
        parcelTransactAndReadException.recycle();
        return string;
    }

    @Override // com.google.android.gms.internal.maps.zzac
    public final float getTransparency() {
        Parcel parcelTransactAndReadException = transactAndReadException(13, obtainAndWriteInterfaceToken());
        float f = parcelTransactAndReadException.readFloat();
        parcelTransactAndReadException.recycle();
        return f;
    }

    @Override // com.google.android.gms.internal.maps.zzac
    public final float getZIndex() {
        Parcel parcelTransactAndReadException = transactAndReadException(5, obtainAndWriteInterfaceToken());
        float f = parcelTransactAndReadException.readFloat();
        parcelTransactAndReadException.recycle();
        return f;
    }

    @Override // com.google.android.gms.internal.maps.zzac
    public final boolean isVisible() {
        Parcel parcelTransactAndReadException = transactAndReadException(7, obtainAndWriteInterfaceToken());
        boolean zZza = zzc.zza(parcelTransactAndReadException);
        parcelTransactAndReadException.recycle();
        return zZza;
    }

    @Override // com.google.android.gms.internal.maps.zzac
    public final void remove() {
        transactAndReadExceptionReturnVoid(1, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.internal.maps.zzac
    public final void setFadeIn(boolean z) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, z);
        transactAndReadExceptionReturnVoid(10, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzac
    public final void setTransparency(float f) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        transactAndReadExceptionReturnVoid(12, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzac
    public final void setVisible(boolean z) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, z);
        transactAndReadExceptionReturnVoid(6, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzac
    public final void setZIndex(float f) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        parcelObtainAndWriteInterfaceToken.writeFloat(f);
        transactAndReadExceptionReturnVoid(4, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.maps.zzac
    public final boolean zza(zzac zzacVar) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzc.zza(parcelObtainAndWriteInterfaceToken, zzacVar);
        Parcel parcelTransactAndReadException = transactAndReadException(8, parcelObtainAndWriteInterfaceToken);
        boolean zZza = zzc.zza(parcelTransactAndReadException);
        parcelTransactAndReadException.recycle();
        return zZza;
    }

    @Override // com.google.android.gms.internal.maps.zzac
    public final int zzi() {
        Parcel parcelTransactAndReadException = transactAndReadException(9, obtainAndWriteInterfaceToken());
        int i = parcelTransactAndReadException.readInt();
        parcelTransactAndReadException.recycle();
        return i;
    }
}
