package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzkx extends zzacd<zzkx> {
    private static volatile zzkx[] zzawr;
    public Long zzaws = null;
    public String name = null;
    public String zzale = null;
    public Long zzave = null;
    private Float zzasv = null;
    public Double zzasw = null;

    public zzkx() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    public static zzkx[] zzmc() {
        if (zzawr == null) {
            synchronized (zzach.zzbzn) {
                if (zzawr == null) {
                    zzawr = new zzkx[0];
                }
            }
        }
        return zzawr;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzkx)) {
            return false;
        }
        zzkx zzkxVar = (zzkx) obj;
        if (this.zzaws == null) {
            if (zzkxVar.zzaws != null) {
                return false;
            }
        } else if (!this.zzaws.equals(zzkxVar.zzaws)) {
            return false;
        }
        if (this.name == null) {
            if (zzkxVar.name != null) {
                return false;
            }
        } else if (!this.name.equals(zzkxVar.name)) {
            return false;
        }
        if (this.zzale == null) {
            if (zzkxVar.zzale != null) {
                return false;
            }
        } else if (!this.zzale.equals(zzkxVar.zzale)) {
            return false;
        }
        if (this.zzave == null) {
            if (zzkxVar.zzave != null) {
                return false;
            }
        } else if (!this.zzave.equals(zzkxVar.zzave)) {
            return false;
        }
        if (this.zzasv == null) {
            if (zzkxVar.zzasv != null) {
                return false;
            }
        } else if (!this.zzasv.equals(zzkxVar.zzasv)) {
            return false;
        }
        if (this.zzasw == null) {
            if (zzkxVar.zzasw != null) {
                return false;
            }
        } else if (!this.zzasw.equals(zzkxVar.zzasw)) {
            return false;
        }
        return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzkxVar.zzbzd == null || zzkxVar.zzbzd.isEmpty() : this.zzbzd.equals(zzkxVar.zzbzd);
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = (((((((((((((getClass().getName().hashCode() + 527) * 31) + (this.zzaws == null ? 0 : this.zzaws.hashCode())) * 31) + (this.name == null ? 0 : this.name.hashCode())) * 31) + (this.zzale == null ? 0 : this.zzale.hashCode())) * 31) + (this.zzave == null ? 0 : this.zzave.hashCode())) * 31) + (this.zzasv == null ? 0 : this.zzasv.hashCode())) * 31) + (this.zzasw == null ? 0 : this.zzasw.hashCode())) * 31;
        if (this.zzbzd != null && !this.zzbzd.isEmpty()) {
            iHashCode = this.zzbzd.hashCode();
        }
        return iHashCode2 + iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    protected final int zza() {
        int iZza = super.zza();
        if (this.zzaws != null) {
            iZza += zzacb.zzc(1, this.zzaws.longValue());
        }
        if (this.name != null) {
            iZza += zzacb.zzc(2, this.name);
        }
        if (this.zzale != null) {
            iZza += zzacb.zzc(3, this.zzale);
        }
        if (this.zzave != null) {
            iZza += zzacb.zzc(4, this.zzave.longValue());
        }
        if (this.zzasv != null) {
            this.zzasv.floatValue();
            iZza += zzacb.zzaq(5) + 4;
        }
        if (this.zzasw == null) {
            return iZza;
        }
        this.zzasw.doubleValue();
        return iZza + zzacb.zzaq(6) + 8;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzaws != null) {
            zzacbVar.zzb(1, this.zzaws.longValue());
        }
        if (this.name != null) {
            zzacbVar.zzb(2, this.name);
        }
        if (this.zzale != null) {
            zzacbVar.zzb(3, this.zzale);
        }
        if (this.zzave != null) {
            zzacbVar.zzb(4, this.zzave.longValue());
        }
        if (this.zzasv != null) {
            zzacbVar.zza(5, this.zzasv.floatValue());
        }
        if (this.zzasw != null) {
            zzacbVar.zza(6, this.zzasw.doubleValue());
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
                this.zzaws = Long.valueOf(zzacaVar.zzvo());
            } else if (iZzvl == 18) {
                this.name = zzacaVar.readString();
            } else if (iZzvl == 26) {
                this.zzale = zzacaVar.readString();
            } else if (iZzvl == 32) {
                this.zzave = Long.valueOf(zzacaVar.zzvo());
            } else if (iZzvl == 45) {
                this.zzasv = Float.valueOf(Float.intBitsToFloat(zzacaVar.zzvp()));
            } else if (iZzvl == 49) {
                this.zzasw = Double.valueOf(Double.longBitsToDouble(zzacaVar.zzvq()));
            } else if (!super.zza(zzacaVar, iZzvl)) {
                return this;
            }
        }
    }
}
