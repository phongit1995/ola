package com.google.android.gms.auth.api;

import android.content.Context;
import android.os.Looper;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.internal.ClientSettings;
import com.google.android.gms.internal.auth.zzbh;

/* JADX INFO: loaded from: classes.dex */
final class zzg extends Api.AbstractClientBuilder<zzbh, zzh> {
    zzg() {
    }

    @Override // com.google.android.gms.common.api.Api.AbstractClientBuilder
    public final /* synthetic */ Api.Client buildClient(Context context, Looper looper, ClientSettings clientSettings, zzh zzhVar, GoogleApiClient.ConnectionCallbacks connectionCallbacks, GoogleApiClient.OnConnectionFailedListener onConnectionFailedListener) {
        return new zzbh(context, looper, clientSettings, zzhVar, connectionCallbacks, onConnectionFailedListener);
    }
}
