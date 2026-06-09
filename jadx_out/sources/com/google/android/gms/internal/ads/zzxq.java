package com.google.android.gms.internal.ads;

import android.os.Bundle;
import android.os.IInterface;
import com.google.android.gms.dynamic.IObjectWrapper;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public interface zzxq extends IInterface {
    void destroy();

    Bundle getInterstitialAdapterInfo();

    zzlo getVideoController();

    IObjectWrapper getView();

    boolean isInitialized();

    void pause();

    void resume();

    void setImmersiveMode(boolean z);

    void showInterstitial();

    void showVideo();

    void zza(IObjectWrapper iObjectWrapper, zzaic zzaicVar, List<String> list);

    void zza(IObjectWrapper iObjectWrapper, zzjj zzjjVar, String str, zzaic zzaicVar, String str2);

    void zza(IObjectWrapper iObjectWrapper, zzjj zzjjVar, String str, zzxt zzxtVar);

    void zza(IObjectWrapper iObjectWrapper, zzjj zzjjVar, String str, String str2, zzxt zzxtVar);

    void zza(IObjectWrapper iObjectWrapper, zzjj zzjjVar, String str, String str2, zzxt zzxtVar, zzpl zzplVar, List<String> list);

    void zza(IObjectWrapper iObjectWrapper, zzjn zzjnVar, zzjj zzjjVar, String str, zzxt zzxtVar);

    void zza(IObjectWrapper iObjectWrapper, zzjn zzjnVar, zzjj zzjjVar, String str, String str2, zzxt zzxtVar);

    void zza(zzjj zzjjVar, String str, String str2);

    void zzc(zzjj zzjjVar, String str);

    void zzi(IObjectWrapper iObjectWrapper);

    zzxz zzmo();

    zzyc zzmp();

    Bundle zzmq();

    Bundle zzmr();

    boolean zzms();

    zzqs zzmt();

    zzyf zzmu();
}
