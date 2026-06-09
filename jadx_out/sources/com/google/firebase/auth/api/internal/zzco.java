package com.google.firebase.auth.api.internal;

import android.content.Context;
import android.os.Looper;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.internal.ClientSettings;

/* JADX INFO: loaded from: classes2.dex */
final class zzco extends Api.AbstractClientBuilder<zzcc, zzcp> {
    zzco() {
    }

    @Override // com.google.android.gms.common.api.Api.AbstractClientBuilder
    public final /* synthetic */ Api.Client buildClient(Context context, Looper looper, ClientSettings clientSettings, zzcp zzcpVar, GoogleApiClient.ConnectionCallbacks connectionCallbacks, GoogleApiClient.OnConnectionFailedListener onConnectionFailedListener) {
        return new zzcd(context, looper, clientSettings, zzcpVar, connectionCallbacks, onConnectionFailedListener);
    }
}
