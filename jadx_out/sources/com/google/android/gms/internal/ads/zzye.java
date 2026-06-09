package com.google.android.gms.internal.ads;

import android.os.Bundle;
import android.os.IBinder;
import android.os.Parcel;
import com.google.android.gms.dynamic.IObjectWrapper;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public final class zzye extends zzej implements zzyc {
    zzye(IBinder iBinder) {
        super(iBinder, "com.google.android.gms.ads.internal.mediation.client.INativeContentAdMapper");
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final String getAdvertiser() {
        Parcel parcelTransactAndReadException = transactAndReadException(7, obtainAndWriteInterfaceToken());
        String string = parcelTransactAndReadException.readString();
        parcelTransactAndReadException.recycle();
        return string;
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final String getBody() {
        Parcel parcelTransactAndReadException = transactAndReadException(4, obtainAndWriteInterfaceToken());
        String string = parcelTransactAndReadException.readString();
        parcelTransactAndReadException.recycle();
        return string;
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final String getCallToAction() {
        Parcel parcelTransactAndReadException = transactAndReadException(6, obtainAndWriteInterfaceToken());
        String string = parcelTransactAndReadException.readString();
        parcelTransactAndReadException.recycle();
        return string;
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final Bundle getExtras() {
        Parcel parcelTransactAndReadException = transactAndReadException(13, obtainAndWriteInterfaceToken());
        Bundle bundle = (Bundle) zzel.zza(parcelTransactAndReadException, Bundle.CREATOR);
        parcelTransactAndReadException.recycle();
        return bundle;
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final String getHeadline() {
        Parcel parcelTransactAndReadException = transactAndReadException(2, obtainAndWriteInterfaceToken());
        String string = parcelTransactAndReadException.readString();
        parcelTransactAndReadException.recycle();
        return string;
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final List getImages() {
        Parcel parcelTransactAndReadException = transactAndReadException(3, obtainAndWriteInterfaceToken());
        ArrayList arrayListZzb = zzel.zzb(parcelTransactAndReadException);
        parcelTransactAndReadException.recycle();
        return arrayListZzb;
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final boolean getOverrideClickHandling() {
        Parcel parcelTransactAndReadException = transactAndReadException(12, obtainAndWriteInterfaceToken());
        boolean zZza = zzel.zza(parcelTransactAndReadException);
        parcelTransactAndReadException.recycle();
        return zZza;
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final boolean getOverrideImpressionRecording() {
        Parcel parcelTransactAndReadException = transactAndReadException(11, obtainAndWriteInterfaceToken());
        boolean zZza = zzel.zza(parcelTransactAndReadException);
        parcelTransactAndReadException.recycle();
        return zZza;
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final zzlo getVideoController() {
        Parcel parcelTransactAndReadException = transactAndReadException(16, obtainAndWriteInterfaceToken());
        zzlo zzloVarZze = zzlp.zze(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return zzloVarZze;
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final void recordImpression() {
        transactAndReadExceptionReturnVoid(8, obtainAndWriteInterfaceToken());
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final void zzb(IObjectWrapper iObjectWrapper, IObjectWrapper iObjectWrapper2, IObjectWrapper iObjectWrapper3) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzel.zza(parcelObtainAndWriteInterfaceToken, iObjectWrapper);
        zzel.zza(parcelObtainAndWriteInterfaceToken, iObjectWrapper2);
        zzel.zza(parcelObtainAndWriteInterfaceToken, iObjectWrapper3);
        transactAndReadExceptionReturnVoid(22, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final void zzj(IObjectWrapper iObjectWrapper) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzel.zza(parcelObtainAndWriteInterfaceToken, iObjectWrapper);
        transactAndReadExceptionReturnVoid(9, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final void zzk(IObjectWrapper iObjectWrapper) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzel.zza(parcelObtainAndWriteInterfaceToken, iObjectWrapper);
        transactAndReadExceptionReturnVoid(10, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final IObjectWrapper zzke() {
        Parcel parcelTransactAndReadException = transactAndReadException(21, obtainAndWriteInterfaceToken());
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final zzps zzkf() {
        Parcel parcelTransactAndReadException = transactAndReadException(19, obtainAndWriteInterfaceToken());
        zzps zzpsVarZzg = zzpt.zzg(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return zzpsVarZzg;
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final zzpw zzkg() {
        Parcel parcelTransactAndReadException = transactAndReadException(5, obtainAndWriteInterfaceToken());
        zzpw zzpwVarZzh = zzpx.zzh(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return zzpwVarZzh;
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final void zzl(IObjectWrapper iObjectWrapper) {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        zzel.zza(parcelObtainAndWriteInterfaceToken, iObjectWrapper);
        transactAndReadExceptionReturnVoid(14, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final IObjectWrapper zzmv() {
        Parcel parcelTransactAndReadException = transactAndReadException(15, obtainAndWriteInterfaceToken());
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }

    @Override // com.google.android.gms.internal.ads.zzyc
    public final IObjectWrapper zzmw() {
        Parcel parcelTransactAndReadException = transactAndReadException(20, obtainAndWriteInterfaceToken());
        IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcelTransactAndReadException.readStrongBinder());
        parcelTransactAndReadException.recycle();
        return iObjectWrapperAsInterface;
    }
}
