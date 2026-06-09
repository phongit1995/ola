package com.google.android.gms.ads.internal;

import android.os.RemoteException;
import com.google.android.gms.internal.ads.zzabl;
import com.google.android.gms.internal.ads.zzait;
import com.google.android.gms.internal.ads.zzaji;
import com.google.android.gms.internal.ads.zzakb;
import com.google.android.gms.internal.ads.zzakk;
import com.google.android.gms.internal.ads.zzaqw;
import com.google.android.gms.internal.ads.zzarg;
import com.google.android.gms.internal.ads.zznx;
import com.google.android.gms.internal.ads.zzny;

/* JADX INFO: loaded from: classes.dex */
final class zzl implements Runnable {
    final /* synthetic */ zzaji zzwg;
    final /* synthetic */ zzi zzwm;
    final /* synthetic */ zzait zzwn;
    private final /* synthetic */ zznx zzwo;

    zzl(zzi zziVar, zzaji zzajiVar, zzait zzaitVar, zznx zznxVar) {
        this.zzwm = zziVar;
        this.zzwg = zzajiVar;
        this.zzwn = zzaitVar;
        this.zzwo = zznxVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        if (this.zzwg.zzcos.zzcez && this.zzwm.zzvw.zzado != null) {
            String strZzcu = null;
            if (this.zzwg.zzcos.zzbyq != null) {
                zzbv.zzek();
                strZzcu = zzakk.zzcu(this.zzwg.zzcos.zzbyq);
            }
            zzny zznyVar = new zzny(this.zzwm, strZzcu, this.zzwg.zzcos.zzceo);
            this.zzwm.zzvw.zzadv = 1;
            try {
                this.zzwm.zzvu = false;
                this.zzwm.zzvw.zzado.zza(zznyVar);
                return;
            } catch (RemoteException e) {
                zzakb.zzd("#007 Could not call remote method.", e);
                this.zzwm.zzvu = true;
            }
        }
        zzx zzxVar = new zzx(this.zzwm.zzvw.zzrt, this.zzwn, this.zzwg.zzcos.zzcfi);
        try {
            zzaqw zzaqwVarZza = this.zzwm.zza(this.zzwg, zzxVar, this.zzwn);
            zzaqwVarZza.setOnTouchListener(new zzn(this, zzxVar));
            zzaqwVarZza.setOnClickListener(new zzo(this, zzxVar));
            this.zzwm.zzvw.zzadv = 0;
            zzbw zzbwVar = this.zzwm.zzvw;
            zzbv.zzej();
            zzbwVar.zzacu = zzabl.zza(this.zzwm.zzvw.zzrt, this.zzwm, this.zzwg, this.zzwm.zzvw.zzacq, zzaqwVarZza, this.zzwm.zzwh, this.zzwm, this.zzwo);
        } catch (zzarg e2) {
            zzakb.zzb("Could not obtain webview.", e2);
            zzakk.zzcrm.post(new zzm(this));
        }
    }
}
