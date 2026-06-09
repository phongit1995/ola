package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzkt extends zzacd<zzkt> {
    public zzku[] zzavf = zzku.zzma();

    public zzkt() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzkt)) {
            return false;
        }
        zzkt zzktVar = (zzkt) obj;
        if (zzach.equals(this.zzavf, zzktVar.zzavf)) {
            return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzktVar.zzbzd == null || zzktVar.zzbzd.isEmpty() : this.zzbzd.equals(zzktVar.zzbzd);
        }
        return false;
    }

    public final int hashCode() {
        return ((((getClass().getName().hashCode() + 527) * 31) + zzach.hashCode(this.zzavf)) * 31) + ((this.zzbzd == null || this.zzbzd.isEmpty()) ? 0 : this.zzbzd.hashCode());
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    protected final int zza() {
        int iZza = super.zza();
        if (this.zzavf != null && this.zzavf.length > 0) {
            for (int i = 0; i < this.zzavf.length; i++) {
                zzku zzkuVar = this.zzavf[i];
                if (zzkuVar != null) {
                    iZza += zzacb.zzb(1, zzkuVar);
                }
            }
        }
        return iZza;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzavf != null && this.zzavf.length > 0) {
            for (int i = 0; i < this.zzavf.length; i++) {
                zzku zzkuVar = this.zzavf[i];
                if (zzkuVar != null) {
                    zzacbVar.zza(1, zzkuVar);
                }
            }
        }
        super.zza(zzacbVar);
    }

    @Override // com.google.android.gms.internal.measurement.zzacj
    public final /* synthetic */ zzacj zzb(zzaca zzacaVar) throws zzaci {
        while (true) {
            int iZzvl = zzacaVar.zzvl();
            if (iZzvl == 0) {
                return this;
            }
            if (iZzvl == 10) {
                int iZzb = zzacm.zzb(zzacaVar, 10);
                int length = this.zzavf == null ? 0 : this.zzavf.length;
                zzku[] zzkuVarArr = new zzku[iZzb + length];
                if (length != 0) {
                    System.arraycopy(this.zzavf, 0, zzkuVarArr, 0, length);
                }
                while (length < zzkuVarArr.length - 1) {
                    zzkuVarArr[length] = new zzku();
                    zzacaVar.zza(zzkuVarArr[length]);
                    zzacaVar.zzvl();
                    length++;
                }
                zzkuVarArr[length] = new zzku();
                zzacaVar.zza(zzkuVarArr[length]);
                this.zzavf = zzkuVarArr;
            } else if (!super.zza(zzacaVar, iZzvl)) {
                return this;
            }
        }
    }
}
