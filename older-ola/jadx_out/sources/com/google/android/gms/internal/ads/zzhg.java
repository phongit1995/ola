package com.google.android.gms.internal.ads;

import android.os.Bundle;
import android.os.DeadObjectException;
import android.support.annotation.Nullable;
import com.google.android.gms.common.internal.BaseGmsClient;

/* JADX INFO: loaded from: classes.dex */
final class zzhg implements BaseGmsClient.BaseConnectionCallbacks {
    private final /* synthetic */ zzhd zzajt;

    zzhg(zzhd zzhdVar) {
        this.zzajt = zzhdVar;
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient.BaseConnectionCallbacks
    public final void onConnected(@Nullable Bundle bundle) {
        synchronized (this.zzajt.mLock) {
            try {
            } catch (DeadObjectException e) {
                zzakb.zzb("Unable to obtain a cache service instance.", e);
                this.zzajt.disconnect();
            }
            if (this.zzajt.zzajr != null) {
                this.zzajt.zzajs = this.zzajt.zzajr.zzhl();
                this.zzajt.mLock.notifyAll();
            } else {
                this.zzajt.mLock.notifyAll();
            }
        }
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient.BaseConnectionCallbacks
    public final void onConnectionSuspended(int i) {
        synchronized (this.zzajt.mLock) {
            this.zzajt.zzajs = null;
            this.zzajt.mLock.notifyAll();
        }
    }
}
