package com.google.android.gms.internal.ads;

import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import com.google.android.gms.dynamic.IObjectWrapper;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzaha extends zzek implements zzagz {
    public zzaha() {
        super("com.google.android.gms.ads.internal.reward.client.IRewardedVideoAd");
    }

    public static zzagz zzy(IBinder iBinder) {
        if (iBinder == null) {
            return null;
        }
        IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.ads.internal.reward.client.IRewardedVideoAd");
        return iInterfaceQueryLocalInterface instanceof zzagz ? (zzagz) iInterfaceQueryLocalInterface : new zzahb(iBinder);
    }

    @Override // com.google.android.gms.internal.ads.zzek
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) {
        if (i != 34) {
            zzahe zzahgVar = null;
            zzagx zzagyVar = null;
            switch (i) {
                case 1:
                    zza((zzahk) zzel.zza(parcel, zzahk.CREATOR));
                    break;
                case 2:
                    show();
                    break;
                case 3:
                    IBinder strongBinder = parcel.readStrongBinder();
                    if (strongBinder != null) {
                        IInterface iInterfaceQueryLocalInterface = strongBinder.queryLocalInterface("com.google.android.gms.ads.internal.reward.client.IRewardedVideoAdListener");
                        zzahgVar = iInterfaceQueryLocalInterface instanceof zzahe ? (zzahe) iInterfaceQueryLocalInterface : new zzahg(strongBinder);
                    }
                    zza(zzahgVar);
                    break;
                default:
                    switch (i) {
                        case 5:
                            boolean zIsLoaded = isLoaded();
                            parcel2.writeNoException();
                            zzel.zza(parcel2, zIsLoaded);
                            return true;
                        case 6:
                            pause();
                            break;
                        case 7:
                            resume();
                            break;
                        case 8:
                            destroy();
                            break;
                        case 9:
                            zzd(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                            break;
                        case 10:
                            zze(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                            break;
                        case 11:
                            zzf(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                            break;
                        case 12:
                            String mediationAdapterClassName = getMediationAdapterClassName();
                            parcel2.writeNoException();
                            parcel2.writeString(mediationAdapterClassName);
                            return true;
                        case 13:
                            setUserId(parcel.readString());
                            break;
                        case 14:
                            zza(zzky.zzc(parcel.readStrongBinder()));
                            break;
                        case 15:
                            Bundle bundleZzba = zzba();
                            parcel2.writeNoException();
                            zzel.zzb(parcel2, bundleZzba);
                            return true;
                        case 16:
                            IBinder strongBinder2 = parcel.readStrongBinder();
                            if (strongBinder2 != null) {
                                IInterface iInterfaceQueryLocalInterface2 = strongBinder2.queryLocalInterface("com.google.android.gms.ads.internal.reward.client.IRewardedAdSkuListener");
                                zzagyVar = iInterfaceQueryLocalInterface2 instanceof zzagx ? (zzagx) iInterfaceQueryLocalInterface2 : new zzagy(strongBinder2);
                            }
                            zza(zzagyVar);
                            break;
                        default:
                            return false;
                    }
                    break;
            }
        } else {
            setImmersiveMode(zzel.zza(parcel));
        }
        parcel2.writeNoException();
        return true;
    }
}
