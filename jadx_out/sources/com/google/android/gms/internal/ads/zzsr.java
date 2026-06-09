package com.google.android.gms.internal.ads;

import android.support.annotation.NonNull;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.internal.BaseGmsClient;

/* JADX INFO: loaded from: classes.dex */
final class zzsr implements BaseGmsClient.BaseOnConnectionFailedListener {
    private final /* synthetic */ zzsm zzbnn;
    private final /* synthetic */ zzaoj zzbno;

    zzsr(zzsm zzsmVar, zzaoj zzaojVar) {
        this.zzbnn = zzsmVar;
        this.zzbno = zzaojVar;
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient.BaseOnConnectionFailedListener
    public final void onConnectionFailed(@NonNull ConnectionResult connectionResult) {
        synchronized (this.zzbnn.mLock) {
            this.zzbno.setException(new RuntimeException("Connection failed."));
        }
    }
}
