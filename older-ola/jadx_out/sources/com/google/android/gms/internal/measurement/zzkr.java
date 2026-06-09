package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzkr extends zzacd<zzkr> {
    private static volatile zzkr[] zzauz;
    public zzks[] zzava = zzks.zzlz();
    public String name = null;
    public Long zzavb = null;
    public Long zzavc = null;
    public Integer count = null;

    public zzkr() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    public static zzkr[] zzly() {
        if (zzauz == null) {
            synchronized (zzach.zzbzn) {
                if (zzauz == null) {
                    zzauz = new zzkr[0];
                }
            }
        }
        return zzauz;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzkr)) {
            return false;
        }
        zzkr zzkrVar = (zzkr) obj;
        if (!zzach.equals(this.zzava, zzkrVar.zzava)) {
            return false;
        }
        if (this.name == null) {
            if (zzkrVar.name != null) {
                return false;
            }
        } else if (!this.name.equals(zzkrVar.name)) {
            return false;
        }
        if (this.zzavb == null) {
            if (zzkrVar.zzavb != null) {
                return false;
            }
        } else if (!this.zzavb.equals(zzkrVar.zzavb)) {
            return false;
        }
        if (this.zzavc == null) {
            if (zzkrVar.zzavc != null) {
                return false;
            }
        } else if (!this.zzavc.equals(zzkrVar.zzavc)) {
            return false;
        }
        if (this.count == null) {
            if (zzkrVar.count != null) {
                return false;
            }
        } else if (!this.count.equals(zzkrVar.count)) {
            return false;
        }
        return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzkrVar.zzbzd == null || zzkrVar.zzbzd.isEmpty() : this.zzbzd.equals(zzkrVar.zzbzd);
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = (((((((((((getClass().getName().hashCode() + 527) * 31) + zzach.hashCode(this.zzava)) * 31) + (this.name == null ? 0 : this.name.hashCode())) * 31) + (this.zzavb == null ? 0 : this.zzavb.hashCode())) * 31) + (this.zzavc == null ? 0 : this.zzavc.hashCode())) * 31) + (this.count == null ? 0 : this.count.hashCode())) * 31;
        if (this.zzbzd != null && !this.zzbzd.isEmpty()) {
            iHashCode = this.zzbzd.hashCode();
        }
        return iHashCode2 + iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    protected final int zza() {
        int iZza = super.zza();
        if (this.zzava != null && this.zzava.length > 0) {
            for (int i = 0; i < this.zzava.length; i++) {
                zzks zzksVar = this.zzava[i];
                if (zzksVar != null) {
                    iZza += zzacb.zzb(1, zzksVar);
                }
            }
        }
        if (this.name != null) {
            iZza += zzacb.zzc(2, this.name);
        }
        if (this.zzavb != null) {
            iZza += zzacb.zzc(3, this.zzavb.longValue());
        }
        if (this.zzavc != null) {
            iZza += zzacb.zzc(4, this.zzavc.longValue());
        }
        return this.count != null ? iZza + zzacb.zzf(5, this.count.intValue()) : iZza;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzava != null && this.zzava.length > 0) {
            for (int i = 0; i < this.zzava.length; i++) {
                zzks zzksVar = this.zzava[i];
                if (zzksVar != null) {
                    zzacbVar.zza(1, zzksVar);
                }
            }
        }
        if (this.name != null) {
            zzacbVar.zzb(2, this.name);
        }
        if (this.zzavb != null) {
            zzacbVar.zzb(3, this.zzavb.longValue());
        }
        if (this.zzavc != null) {
            zzacbVar.zzb(4, this.zzavc.longValue());
        }
        if (this.count != null) {
            zzacbVar.zze(5, this.count.intValue());
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
                int length = this.zzava == null ? 0 : this.zzava.length;
                zzks[] zzksVarArr = new zzks[iZzb + length];
                if (length != 0) {
                    System.arraycopy(this.zzava, 0, zzksVarArr, 0, length);
                }
                while (length < zzksVarArr.length - 1) {
                    zzksVarArr[length] = new zzks();
                    zzacaVar.zza(zzksVarArr[length]);
                    zzacaVar.zzvl();
                    length++;
                }
                zzksVarArr[length] = new zzks();
                zzacaVar.zza(zzksVarArr[length]);
                this.zzava = zzksVarArr;
            } else if (iZzvl == 18) {
                this.name = zzacaVar.readString();
            } else if (iZzvl == 24) {
                this.zzavb = Long.valueOf(zzacaVar.zzvo());
            } else if (iZzvl == 32) {
                this.zzavc = Long.valueOf(zzacaVar.zzvo());
            } else if (iZzvl == 40) {
                this.count = Integer.valueOf(zzacaVar.zzvn());
            } else if (!super.zza(zzacaVar, iZzvl)) {
                return this;
            }
        }
    }
}
