package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzks extends zzacd<zzks> {
    private static volatile zzks[] zzavd;
    public String name = null;
    public String zzale = null;
    public Long zzave = null;
    private Float zzasv = null;
    public Double zzasw = null;

    public zzks() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    public static zzks[] zzlz() {
        if (zzavd == null) {
            synchronized (zzach.zzbzn) {
                if (zzavd == null) {
                    zzavd = new zzks[0];
                }
            }
        }
        return zzavd;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzks)) {
            return false;
        }
        zzks zzksVar = (zzks) obj;
        if (this.name == null) {
            if (zzksVar.name != null) {
                return false;
            }
        } else if (!this.name.equals(zzksVar.name)) {
            return false;
        }
        if (this.zzale == null) {
            if (zzksVar.zzale != null) {
                return false;
            }
        } else if (!this.zzale.equals(zzksVar.zzale)) {
            return false;
        }
        if (this.zzave == null) {
            if (zzksVar.zzave != null) {
                return false;
            }
        } else if (!this.zzave.equals(zzksVar.zzave)) {
            return false;
        }
        if (this.zzasv == null) {
            if (zzksVar.zzasv != null) {
                return false;
            }
        } else if (!this.zzasv.equals(zzksVar.zzasv)) {
            return false;
        }
        if (this.zzasw == null) {
            if (zzksVar.zzasw != null) {
                return false;
            }
        } else if (!this.zzasw.equals(zzksVar.zzasw)) {
            return false;
        }
        return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzksVar.zzbzd == null || zzksVar.zzbzd.isEmpty() : this.zzbzd.equals(zzksVar.zzbzd);
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = (((((((((((getClass().getName().hashCode() + 527) * 31) + (this.name == null ? 0 : this.name.hashCode())) * 31) + (this.zzale == null ? 0 : this.zzale.hashCode())) * 31) + (this.zzave == null ? 0 : this.zzave.hashCode())) * 31) + (this.zzasv == null ? 0 : this.zzasv.hashCode())) * 31) + (this.zzasw == null ? 0 : this.zzasw.hashCode())) * 31;
        if (this.zzbzd != null && !this.zzbzd.isEmpty()) {
            iHashCode = this.zzbzd.hashCode();
        }
        return iHashCode2 + iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    protected final int zza() {
        int iZza = super.zza();
        if (this.name != null) {
            iZza += zzacb.zzc(1, this.name);
        }
        if (this.zzale != null) {
            iZza += zzacb.zzc(2, this.zzale);
        }
        if (this.zzave != null) {
            iZza += zzacb.zzc(3, this.zzave.longValue());
        }
        if (this.zzasv != null) {
            this.zzasv.floatValue();
            iZza += zzacb.zzaq(4) + 4;
        }
        if (this.zzasw == null) {
            return iZza;
        }
        this.zzasw.doubleValue();
        return iZza + zzacb.zzaq(5) + 8;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.name != null) {
            zzacbVar.zzb(1, this.name);
        }
        if (this.zzale != null) {
            zzacbVar.zzb(2, this.zzale);
        }
        if (this.zzave != null) {
            zzacbVar.zzb(3, this.zzave.longValue());
        }
        if (this.zzasv != null) {
            zzacbVar.zza(4, this.zzasv.floatValue());
        }
        if (this.zzasw != null) {
            zzacbVar.zza(5, this.zzasw.doubleValue());
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
                this.name = zzacaVar.readString();
            } else if (iZzvl == 18) {
                this.zzale = zzacaVar.readString();
            } else if (iZzvl == 24) {
                this.zzave = Long.valueOf(zzacaVar.zzvo());
            } else if (iZzvl == 37) {
                this.zzasv = Float.valueOf(Float.intBitsToFloat(zzacaVar.zzvp()));
            } else if (iZzvl == 41) {
                this.zzasw = Double.valueOf(Double.longBitsToDouble(zzacaVar.zzvq()));
            } else if (!super.zza(zzacaVar, iZzvl)) {
                return this;
            }
        }
    }
}
