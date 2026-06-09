package com.google.android.gms.ads.internal;

import android.os.RemoteException;
import com.google.android.gms.internal.ads.zzakb;
import com.google.android.gms.internal.ads.zzoo;

/* JADX INFO: loaded from: classes.dex */
final class zzt implements Runnable {
    private final /* synthetic */ zzq zzwt;
    private final /* synthetic */ zzoo zzwv;

    zzt(zzq zzqVar, zzoo zzooVar) {
        this.zzwt = zzqVar;
        this.zzwv = zzooVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        try {
            if (this.zzwt.zzvw.zzade != null) {
                this.zzwt.zzvw.zzade.zza(this.zzwv);
                this.zzwt.zzb(this.zzwv.zzka());
            }
        } catch (RemoteException e) {
            zzakb.zzd("#007 Could not call remote method.", e);
        }
    }
}
