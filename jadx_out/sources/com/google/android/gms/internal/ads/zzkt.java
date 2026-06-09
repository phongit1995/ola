package com.google.android.gms.internal.ads;

import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.Parcelable;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzkt extends zzek implements zzks {
    public zzkt() {
        super("com.google.android.gms.ads.internal.client.IAdManager");
    }

    public static zzks zzb(IBinder iBinder) {
        if (iBinder == null) {
            return null;
        }
        IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.ads.internal.client.IAdManager");
        return iInterfaceQueryLocalInterface instanceof zzks ? (zzks) iInterfaceQueryLocalInterface : new zzku(iBinder);
    }

    @Override // com.google.android.gms.internal.ads.zzek
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) {
        IInterface iInterfaceZzbj;
        boolean zIsReady;
        Parcelable parcelableZzbk;
        String mediationAdapterClassName;
        zzkh zzkjVar = null;
        zzkx zzkzVar = null;
        zzlg zzliVar = null;
        zzke zzkgVar = null;
        zzla zzlcVar = null;
        switch (i) {
            case 1:
                iInterfaceZzbj = zzbj();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzbj);
                return true;
            case 2:
                destroy();
                parcel2.writeNoException();
                return true;
            case 3:
                zIsReady = isReady();
                parcel2.writeNoException();
                zzel.zza(parcel2, zIsReady);
                return true;
            case 4:
                zIsReady = zzb((zzjj) zzel.zza(parcel, zzjj.CREATOR));
                parcel2.writeNoException();
                zzel.zza(parcel2, zIsReady);
                return true;
            case 5:
                pause();
                parcel2.writeNoException();
                return true;
            case 6:
                resume();
                parcel2.writeNoException();
                return true;
            case 7:
                IBinder strongBinder = parcel.readStrongBinder();
                if (strongBinder != null) {
                    IInterface iInterfaceQueryLocalInterface = strongBinder.queryLocalInterface("com.google.android.gms.ads.internal.client.IAdListener");
                    zzkjVar = iInterfaceQueryLocalInterface instanceof zzkh ? (zzkh) iInterfaceQueryLocalInterface : new zzkj(strongBinder);
                }
                zza(zzkjVar);
                parcel2.writeNoException();
                return true;
            case 8:
                IBinder strongBinder2 = parcel.readStrongBinder();
                if (strongBinder2 != null) {
                    IInterface iInterfaceQueryLocalInterface2 = strongBinder2.queryLocalInterface("com.google.android.gms.ads.internal.client.IAppEventListener");
                    zzlcVar = iInterfaceQueryLocalInterface2 instanceof zzla ? (zzla) iInterfaceQueryLocalInterface2 : new zzlc(strongBinder2);
                }
                zza(zzlcVar);
                parcel2.writeNoException();
                return true;
            case 9:
                showInterstitial();
                parcel2.writeNoException();
                return true;
            case 10:
                stopLoading();
                parcel2.writeNoException();
                return true;
            case 11:
                zzbm();
                parcel2.writeNoException();
                return true;
            case 12:
                parcelableZzbk = zzbk();
                parcel2.writeNoException();
                zzel.zzb(parcel2, parcelableZzbk);
                return true;
            case 13:
                zza((zzjn) zzel.zza(parcel, zzjn.CREATOR));
                parcel2.writeNoException();
                return true;
            case 14:
                zza(zzaax.zzv(parcel.readStrongBinder()));
                parcel2.writeNoException();
                return true;
            case 15:
                zza(zzabd.zzx(parcel.readStrongBinder()), parcel.readString());
                parcel2.writeNoException();
                return true;
            case 16:
            case 17:
            case 27:
            case 28:
            default:
                return false;
            case 18:
                mediationAdapterClassName = getMediationAdapterClassName();
                parcel2.writeNoException();
                parcel2.writeString(mediationAdapterClassName);
                return true;
            case 19:
                zza(zzoe.zzf(parcel.readStrongBinder()));
                parcel2.writeNoException();
                return true;
            case 20:
                IBinder strongBinder3 = parcel.readStrongBinder();
                if (strongBinder3 != null) {
                    IInterface iInterfaceQueryLocalInterface3 = strongBinder3.queryLocalInterface("com.google.android.gms.ads.internal.client.IAdClickListener");
                    zzkgVar = iInterfaceQueryLocalInterface3 instanceof zzke ? (zzke) iInterfaceQueryLocalInterface3 : new zzkg(strongBinder3);
                }
                zza(zzkgVar);
                parcel2.writeNoException();
                return true;
            case 21:
                IBinder strongBinder4 = parcel.readStrongBinder();
                if (strongBinder4 != null) {
                    IInterface iInterfaceQueryLocalInterface4 = strongBinder4.queryLocalInterface("com.google.android.gms.ads.internal.client.ICorrelationIdProvider");
                    zzliVar = iInterfaceQueryLocalInterface4 instanceof zzlg ? (zzlg) iInterfaceQueryLocalInterface4 : new zzli(strongBinder4);
                }
                zza(zzliVar);
                parcel2.writeNoException();
                return true;
            case 22:
                setManualImpressionsEnabled(zzel.zza(parcel));
                parcel2.writeNoException();
                return true;
            case 23:
                zIsReady = isLoading();
                parcel2.writeNoException();
                zzel.zza(parcel2, zIsReady);
                return true;
            case 24:
                zza(zzahf.zzz(parcel.readStrongBinder()));
                parcel2.writeNoException();
                return true;
            case 25:
                setUserId(parcel.readString());
                parcel2.writeNoException();
                return true;
            case 26:
                iInterfaceZzbj = getVideoController();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzbj);
                return true;
            case 29:
                zza((zzmu) zzel.zza(parcel, zzmu.CREATOR));
                parcel2.writeNoException();
                return true;
            case 30:
                zza((zzlu) zzel.zza(parcel, zzlu.CREATOR));
                parcel2.writeNoException();
                return true;
            case 31:
                mediationAdapterClassName = getAdUnitId();
                parcel2.writeNoException();
                parcel2.writeString(mediationAdapterClassName);
                return true;
            case 32:
                iInterfaceZzbj = zzbw();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzbj);
                return true;
            case 33:
                iInterfaceZzbj = zzbx();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzbj);
                return true;
            case 34:
                setImmersiveMode(zzel.zza(parcel));
                parcel2.writeNoException();
                return true;
            case 35:
                mediationAdapterClassName = zzck();
                parcel2.writeNoException();
                parcel2.writeString(mediationAdapterClassName);
                return true;
            case 36:
                IBinder strongBinder5 = parcel.readStrongBinder();
                if (strongBinder5 != null) {
                    IInterface iInterfaceQueryLocalInterface5 = strongBinder5.queryLocalInterface("com.google.android.gms.ads.internal.client.IAdMetadataListener");
                    zzkzVar = iInterfaceQueryLocalInterface5 instanceof zzkx ? (zzkx) iInterfaceQueryLocalInterface5 : new zzkz(strongBinder5);
                }
                zza(zzkzVar);
                parcel2.writeNoException();
                return true;
            case 37:
                parcelableZzbk = zzba();
                parcel2.writeNoException();
                zzel.zzb(parcel2, parcelableZzbk);
                return true;
        }
    }
}
