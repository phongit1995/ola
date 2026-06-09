package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzkq extends zzacd<zzkq> {
    private static volatile zzkq[] zzauw;
    public Integer zzaux = null;
    public Long zzauy = null;

    public zzkq() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    public static zzkq[] zzlx() {
        if (zzauw == null) {
            synchronized (zzach.zzbzn) {
                if (zzauw == null) {
                    zzauw = new zzkq[0];
                }
            }
        }
        return zzauw;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzkq)) {
            return false;
        }
        zzkq zzkqVar = (zzkq) obj;
        if (this.zzaux == null) {
            if (zzkqVar.zzaux != null) {
                return false;
            }
        } else if (!this.zzaux.equals(zzkqVar.zzaux)) {
            return false;
        }
        if (this.zzauy == null) {
            if (zzkqVar.zzauy != null) {
                return false;
            }
        } else if (!this.zzauy.equals(zzkqVar.zzauy)) {
            return false;
        }
        return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzkqVar.zzbzd == null || zzkqVar.zzbzd.isEmpty() : this.zzbzd.equals(zzkqVar.zzbzd);
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = (((((getClass().getName().hashCode() + 527) * 31) + (this.zzaux == null ? 0 : this.zzaux.hashCode())) * 31) + (this.zzauy == null ? 0 : this.zzauy.hashCode())) * 31;
        if (this.zzbzd != null && !this.zzbzd.isEmpty()) {
            iHashCode = this.zzbzd.hashCode();
        }
        return iHashCode2 + iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    protected final int zza() {
        int iZza = super.zza();
        if (this.zzaux != null) {
            iZza += zzacb.zzf(1, this.zzaux.intValue());
        }
        return this.zzauy != null ? iZza + zzacb.zzc(2, this.zzauy.longValue()) : iZza;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzaux != null) {
            zzacbVar.zze(1, this.zzaux.intValue());
        }
        if (this.zzauy != null) {
            zzacbVar.zzb(2, this.zzauy.longValue());
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
            if (iZzvl == 8) {
                this.zzaux = Integer.valueOf(zzacaVar.zzvn());
            } else if (iZzvl == 16) {
                this.zzauy = Long.valueOf(zzacaVar.zzvo());
            } else if (!super.zza(zzacaVar, iZzvl)) {
                return this;
            }
        }
    }
}
