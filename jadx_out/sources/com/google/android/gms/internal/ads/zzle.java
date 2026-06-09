package com.google.android.gms.internal.ads;

import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import com.google.android.gms.dynamic.IObjectWrapper;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzle extends zzek implements zzld {
    public zzle() {
        super("com.google.android.gms.ads.internal.client.IClientApi");
    }

    public static zzld asInterface(IBinder iBinder) {
        if (iBinder == null) {
            return null;
        }
        IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.ads.internal.client.IClientApi");
        return iInterfaceQueryLocalInterface instanceof zzld ? (zzld) iInterfaceQueryLocalInterface : new zzlf(iBinder);
    }

    @Override // com.google.android.gms.internal.ads.zzek
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) {
        IInterface iInterfaceCreateBannerAdManager;
        switch (i) {
            case 1:
                iInterfaceCreateBannerAdManager = createBannerAdManager(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), (zzjn) zzel.zza(parcel, zzjn.CREATOR), parcel.readString(), zzxo.zzr(parcel.readStrongBinder()), parcel.readInt());
                break;
            case 2:
                iInterfaceCreateBannerAdManager = createInterstitialAdManager(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), (zzjn) zzel.zza(parcel, zzjn.CREATOR), parcel.readString(), zzxo.zzr(parcel.readStrongBinder()), parcel.readInt());
                break;
            case 3:
                iInterfaceCreateBannerAdManager = createAdLoaderBuilder(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), parcel.readString(), zzxo.zzr(parcel.readStrongBinder()), parcel.readInt());
                break;
            case 4:
                iInterfaceCreateBannerAdManager = getMobileAdsSettingsManager(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                break;
            case 5:
                iInterfaceCreateBannerAdManager = createNativeAdViewDelegate(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                break;
            case 6:
                iInterfaceCreateBannerAdManager = createRewardedVideoAd(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), zzxo.zzr(parcel.readStrongBinder()), parcel.readInt());
                break;
            case 7:
                iInterfaceCreateBannerAdManager = createInAppPurchaseManager(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                break;
            case 8:
                iInterfaceCreateBannerAdManager = createAdOverlay(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                break;
            case 9:
                iInterfaceCreateBannerAdManager = getMobileAdsSettingsManagerWithClientJarVersion(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), parcel.readInt());
                break;
            case 10:
                iInterfaceCreateBannerAdManager = createSearchAdManager(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), (zzjn) zzel.zza(parcel, zzjn.CREATOR), parcel.readString(), parcel.readInt());
                break;
            case 11:
                iInterfaceCreateBannerAdManager = createNativeAdViewHolderDelegate(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                break;
            default:
                return false;
        }
        parcel2.writeNoException();
        zzel.zza(parcel2, iInterfaceCreateBannerAdManager);
        return true;
    }
}
