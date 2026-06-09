package com.google.android.gms.internal.ads;

import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzrs extends zzek implements zzrr {
    public zzrs() {
        super("com.google.android.gms.ads.internal.formats.client.IUnifiedNativeAd");
    }

    @Override // com.google.android.gms.internal.ads.zzek
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) {
        String headline;
        IInterface iInterfaceZzjz;
        zzro zzrqVar;
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
                headline = getMediationAdapterClassName();
                parcel2.writeNoException();
                parcel2.writeString(headline);
                return true;
            case 13:
                destroy();
                parcel2.writeNoException();
                return true;
            case 14:
                iInterfaceZzjz = zzkf();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzjz);
                return true;
            case 15:
                performClick((Bundle) zzel.zza(parcel, Bundle.CREATOR));
                parcel2.writeNoException();
                return true;
            case 16:
                boolean zRecordImpression = recordImpression((Bundle) zzel.zza(parcel, Bundle.CREATOR));
                parcel2.writeNoException();
                zzel.zza(parcel2, zRecordImpression);
                return true;
            case 17:
                reportTouchEvent((Bundle) zzel.zza(parcel, Bundle.CREATOR));
                parcel2.writeNoException();
                return true;
            case 18:
                iInterfaceZzjz = zzka();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzjz);
                return true;
            case 19:
                iInterfaceZzjz = zzke();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzjz);
                return true;
            case 20:
                Bundle extras = getExtras();
                parcel2.writeNoException();
                zzel.zzb(parcel2, extras);
                return true;
            case 21:
                IBinder strongBinder = parcel.readStrongBinder();
                if (strongBinder == null) {
                    zzrqVar = null;
                } else {
                    IInterface iInterfaceQueryLocalInterface = strongBinder.queryLocalInterface("com.google.android.gms.ads.internal.formats.client.IUnconfirmedClickListener");
                    zzrqVar = iInterfaceQueryLocalInterface instanceof zzro ? (zzro) iInterfaceQueryLocalInterface : new zzrq(strongBinder);
                }
                zza(zzrqVar);
                parcel2.writeNoException();
                return true;
            case 22:
                cancelUnconfirmedClick();
                parcel2.writeNoException();
                return true;
            default:
                return false;
        }
    }
}
