package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzkg extends zzacd<zzkg> {
    private static volatile zzkg[] zzatd;
    public Integer zzate = null;
    public zzkk[] zzatf = zzkk.zzlt();
    public zzkh[] zzatg = zzkh.zzlr();
    public Boolean zzath = null;
    public Boolean zzati = null;

    public zzkg() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    public static zzkg[] zzlq() {
        if (zzatd == null) {
            synchronized (zzach.zzbzn) {
                if (zzatd == null) {
                    zzatd = new zzkg[0];
                }
            }
        }
        return zzatd;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzkg)) {
            return false;
        }
        zzkg zzkgVar = (zzkg) obj;
        if (this.zzate == null) {
            if (zzkgVar.zzate != null) {
                return false;
            }
        } else if (!this.zzate.equals(zzkgVar.zzate)) {
            return false;
        }
        if (!zzach.equals(this.zzatf, zzkgVar.zzatf) || !zzach.equals(this.zzatg, zzkgVar.zzatg)) {
            return false;
        }
        if (this.zzath == null) {
            if (zzkgVar.zzath != null) {
                return false;
            }
        } else if (!this.zzath.equals(zzkgVar.zzath)) {
            return false;
        }
        if (this.zzati == null) {
            if (zzkgVar.zzati != null) {
                return false;
            }
        } else if (!this.zzati.equals(zzkgVar.zzati)) {
            return false;
        }
        return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzkgVar.zzbzd == null || zzkgVar.zzbzd.isEmpty() : this.zzbzd.equals(zzkgVar.zzbzd);
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = (((((((((((getClass().getName().hashCode() + 527) * 31) + (this.zzate == null ? 0 : this.zzate.hashCode())) * 31) + zzach.hashCode(this.zzatf)) * 31) + zzach.hashCode(this.zzatg)) * 31) + (this.zzath == null ? 0 : this.zzath.hashCode())) * 31) + (this.zzati == null ? 0 : this.zzati.hashCode())) * 31;
        if (this.zzbzd != null && !this.zzbzd.isEmpty()) {
            iHashCode = this.zzbzd.hashCode();
        }
        return iHashCode2 + iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    protected final int zza() {
        int iZza = super.zza();
        if (this.zzate != null) {
            iZza += zzacb.zzf(1, this.zzate.intValue());
        }
        if (this.zzatf != null && this.zzatf.length > 0) {
            int iZzb = iZza;
            for (int i = 0; i < this.zzatf.length; i++) {
                zzkk zzkkVar = this.zzatf[i];
                if (zzkkVar != null) {
                    iZzb += zzacb.zzb(2, zzkkVar);
                }
            }
            iZza = iZzb;
        }
        if (this.zzatg != null && this.zzatg.length > 0) {
            for (int i2 = 0; i2 < this.zzatg.length; i2++) {
                zzkh zzkhVar = this.zzatg[i2];
                if (zzkhVar != null) {
                    iZza += zzacb.zzb(3, zzkhVar);
                }
            }
        }
        if (this.zzath != null) {
            this.zzath.booleanValue();
            iZza += zzacb.zzaq(4) + 1;
        }
        if (this.zzati == null) {
            return iZza;
        }
        this.zzati.booleanValue();
        return iZza + zzacb.zzaq(5) + 1;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzate != null) {
            zzacbVar.zze(1, this.zzate.intValue());
        }
        if (this.zzatf != null && this.zzatf.length > 0) {
            for (int i = 0; i < this.zzatf.length; i++) {
                zzkk zzkkVar = this.zzatf[i];
                if (zzkkVar != null) {
                    zzacbVar.zza(2, zzkkVar);
                }
            }
        }
        if (this.zzatg != null && this.zzatg.length > 0) {
            for (int i2 = 0; i2 < this.zzatg.length; i2++) {
                zzkh zzkhVar = this.zzatg[i2];
                if (zzkhVar != null) {
                    zzacbVar.zza(3, zzkhVar);
                }
            }
        }
        if (this.zzath != null) {
            zzacbVar.zza(4, this.zzath.booleanValue());
        }
        if (this.zzati != null) {
            zzacbVar.zza(5, this.zzati.booleanValue());
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
                this.zzate = Integer.valueOf(zzacaVar.zzvn());
            } else if (iZzvl == 18) {
                int iZzb = zzacm.zzb(zzacaVar, 18);
                int length = this.zzatf == null ? 0 : this.zzatf.length;
                zzkk[] zzkkVarArr = new zzkk[iZzb + length];
                if (length != 0) {
                    System.arraycopy(this.zzatf, 0, zzkkVarArr, 0, length);
                }
                while (length < zzkkVarArr.length - 1) {
                    zzkkVarArr[length] = new zzkk();
                    zzacaVar.zza(zzkkVarArr[length]);
                    zzacaVar.zzvl();
                    length++;
                }
                zzkkVarArr[length] = new zzkk();
                zzacaVar.zza(zzkkVarArr[length]);
                this.zzatf = zzkkVarArr;
            } else if (iZzvl == 26) {
                int iZzb2 = zzacm.zzb(zzacaVar, 26);
                int length2 = this.zzatg == null ? 0 : this.zzatg.length;
                zzkh[] zzkhVarArr = new zzkh[iZzb2 + length2];
                if (length2 != 0) {
                    System.arraycopy(this.zzatg, 0, zzkhVarArr, 0, length2);
                }
                while (length2 < zzkhVarArr.length - 1) {
                    zzkhVarArr[length2] = new zzkh();
                    zzacaVar.zza(zzkhVarArr[length2]);
                    zzacaVar.zzvl();
                    length2++;
                }
                zzkhVarArr[length2] = new zzkh();
                zzacaVar.zza(zzkhVarArr[length2]);
                this.zzatg = zzkhVarArr;
            } else if (iZzvl == 32) {
                this.zzath = Boolean.valueOf(zzacaVar.zzvm());
            } else if (iZzvl == 40) {
                this.zzati = Boolean.valueOf(zzacaVar.zzvm());
            } else if (!super.zza(zzacaVar, iZzvl)) {
                return this;
            }
        }
    }
}
