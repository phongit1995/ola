package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzkp extends zzacd<zzkp> {
    private static volatile zzkp[] zzaus;
    public Integer zzate = null;
    public zzkv zzaut = null;
    public zzkv zzauu = null;
    public Boolean zzauv = null;

    public zzkp() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    public static zzkp[] zzlw() {
        if (zzaus == null) {
            synchronized (zzach.zzbzn) {
                if (zzaus == null) {
                    zzaus = new zzkp[0];
                }
            }
        }
        return zzaus;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzkp)) {
            return false;
        }
        zzkp zzkpVar = (zzkp) obj;
        if (this.zzate == null) {
            if (zzkpVar.zzate != null) {
                return false;
            }
        } else if (!this.zzate.equals(zzkpVar.zzate)) {
            return false;
        }
        if (this.zzaut == null) {
            if (zzkpVar.zzaut != null) {
                return false;
            }
        } else if (!this.zzaut.equals(zzkpVar.zzaut)) {
            return false;
        }
        if (this.zzauu == null) {
            if (zzkpVar.zzauu != null) {
                return false;
            }
        } else if (!this.zzauu.equals(zzkpVar.zzauu)) {
            return false;
        }
        if (this.zzauv == null) {
            if (zzkpVar.zzauv != null) {
                return false;
            }
        } else if (!this.zzauv.equals(zzkpVar.zzauv)) {
            return false;
        }
        return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzkpVar.zzbzd == null || zzkpVar.zzbzd.isEmpty() : this.zzbzd.equals(zzkpVar.zzbzd);
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = ((getClass().getName().hashCode() + 527) * 31) + (this.zzate == null ? 0 : this.zzate.hashCode());
        zzkv zzkvVar = this.zzaut;
        int iHashCode3 = (iHashCode2 * 31) + (zzkvVar == null ? 0 : zzkvVar.hashCode());
        zzkv zzkvVar2 = this.zzauu;
        int iHashCode4 = ((((iHashCode3 * 31) + (zzkvVar2 == null ? 0 : zzkvVar2.hashCode())) * 31) + (this.zzauv == null ? 0 : this.zzauv.hashCode())) * 31;
        if (this.zzbzd != null && !this.zzbzd.isEmpty()) {
            iHashCode = this.zzbzd.hashCode();
        }
        return iHashCode4 + iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    protected final int zza() {
        int iZza = super.zza();
        if (this.zzate != null) {
            iZza += zzacb.zzf(1, this.zzate.intValue());
        }
        if (this.zzaut != null) {
            iZza += zzacb.zzb(2, this.zzaut);
        }
        if (this.zzauu != null) {
            iZza += zzacb.zzb(3, this.zzauu);
        }
        if (this.zzauv == null) {
            return iZza;
        }
        this.zzauv.booleanValue();
        return iZza + zzacb.zzaq(4) + 1;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzate != null) {
            zzacbVar.zze(1, this.zzate.intValue());
        }
        if (this.zzaut != null) {
            zzacbVar.zza(2, this.zzaut);
        }
        if (this.zzauu != null) {
            zzacbVar.zza(3, this.zzauu);
        }
        if (this.zzauv != null) {
            zzacbVar.zza(4, this.zzauv.booleanValue());
        }
        super.zza(zzacbVar);
    }

    @Override // com.google.android.gms.internal.measurement.zzacj
    public final /* synthetic */ zzacj zzb(zzaca zzacaVar) throws zzaci {
        zzkv zzkvVar;
        while (true) {
            int iZzvl = zzacaVar.zzvl();
            if (iZzvl == 0) {
                return this;
            }
            if (iZzvl != 8) {
                if (iZzvl == 18) {
                    if (this.zzaut == null) {
                        this.zzaut = new zzkv();
                    }
                    zzkvVar = this.zzaut;
                } else if (iZzvl == 26) {
                    if (this.zzauu == null) {
                        this.zzauu = new zzkv();
                    }
                    zzkvVar = this.zzauu;
                } else if (iZzvl == 32) {
                    this.zzauv = Boolean.valueOf(zzacaVar.zzvm());
                } else if (!super.zza(zzacaVar, iZzvl)) {
                    return this;
                }
                zzacaVar.zza(zzkvVar);
            } else {
                this.zzate = Integer.valueOf(zzacaVar.zzvn());
            }
        }
    }
}
