package com.google.android.gms.ads.internal;

import android.app.Activity;
import android.content.Context;
import android.support.annotation.Keep;
import android.support.annotation.Nullable;
import android.view.View;
import android.widget.FrameLayout;
import com.google.android.gms.ads.internal.overlay.AdOverlayInfoParcel;
import com.google.android.gms.common.annotation.KeepForSdkWithMembers;
import com.google.android.gms.common.util.DynamiteApi;
import com.google.android.gms.common.util.RetainForClient;
import com.google.android.gms.dynamic.IObjectWrapper;
import com.google.android.gms.dynamic.ObjectWrapper;
import com.google.android.gms.internal.ads.zzaap;
import com.google.android.gms.internal.ads.zzaaz;
import com.google.android.gms.internal.ads.zzadh;
import com.google.android.gms.internal.ads.zzagq;
import com.google.android.gms.internal.ads.zzagz;
import com.google.android.gms.internal.ads.zzakk;
import com.google.android.gms.internal.ads.zzang;
import com.google.android.gms.internal.ads.zzjn;
import com.google.android.gms.internal.ads.zzkn;
import com.google.android.gms.internal.ads.zzks;
import com.google.android.gms.internal.ads.zzle;
import com.google.android.gms.internal.ads.zzlj;
import com.google.android.gms.internal.ads.zzpn;
import com.google.android.gms.internal.ads.zzpp;
import com.google.android.gms.internal.ads.zzqa;
import com.google.android.gms.internal.ads.zzqf;
import com.google.android.gms.internal.ads.zzxn;
import java.util.HashMap;
import javax.annotation.ParametersAreNonnullByDefault;

/* JADX INFO: loaded from: classes.dex */
@RetainForClient
@Keep
@DynamiteApi
@ParametersAreNonnullByDefault
@KeepForSdkWithMembers
@zzadh
public class ClientApi extends zzle {
    @Override // com.google.android.gms.internal.ads.zzld
    public zzkn createAdLoaderBuilder(IObjectWrapper iObjectWrapper, String str, zzxn zzxnVar, int i) {
        Context context = (Context) ObjectWrapper.unwrap(iObjectWrapper);
        zzbv.zzek();
        return new zzak(context, str, zzxnVar, new zzang(12451000, i, true, zzakk.zzav(context)), zzw.zzc(context));
    }

    @Override // com.google.android.gms.internal.ads.zzld
    public zzaap createAdOverlay(IObjectWrapper iObjectWrapper) {
        Activity activity = (Activity) ObjectWrapper.unwrap(iObjectWrapper);
        AdOverlayInfoParcel adOverlayInfoParcelZzc = AdOverlayInfoParcel.zzc(activity.getIntent());
        if (adOverlayInfoParcelZzc == null) {
            return new com.google.android.gms.ads.internal.overlay.zzr(activity);
        }
        switch (adOverlayInfoParcelZzc.zzbyu) {
        }
        return new com.google.android.gms.ads.internal.overlay.zzr(activity);
    }

    @Override // com.google.android.gms.internal.ads.zzld
    public zzks createBannerAdManager(IObjectWrapper iObjectWrapper, zzjn zzjnVar, String str, zzxn zzxnVar, int i) {
        Context context = (Context) ObjectWrapper.unwrap(iObjectWrapper);
        zzbv.zzek();
        return new zzy(context, zzjnVar, str, zzxnVar, new zzang(12451000, i, true, zzakk.zzav(context)), zzw.zzc(context));
    }

    @Override // com.google.android.gms.internal.ads.zzld
    public zzaaz createInAppPurchaseManager(IObjectWrapper iObjectWrapper) {
        return null;
    }

    /* JADX WARN: Removed duplicated region for block: B:10:0x004b  */
    /* JADX WARN: Removed duplicated region for block: B:6:0x0036  */
    @Override // com.google.android.gms.internal.ads.zzld
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public com.google.android.gms.internal.ads.zzks createInterstitialAdManager(com.google.android.gms.dynamic.IObjectWrapper r8, com.google.android.gms.internal.ads.zzjn r9, java.lang.String r10, com.google.android.gms.internal.ads.zzxn r11, int r12) {
        /*
            r7 = this;
            java.lang.Object r8 = com.google.android.gms.dynamic.ObjectWrapper.unwrap(r8)
            r1 = r8
            android.content.Context r1 = (android.content.Context) r1
            com.google.android.gms.internal.ads.zznk.initialize(r1)
            com.google.android.gms.internal.ads.zzang r5 = new com.google.android.gms.internal.ads.zzang
            com.google.android.gms.ads.internal.zzbv.zzek()
            boolean r8 = com.google.android.gms.internal.ads.zzakk.zzav(r1)
            r0 = 1
            r2 = 12451000(0xbdfcb8, float:1.7447567E-38)
            r5.<init>(r2, r12, r0, r8)
            java.lang.String r8 = "reward_mb"
            java.lang.String r12 = r9.zzarb
            boolean r8 = r8.equals(r12)
            if (r8 != 0) goto L36
            com.google.android.gms.internal.ads.zzna<java.lang.Boolean> r12 = com.google.android.gms.internal.ads.zznk.zzayy
            com.google.android.gms.internal.ads.zzni r2 = com.google.android.gms.internal.ads.zzkb.zzik()
            java.lang.Object r12 = r2.zzd(r12)
            java.lang.Boolean r12 = (java.lang.Boolean) r12
            boolean r12 = r12.booleanValue()
            if (r12 != 0) goto L4c
        L36:
            if (r8 == 0) goto L4b
            com.google.android.gms.internal.ads.zzna<java.lang.Boolean> r8 = com.google.android.gms.internal.ads.zznk.zzayz
            com.google.android.gms.internal.ads.zzni r12 = com.google.android.gms.internal.ads.zzkb.zzik()
            java.lang.Object r8 = r12.zzd(r8)
            java.lang.Boolean r8 = (java.lang.Boolean) r8
            boolean r8 = r8.booleanValue()
            if (r8 == 0) goto L4b
            goto L4c
        L4b:
            r0 = 0
        L4c:
            if (r0 == 0) goto L5d
            com.google.android.gms.internal.ads.zzub r8 = new com.google.android.gms.internal.ads.zzub
            com.google.android.gms.ads.internal.zzw r9 = com.google.android.gms.ads.internal.zzw.zzc(r1)
            r0 = r8
            r2 = r10
            r3 = r11
            r4 = r5
            r5 = r9
            r0.<init>(r1, r2, r3, r4, r5)
            return r8
        L5d:
            com.google.android.gms.ads.internal.zzal r8 = new com.google.android.gms.ads.internal.zzal
            com.google.android.gms.ads.internal.zzw r6 = com.google.android.gms.ads.internal.zzw.zzc(r1)
            r0 = r8
            r2 = r9
            r3 = r10
            r4 = r11
            r0.<init>(r1, r2, r3, r4, r5, r6)
            return r8
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.ads.internal.ClientApi.createInterstitialAdManager(com.google.android.gms.dynamic.IObjectWrapper, com.google.android.gms.internal.ads.zzjn, java.lang.String, com.google.android.gms.internal.ads.zzxn, int):com.google.android.gms.internal.ads.zzks");
    }

    @Override // com.google.android.gms.internal.ads.zzld
    public zzqa createNativeAdViewDelegate(IObjectWrapper iObjectWrapper, IObjectWrapper iObjectWrapper2) {
        return new zzpn((FrameLayout) ObjectWrapper.unwrap(iObjectWrapper), (FrameLayout) ObjectWrapper.unwrap(iObjectWrapper2));
    }

    @Override // com.google.android.gms.internal.ads.zzld
    public zzqf createNativeAdViewHolderDelegate(IObjectWrapper iObjectWrapper, IObjectWrapper iObjectWrapper2, IObjectWrapper iObjectWrapper3) {
        return new zzpp((View) ObjectWrapper.unwrap(iObjectWrapper), (HashMap) ObjectWrapper.unwrap(iObjectWrapper2), (HashMap) ObjectWrapper.unwrap(iObjectWrapper3));
    }

    @Override // com.google.android.gms.internal.ads.zzld
    public zzagz createRewardedVideoAd(IObjectWrapper iObjectWrapper, zzxn zzxnVar, int i) {
        Context context = (Context) ObjectWrapper.unwrap(iObjectWrapper);
        zzbv.zzek();
        return new zzagq(context, zzw.zzc(context), zzxnVar, new zzang(12451000, i, true, zzakk.zzav(context)));
    }

    @Override // com.google.android.gms.internal.ads.zzld
    public zzks createSearchAdManager(IObjectWrapper iObjectWrapper, zzjn zzjnVar, String str, int i) {
        Context context = (Context) ObjectWrapper.unwrap(iObjectWrapper);
        zzbv.zzek();
        return new zzbp(context, zzjnVar, str, new zzang(12451000, i, true, zzakk.zzav(context)));
    }

    @Override // com.google.android.gms.internal.ads.zzld
    @Nullable
    public zzlj getMobileAdsSettingsManager(IObjectWrapper iObjectWrapper) {
        return null;
    }

    @Override // com.google.android.gms.internal.ads.zzld
    public zzlj getMobileAdsSettingsManagerWithClientJarVersion(IObjectWrapper iObjectWrapper, int i) {
        Context context = (Context) ObjectWrapper.unwrap(iObjectWrapper);
        zzbv.zzek();
        return zzay.zza(context, new zzang(12451000, i, true, zzakk.zzav(context)));
    }
}
