package com.google.firebase.auth.api.internal;

import android.content.Context;
import com.google.android.gms.common.api.Api;

/* JADX INFO: loaded from: classes2.dex */
public final class zzcn {
    private static final Api.ClientKey<zzcc> CLIENT_KEY = new Api.ClientKey<>();
    private static final Api.AbstractClientBuilder<zzcc, zzcp> zzhm = new zzco();
    public static final Api<zzcp> zzhn = new Api<>("InternalFirebaseAuth.FIREBASE_AUTH_API", zzhm, CLIENT_KEY);

    public static zzao zza(Context context, zzcp zzcpVar) {
        return new zzao(context, zzcpVar);
    }
}
