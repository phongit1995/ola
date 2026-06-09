package com.google.android.gms.auth.api;

import com.google.android.gms.common.api.Api;
import com.google.android.gms.internal.auth.zzbh;

/* JADX INFO: loaded from: classes.dex */
public final class zzf {
    private static final Api.ClientKey<zzbh> zzas = new Api.ClientKey<>();
    private static final Api.AbstractClientBuilder<zzbh, zzh> zzat = new zzg();
    public static final Api<zzh> API = new Api<>("Auth.PROXY_API", zzat, zzas);
}
