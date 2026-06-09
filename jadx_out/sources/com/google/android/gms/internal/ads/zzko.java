package com.google.android.gms.internal.ads;

import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import com.google.android.gms.ads.formats.PublisherAdViewOptions;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzko extends zzek implements zzkn {
    public zzko() {
        super("com.google.android.gms.ads.internal.client.IAdLoaderBuilder");
    }

    @Override // com.google.android.gms.internal.ads.zzek
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) {
        zzkh zzkjVar = null;
        zzlg zzliVar = null;
        switch (i) {
            case 1:
                zzkk zzkkVarZzdh = zzdh();
                parcel2.writeNoException();
                zzel.zza(parcel2, zzkkVarZzdh);
                return true;
            case 2:
                IBinder strongBinder = parcel.readStrongBinder();
                if (strongBinder != null) {
                    IInterface iInterfaceQueryLocalInterface = strongBinder.queryLocalInterface("com.google.android.gms.ads.internal.client.IAdListener");
                    zzkjVar = iInterfaceQueryLocalInterface instanceof zzkh ? (zzkh) iInterfaceQueryLocalInterface : new zzkj(strongBinder);
                }
                zzb(zzkjVar);
                break;
            case 3:
                zza(zzqx.zzl(parcel.readStrongBinder()));
                break;
            case 4:
                zza(zzra.zzm(parcel.readStrongBinder()));
                break;
            case 5:
                zza(parcel.readString(), zzrg.zzo(parcel.readStrongBinder()), zzrd.zzn(parcel.readStrongBinder()));
                break;
            case 6:
                zza((zzpl) zzel.zza(parcel, zzpl.CREATOR));
                break;
            case 7:
                IBinder strongBinder2 = parcel.readStrongBinder();
                if (strongBinder2 != null) {
                    IInterface iInterfaceQueryLocalInterface2 = strongBinder2.queryLocalInterface("com.google.android.gms.ads.internal.client.ICorrelationIdProvider");
                    zzliVar = iInterfaceQueryLocalInterface2 instanceof zzlg ? (zzlg) iInterfaceQueryLocalInterface2 : new zzli(strongBinder2);
                }
                zzb(zzliVar);
                break;
            case 8:
                zza(zzrj.zzp(parcel.readStrongBinder()), (zzjn) zzel.zza(parcel, zzjn.CREATOR));
                break;
            case 9:
                zza((PublisherAdViewOptions) zzel.zza(parcel, PublisherAdViewOptions.CREATOR));
                break;
            case 10:
                zza(zzrm.zzq(parcel.readStrongBinder()));
                break;
            default:
                return false;
        }
        parcel2.writeNoException();
        return true;
    }
}
