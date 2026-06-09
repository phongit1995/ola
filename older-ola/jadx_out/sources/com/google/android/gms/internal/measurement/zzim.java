package com.google.android.gms.internal.measurement;

import android.os.RemoteException;

/* JADX INFO: loaded from: classes2.dex */
final class zzim implements Runnable {
    private final /* synthetic */ zzeb zzapd;
    private final /* synthetic */ zzik zzaqv;

    zzim(zzik zzikVar, zzeb zzebVar) {
        this.zzaqv = zzikVar;
        this.zzapd = zzebVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        zzfa zzfaVar = this.zzaqv.zzaqp;
        if (zzfaVar == null) {
            this.zzaqv.zzgi().zziv().log("Failed to reset data on the service; null service");
            return;
        }
        try {
            zzfaVar.zzd(this.zzapd);
        } catch (RemoteException e) {
            this.zzaqv.zzgi().zziv().zzg("Failed to reset data on the service", e);
        }
        this.zzaqv.zzcu();
    }
}
