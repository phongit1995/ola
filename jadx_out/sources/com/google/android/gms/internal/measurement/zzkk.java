package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzkk extends zzacd<zzkk> {
    private static volatile zzkk[] zzaub;
    public Integer zzatk = null;
    public String zzauc = null;
    public zzki zzaud = null;

    public zzkk() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    public static zzkk[] zzlt() {
        if (zzaub == null) {
            synchronized (zzach.zzbzn) {
                if (zzaub == null) {
                    zzaub = new zzkk[0];
                }
            }
        }
        return zzaub;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzkk)) {
            return false;
        }
        zzkk zzkkVar = (zzkk) obj;
        if (this.zzatk == null) {
            if (zzkkVar.zzatk != null) {
                return false;
            }
        } else if (!this.zzatk.equals(zzkkVar.zzatk)) {
            return false;
        }
        if (this.zzauc == null) {
            if (zzkkVar.zzauc != null) {
                return false;
            }
        } else if (!this.zzauc.equals(zzkkVar.zzauc)) {
            return false;
        }
        if (this.zzaud == null) {
            if (zzkkVar.zzaud != null) {
                return false;
            }
        } else if (!this.zzaud.equals(zzkkVar.zzaud)) {
            return false;
        }
        return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzkkVar.zzbzd == null || zzkkVar.zzbzd.isEmpty() : this.zzbzd.equals(zzkkVar.zzbzd);
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = ((((getClass().getName().hashCode() + 527) * 31) + (this.zzatk == null ? 0 : this.zzatk.hashCode())) * 31) + (this.zzauc == null ? 0 : this.zzauc.hashCode());
        zzki zzkiVar = this.zzaud;
        int iHashCode3 = ((iHashCode2 * 31) + (zzkiVar == null ? 0 : zzkiVar.hashCode())) * 31;
        if (this.zzbzd != null && !this.zzbzd.isEmpty()) {
            iHashCode = this.zzbzd.hashCode();
        }
        return iHashCode3 + iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    protected final int zza() {
        int iZza = super.zza();
        if (this.zzatk != null) {
            iZza += zzacb.zzf(1, this.zzatk.intValue());
        }
        if (this.zzauc != null) {
            iZza += zzacb.zzc(2, this.zzauc);
        }
        return this.zzaud != null ? iZza + zzacb.zzb(3, this.zzaud) : iZza;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzatk != null) {
            zzacbVar.zze(1, this.zzatk.intValue());
        }
        if (this.zzauc != null) {
            zzacbVar.zzb(2, this.zzauc);
        }
        if (this.zzaud != null) {
            zzacbVar.zza(3, this.zzaud);
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
                this.zzatk = Integer.valueOf(zzacaVar.zzvn());
            } else if (iZzvl == 18) {
                this.zzauc = zzacaVar.readString();
            } else if (iZzvl == 26) {
                if (this.zzaud == null) {
                    this.zzaud = new zzki();
                }
                zzacaVar.zza(this.zzaud);
            } else if (!super.zza(zzacaVar, iZzvl)) {
                return this;
            }
        }
    }
}
