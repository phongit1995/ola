package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzki extends zzacd<zzki> {
    private static volatile zzki[] zzatp;
    public zzkl zzatq = null;
    public zzkj zzatr = null;
    public Boolean zzats = null;
    public String zzatt = null;
    public Boolean zzatu = null;
    public Boolean zzatv = null;

    public zzki() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    public static zzki[] zzls() {
        if (zzatp == null) {
            synchronized (zzach.zzbzn) {
                if (zzatp == null) {
                    zzatp = new zzki[0];
                }
            }
        }
        return zzatp;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzki)) {
            return false;
        }
        zzki zzkiVar = (zzki) obj;
        if (this.zzatq == null) {
            if (zzkiVar.zzatq != null) {
                return false;
            }
        } else if (!this.zzatq.equals(zzkiVar.zzatq)) {
            return false;
        }
        if (this.zzatr == null) {
            if (zzkiVar.zzatr != null) {
                return false;
            }
        } else if (!this.zzatr.equals(zzkiVar.zzatr)) {
            return false;
        }
        if (this.zzats == null) {
            if (zzkiVar.zzats != null) {
                return false;
            }
        } else if (!this.zzats.equals(zzkiVar.zzats)) {
            return false;
        }
        if (this.zzatt == null) {
            if (zzkiVar.zzatt != null) {
                return false;
            }
        } else if (!this.zzatt.equals(zzkiVar.zzatt)) {
            return false;
        }
        if (this.zzatu == null) {
            if (zzkiVar.zzatu != null) {
                return false;
            }
        } else if (!this.zzatu.equals(zzkiVar.zzatu)) {
            return false;
        }
        if (this.zzatv == null) {
            if (zzkiVar.zzatv != null) {
                return false;
            }
        } else if (!this.zzatv.equals(zzkiVar.zzatv)) {
            return false;
        }
        return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzkiVar.zzbzd == null || zzkiVar.zzbzd.isEmpty() : this.zzbzd.equals(zzkiVar.zzbzd);
    }

    public final int hashCode() {
        int iHashCode = getClass().getName().hashCode() + 527;
        zzkl zzklVar = this.zzatq;
        int iHashCode2 = 0;
        int iHashCode3 = (iHashCode * 31) + (zzklVar == null ? 0 : zzklVar.hashCode());
        zzkj zzkjVar = this.zzatr;
        int iHashCode4 = ((((((((((iHashCode3 * 31) + (zzkjVar == null ? 0 : zzkjVar.hashCode())) * 31) + (this.zzats == null ? 0 : this.zzats.hashCode())) * 31) + (this.zzatt == null ? 0 : this.zzatt.hashCode())) * 31) + (this.zzatu == null ? 0 : this.zzatu.hashCode())) * 31) + (this.zzatv == null ? 0 : this.zzatv.hashCode())) * 31;
        if (this.zzbzd != null && !this.zzbzd.isEmpty()) {
            iHashCode2 = this.zzbzd.hashCode();
        }
        return iHashCode4 + iHashCode2;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    protected final int zza() {
        int iZza = super.zza();
        if (this.zzatq != null) {
            iZza += zzacb.zzb(1, this.zzatq);
        }
        if (this.zzatr != null) {
            iZza += zzacb.zzb(2, this.zzatr);
        }
        if (this.zzats != null) {
            this.zzats.booleanValue();
            iZza += zzacb.zzaq(3) + 1;
        }
        if (this.zzatt != null) {
            iZza += zzacb.zzc(4, this.zzatt);
        }
        if (this.zzatu != null) {
            this.zzatu.booleanValue();
            iZza += zzacb.zzaq(5) + 1;
        }
        if (this.zzatv == null) {
            return iZza;
        }
        this.zzatv.booleanValue();
        return iZza + zzacb.zzaq(6) + 1;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzatq != null) {
            zzacbVar.zza(1, this.zzatq);
        }
        if (this.zzatr != null) {
            zzacbVar.zza(2, this.zzatr);
        }
        if (this.zzats != null) {
            zzacbVar.zza(3, this.zzats.booleanValue());
        }
        if (this.zzatt != null) {
            zzacbVar.zzb(4, this.zzatt);
        }
        if (this.zzatu != null) {
            zzacbVar.zza(5, this.zzatu.booleanValue());
        }
        if (this.zzatv != null) {
            zzacbVar.zza(6, this.zzatv.booleanValue());
        }
        super.zza(zzacbVar);
    }

    @Override // com.google.android.gms.internal.measurement.zzacj
    public final /* synthetic */ zzacj zzb(zzaca zzacaVar) throws zzaci {
        zzacj zzacjVar;
        while (true) {
            int iZzvl = zzacaVar.zzvl();
            if (iZzvl == 0) {
                return this;
            }
            if (iZzvl == 10) {
                if (this.zzatq == null) {
                    this.zzatq = new zzkl();
                }
                zzacjVar = this.zzatq;
            } else if (iZzvl == 18) {
                if (this.zzatr == null) {
                    this.zzatr = new zzkj();
                }
                zzacjVar = this.zzatr;
            } else if (iZzvl == 24) {
                this.zzats = Boolean.valueOf(zzacaVar.zzvm());
            } else if (iZzvl == 34) {
                this.zzatt = zzacaVar.readString();
            } else if (iZzvl == 40) {
                this.zzatu = Boolean.valueOf(zzacaVar.zzvm());
            } else if (iZzvl == 48) {
                this.zzatv = Boolean.valueOf(zzacaVar.zzvm());
            } else if (!super.zza(zzacaVar, iZzvl)) {
                return this;
            }
            zzacaVar.zza(zzacjVar);
        }
    }
}
