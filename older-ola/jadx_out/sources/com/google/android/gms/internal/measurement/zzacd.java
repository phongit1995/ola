package com.google.android.gms.internal.measurement;

import com.google.android.gms.internal.measurement.zzacd;

/* JADX INFO: loaded from: classes2.dex */
public abstract class zzacd<M extends zzacd<M>> extends zzacj {
    protected zzacf zzbzd;

    @Override // com.google.android.gms.internal.measurement.zzacj
    public /* synthetic */ Object clone() {
        zzacd zzacdVar = (zzacd) super.clone();
        zzach.zza(this, zzacdVar);
        return zzacdVar;
    }

    @Override // com.google.android.gms.internal.measurement.zzacj
    protected int zza() {
        if (this.zzbzd == null) {
            return 0;
        }
        int iZza = 0;
        for (int i = 0; i < this.zzbzd.size(); i++) {
            iZza += this.zzbzd.zzau(i).zza();
        }
        return iZza;
    }

    public final <T> T zza(zzace<M, T> zzaceVar) {
        zzacg zzacgVarZzat;
        if (this.zzbzd == null || (zzacgVarZzat = this.zzbzd.zzat(zzaceVar.tag >>> 3)) == null) {
            return null;
        }
        return (T) zzacgVarZzat.zzb(zzaceVar);
    }

    @Override // com.google.android.gms.internal.measurement.zzacj
    public void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzbzd == null) {
            return;
        }
        for (int i = 0; i < this.zzbzd.size(); i++) {
            this.zzbzd.zzau(i).zza(zzacbVar);
        }
    }

    protected final boolean zza(zzaca zzacaVar, int i) throws zzaci {
        int position = zzacaVar.getPosition();
        if (!zzacaVar.zzak(i)) {
            return false;
        }
        int i2 = i >>> 3;
        zzacl zzaclVar = new zzacl(i, zzacaVar.zzc(position, zzacaVar.getPosition() - position));
        zzacg zzacgVarZzat = null;
        if (this.zzbzd == null) {
            this.zzbzd = new zzacf();
        } else {
            zzacgVarZzat = this.zzbzd.zzat(i2);
        }
        if (zzacgVarZzat == null) {
            zzacgVarZzat = new zzacg();
            this.zzbzd.zza(i2, zzacgVarZzat);
        }
        zzacgVarZzat.zza(zzaclVar);
        return true;
    }

    @Override // com.google.android.gms.internal.measurement.zzacj
    /* JADX INFO: renamed from: zzvu */
    public final /* synthetic */ zzacj clone() {
        return (zzacd) clone();
    }
}
