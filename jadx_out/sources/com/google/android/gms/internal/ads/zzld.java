package com.google.android.gms.internal.ads;

import android.os.IInterface;
import com.google.android.gms.dynamic.IObjectWrapper;

/* JADX INFO: loaded from: classes.dex */
public interface zzld extends IInterface {
    zzkn createAdLoaderBuilder(IObjectWrapper iObjectWrapper, String str, zzxn zzxnVar, int i);

    zzaap createAdOverlay(IObjectWrapper iObjectWrapper);

    zzks createBannerAdManager(IObjectWrapper iObjectWrapper, zzjn zzjnVar, String str, zzxn zzxnVar, int i);

    zzaaz createInAppPurchaseManager(IObjectWrapper iObjectWrapper);

    zzks createInterstitialAdManager(IObjectWrapper iObjectWrapper, zzjn zzjnVar, String str, zzxn zzxnVar, int i);

    zzqa createNativeAdViewDelegate(IObjectWrapper iObjectWrapper, IObjectWrapper iObjectWrapper2);

    zzqf createNativeAdViewHolderDelegate(IObjectWrapper iObjectWrapper, IObjectWrapper iObjectWrapper2, IObjectWrapper iObjectWrapper3);

    zzagz createRewardedVideoAd(IObjectWrapper iObjectWrapper, zzxn zzxnVar, int i);

    zzks createSearchAdManager(IObjectWrapper iObjectWrapper, zzjn zzjnVar, String str, int i);

    zzlj getMobileAdsSettingsManager(IObjectWrapper iObjectWrapper);

    zzlj getMobileAdsSettingsManagerWithClientJarVersion(IObjectWrapper iObjectWrapper, int i);
}
