package com.google.android.gms.internal.ads;

import android.os.Bundle;
import android.os.IInterface;
import android.os.Parcel;
import com.google.android.gms.dynamic.IObjectWrapper;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzyg extends zzek implements zzyf {
    public zzyg() {
        super("com.google.android.gms.ads.internal.mediation.client.IUnifiedNativeAdMapper");
    }

    @Override // com.google.android.gms.internal.ads.zzek
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) {
        String headline;
        IInterface iInterfaceZzjz;
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
                iInterfaceZzjz = zzjz();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzjz);
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
                double starRating = getStarRating();
                parcel2.writeNoException();
                parcel2.writeDouble(starRating);
                return true;
            case 9:
                headline = getStore();
                parcel2.writeNoException();
                parcel2.writeString(headline);
                return true;
            case 10:
                headline = getPrice();
                parcel2.writeNoException();
                parcel2.writeString(headline);
                return true;
            case 11:
                iInterfaceZzjz = getVideoController();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzjz);
                return true;
            case 12:
                iInterfaceZzjz = zzkf();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzjz);
                return true;
            case 13:
                iInterfaceZzjz = zzmv();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzjz);
                return true;
            case 14:
                iInterfaceZzjz = zzmw();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzjz);
                return true;
            case 15:
                iInterfaceZzjz = zzke();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzjz);
                return true;
            case 16:
                Bundle extras = getExtras();
                parcel2.writeNoException();
                zzel.zzb(parcel2, extras);
                return true;
            case 17:
                overrideImpressionRecording = getOverrideImpressionRecording();
                parcel2.writeNoException();
                zzel.zza(parcel2, overrideImpressionRecording);
                return true;
            case 18:
                overrideImpressionRecording = getOverrideClickHandling();
                parcel2.writeNoException();
                zzel.zza(parcel2, overrideImpressionRecording);
                return true;
            case 19:
                recordImpression();
                parcel2.writeNoException();
                return true;
            case 20:
                zzj(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                parcel2.writeNoException();
                return true;
            case 21:
                zzb(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                parcel2.writeNoException();
                return true;
            case 22:
                zzl(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                parcel2.writeNoException();
                return true;
            default:
                return false;
        }
    }
}
