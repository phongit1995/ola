package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzkj extends zzacd<zzkj> {
    public Integer zzatw = null;
    public Boolean zzatx = null;
    public String zzaty = null;
    public String zzatz = null;
    public String zzaua = null;

    public zzkj() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Override // com.google.android.gms.internal.measurement.zzacj
    /* JADX INFO: renamed from: zzd, reason: merged with bridge method [inline-methods] */
    public final zzkj zzb(zzaca zzacaVar) throws zzaci {
        while (true) {
            int iZzvl = zzacaVar.zzvl();
            if (iZzvl == 0) {
                return this;
            }
            if (iZzvl == 8) {
                int position = zzacaVar.getPosition();
                try {
                    int iZzvn = zzacaVar.zzvn();
                    if (iZzvn < 0 || iZzvn > 4) {
                        StringBuilder sb = new StringBuilder(46);
                        sb.append(iZzvn);
                        sb.append(" is not a valid enum ComparisonType");
                        throw new IllegalArgumentException(sb.toString());
                    }
                    this.zzatw = Integer.valueOf(iZzvn);
                } catch (IllegalArgumentException unused) {
                    zzacaVar.zzam(position);
                    zza(zzacaVar, iZzvl);
                }
            } else if (iZzvl == 16) {
                this.zzatx = Boolean.valueOf(zzacaVar.zzvm());
            } else if (iZzvl == 26) {
                this.zzaty = zzacaVar.readString();
            } else if (iZzvl == 34) {
                this.zzatz = zzacaVar.readString();
            } else if (iZzvl == 42) {
                this.zzaua = zzacaVar.readString();
            } else if (!super.zza(zzacaVar, iZzvl)) {
                return this;
            }
        }
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzkj)) {
            return false;
        }
        zzkj zzkjVar = (zzkj) obj;
        if (this.zzatw == null) {
            if (zzkjVar.zzatw != null) {
                return false;
            }
        } else if (!this.zzatw.equals(zzkjVar.zzatw)) {
            return false;
        }
        if (this.zzatx == null) {
            if (zzkjVar.zzatx != null) {
                return false;
            }
        } else if (!this.zzatx.equals(zzkjVar.zzatx)) {
            return false;
        }
        if (this.zzaty == null) {
            if (zzkjVar.zzaty != null) {
                return false;
            }
        } else if (!this.zzaty.equals(zzkjVar.zzaty)) {
            return false;
        }
        if (this.zzatz == null) {
            if (zzkjVar.zzatz != null) {
                return false;
            }
        } else if (!this.zzatz.equals(zzkjVar.zzatz)) {
            return false;
        }
        if (this.zzaua == null) {
            if (zzkjVar.zzaua != null) {
                return false;
            }
        } else if (!this.zzaua.equals(zzkjVar.zzaua)) {
            return false;
        }
        return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzkjVar.zzbzd == null || zzkjVar.zzbzd.isEmpty() : this.zzbzd.equals(zzkjVar.zzbzd);
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = (((((((((((getClass().getName().hashCode() + 527) * 31) + (this.zzatw == null ? 0 : this.zzatw.intValue())) * 31) + (this.zzatx == null ? 0 : this.zzatx.hashCode())) * 31) + (this.zzaty == null ? 0 : this.zzaty.hashCode())) * 31) + (this.zzatz == null ? 0 : this.zzatz.hashCode())) * 31) + (this.zzaua == null ? 0 : this.zzaua.hashCode())) * 31;
        if (this.zzbzd != null && !this.zzbzd.isEmpty()) {
            iHashCode = this.zzbzd.hashCode();
        }
        return iHashCode2 + iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    protected final int zza() {
        int iZza = super.zza();
        if (this.zzatw != null) {
            iZza += zzacb.zzf(1, this.zzatw.intValue());
        }
        if (this.zzatx != null) {
            this.zzatx.booleanValue();
            iZza += zzacb.zzaq(2) + 1;
        }
        if (this.zzaty != null) {
            iZza += zzacb.zzc(3, this.zzaty);
        }
        if (this.zzatz != null) {
            iZza += zzacb.zzc(4, this.zzatz);
        }
        return this.zzaua != null ? iZza + zzacb.zzc(5, this.zzaua) : iZza;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzatw != null) {
            zzacbVar.zze(1, this.zzatw.intValue());
        }
        if (this.zzatx != null) {
            zzacbVar.zza(2, this.zzatx.booleanValue());
        }
        if (this.zzaty != null) {
            zzacbVar.zzb(3, this.zzaty);
        }
        if (this.zzatz != null) {
            zzacbVar.zzb(4, this.zzatz);
        }
        if (this.zzaua != null) {
            zzacbVar.zzb(5, this.zzaua);
        }
        super.zza(zzacbVar);
    }
}
