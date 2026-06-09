package com.google.android.gms.internal.ads;

import android.os.Bundle;
import android.os.IInterface;
import android.os.Parcel;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzql extends zzek implements zzqk {
    public zzql() {
        super("com.google.android.gms.ads.internal.formats.client.INativeAppInstallAd");
    }

    @Override // com.google.android.gms.internal.ads.zzek
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) {
        IInterface iInterfaceZzka;
        String headline;
        switch (i) {
            case 2:
                iInterfaceZzka = zzka();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzka);
                return true;
            case 3:
                headline = getHeadline();
                parcel2.writeNoException();
                parcel2.writeString(headline);
                return true;
            case 4:
                List images = getImages();
                parcel2.writeNoException();
                parcel2.writeList(images);
                return true;
            case 5:
                headline = getBody();
                parcel2.writeNoException();
                parcel2.writeString(headline);
                return true;
            case 6:
                iInterfaceZzka = zzjz();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzka);
                return true;
            case 7:
                headline = getCallToAction();
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
                Bundle extras = getExtras();
                parcel2.writeNoException();
                zzel.zzb(parcel2, extras);
                return true;
            case 12:
                destroy();
                parcel2.writeNoException();
                return true;
            case 13:
                iInterfaceZzka = getVideoController();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzka);
                return true;
            case 14:
                performClick((Bundle) zzel.zza(parcel, Bundle.CREATOR));
                parcel2.writeNoException();
                return true;
            case 15:
                boolean zRecordImpression = recordImpression((Bundle) zzel.zza(parcel, Bundle.CREATOR));
                parcel2.writeNoException();
                zzel.zza(parcel2, zRecordImpression);
                return true;
            case 16:
                reportTouchEvent((Bundle) zzel.zza(parcel, Bundle.CREATOR));
                parcel2.writeNoException();
                return true;
            case 17:
                iInterfaceZzka = zzkf();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzka);
                return true;
            case 18:
                iInterfaceZzka = zzke();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzka);
                return true;
            case 19:
                headline = getMediationAdapterClassName();
                parcel2.writeNoException();
                parcel2.writeString(headline);
                return true;
            default:
                return false;
        }
    }
}
