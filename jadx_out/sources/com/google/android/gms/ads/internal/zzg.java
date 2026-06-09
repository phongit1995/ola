package com.google.android.gms.ads.internal;

import android.webkit.CookieManager;
import com.google.android.gms.internal.ads.zzkb;
import com.google.android.gms.internal.ads.zznk;
import java.util.concurrent.Callable;

/* JADX INFO: loaded from: classes.dex */
final class zzg implements Callable<String> {
    private final /* synthetic */ zzd zzwk;

    zzg(zzd zzdVar) {
        this.zzwk = zzdVar;
    }

    @Override // java.util.concurrent.Callable
    public final /* synthetic */ String call() {
        CookieManager cookieManagerZzax;
        return (!((Boolean) zzkb.zzik().zzd(zznk.zzbdj)).booleanValue() || (cookieManagerZzax = zzbv.zzem().zzax(this.zzwk.zzvw.zzrt)) == null) ? "" : cookieManagerZzax.getCookie("googleads.g.doubleclick.net");
    }
}
