package com.google.android.gms.internal.measurement;

import android.os.RemoteException;

/* JADX INFO: loaded from: classes2.dex */
final class zzio implements Runnable {
    private final /* synthetic */ zzeb zzapd;
    private final /* synthetic */ zzik zzaqv;

    zzio(zzik zzikVar, zzeb zzebVar) {
        this.zzaqv = zzikVar;
        this.zzapd = zzebVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        zzfa zzfaVar = this.zzaqv.zzaqp;
        if (zzfaVar == null) {
            this.zzaqv.zzgi().zziv().log("Discarding data. Failed to send app launch");
            return;
        }
        try {
            zzfaVar.zza(this.zzapd);
            this.zzaqv.zza(zzfaVar, null, this.zzapd);
            this.zzaqv.zzcu();
        } catch (RemoteException e) {
            this.zzaqv.zzgi().zziv().zzg("Failed to send app launch to the service", e);
        }
    }
}
