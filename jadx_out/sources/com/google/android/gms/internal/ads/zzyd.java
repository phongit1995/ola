package com.google.android.gms.internal.ads;

import android.os.Bundle;
import android.os.IInterface;
import android.os.Parcel;
import com.google.android.gms.dynamic.IObjectWrapper;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzyd extends zzek implements zzyc {
    public zzyd() {
        super("com.google.android.gms.ads.internal.mediation.client.INativeContentAdMapper");
    }

    @Override // com.google.android.gms.internal.ads.zzek
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) {
        String headline;
        IInterface iInterfaceZzkg;
        boolean overrideImpressionRecording;
        switch (i) {
            case 2:
                headline = getHeadline();
                parcel2.writeNoException();
                parcel2.writeString(headline);
                return true;
            case 3:
                List images = getImages();
                parcel2.writeNoException();
                parcel2.writeList(images);
                return true;
            case 4:
                headline = getBody();
                parcel2.writeNoException();
                parcel2.writeString(headline);
                return true;
            case 5:
                iInterfaceZzkg = zzkg();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzkg);
                return true;
            case 6:
                headline = getCallToAction();
                parcel2.writeNoException();
                parcel2.writeString(headline);
                return true;
            case 7:
                headline = getAdvertiser();
                parcel2.writeNoException();
                parcel2.writeString(headline);
                return true;
            case 8:
                recordImpression();
                parcel2.writeNoException();
                return true;
            case 9:
                zzj(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                parcel2.writeNoException();
                return true;
            case 10:
                zzk(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                parcel2.writeNoException();
                return true;
            case 11:
                overrideImpressionRecording = getOverrideImpressionRecording();
                parcel2.writeNoException();
                zzel.zza(parcel2, overrideImpressionRecording);
                return true;
            case 12:
                overrideImpressionRecording = getOverrideClickHandling();
                parcel2.writeNoException();
                zzel.zza(parcel2, overrideImpressionRecording);
                return true;
            case 13:
                Bundle extras = getExtras();
                parcel2.writeNoException();
                zzel.zzb(parcel2, extras);
                return true;
            case 14:
                zzl(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                parcel2.writeNoException();
                return true;
            case 15:
                iInterfaceZzkg = zzmv();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzkg);
                return true;
            case 16:
                iInterfaceZzkg = getVideoController();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzkg);
                return true;
            case 17:
            case 18:
            default:
                return false;
            case 19:
                iInterfaceZzkg = zzkf();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzkg);
                return true;
            case 20:
                iInterfaceZzkg = zzmw();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzkg);
                return true;
            case 21:
                iInterfaceZzkg = zzke();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzkg);
                return true;
            case 22:
                zzb(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                parcel2.writeNoException();
                return true;
        }
    }
}
