package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzkh extends zzacd<zzkh> {
    private static volatile zzkh[] zzatj;
    public Integer zzatk = null;
    public String zzatl = null;
    public zzki[] zzatm = zzki.zzls();
    private Boolean zzatn = null;
    public zzkj zzato = null;

    public zzkh() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    public static zzkh[] zzlr() {
        if (zzatj == null) {
            synchronized (zzach.zzbzn) {
                if (zzatj == null) {
                    zzatj = new zzkh[0];
                }
            }
        }
        return zzatj;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzkh)) {
            return false;
        }
        zzkh zzkhVar = (zzkh) obj;
        if (this.zzatk == null) {
            if (zzkhVar.zzatk != null) {
                return false;
            }
        } else if (!this.zzatk.equals(zzkhVar.zzatk)) {
            return false;
        }
        if (this.zzatl == null) {
            if (zzkhVar.zzatl != null) {
                return false;
            }
        } else if (!this.zzatl.equals(zzkhVar.zzatl)) {
            return false;
        }
        if (!zzach.equals(this.zzatm, zzkhVar.zzatm)) {
            return false;
        }
        if (this.zzatn == null) {
            if (zzkhVar.zzatn != null) {
                return false;
            }
        } else if (!this.zzatn.equals(zzkhVar.zzatn)) {
            return false;
        }
        if (this.zzato == null) {
            if (zzkhVar.zzato != null) {
                return false;
            }
        } else if (!this.zzato.equals(zzkhVar.zzato)) {
            return false;
        }
        return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzkhVar.zzbzd == null || zzkhVar.zzbzd.isEmpty() : this.zzbzd.equals(zzkhVar.zzbzd);
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = ((((((((getClass().getName().hashCode() + 527) * 31) + (this.zzatk == null ? 0 : this.zzatk.hashCode())) * 31) + (this.zzatl == null ? 0 : this.zzatl.hashCode())) * 31) + zzach.hashCode(this.zzatm)) * 31) + (this.zzatn == null ? 0 : this.zzatn.hashCode());
        zzkj zzkjVar = this.zzato;
        int iHashCode3 = ((iHashCode2 * 31) + (zzkjVar == null ? 0 : zzkjVar.hashCode())) * 31;
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
        if (this.zzatl != null) {
            iZza += zzacb.zzc(2, this.zzatl);
        }
        if (this.zzatm != null && this.zzatm.length > 0) {
            for (int i = 0; i < this.zzatm.length; i++) {
                zzki zzkiVar = this.zzatm[i];
                if (zzkiVar != null) {
                    iZza += zzacb.zzb(3, zzkiVar);
                }
            }
        }
        if (this.zzatn != null) {
            this.zzatn.booleanValue();
            iZza += zzacb.zzaq(4) + 1;
        }
        return this.zzato != null ? iZza + zzacb.zzb(5, this.zzato) : iZza;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzatk != null) {
            zzacbVar.zze(1, this.zzatk.intValue());
        }
        if (this.zzatl != null) {
            zzacbVar.zzb(2, this.zzatl);
        }
        if (this.zzatm != null && this.zzatm.length > 0) {
            for (int i = 0; i < this.zzatm.length; i++) {
                zzki zzkiVar = this.zzatm[i];
                if (zzkiVar != null) {
                    zzacbVar.zza(3, zzkiVar);
                }
            }
        }
        if (this.zzatn != null) {
            zzacbVar.zza(4, this.zzatn.booleanValue());
        }
        if (this.zzato != null) {
            zzacbVar.zza(5, this.zzato);
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
                this.zzatl = zzacaVar.readString();
            } else if (iZzvl == 26) {
                int iZzb = zzacm.zzb(zzacaVar, 26);
                int length = this.zzatm == null ? 0 : this.zzatm.length;
                zzki[] zzkiVarArr = new zzki[iZzb + length];
                if (length != 0) {
                    System.arraycopy(this.zzatm, 0, zzkiVarArr, 0, length);
                }
                while (length < zzkiVarArr.length - 1) {
                    zzkiVarArr[length] = new zzki();
                    zzacaVar.zza(zzkiVarArr[length]);
                    zzacaVar.zzvl();
                    length++;
                }
                zzkiVarArr[length] = new zzki();
                zzacaVar.zza(zzkiVarArr[length]);
                this.zzatm = zzkiVarArr;
            } else if (iZzvl == 32) {
                this.zzatn = Boolean.valueOf(zzacaVar.zzvm());
            } else if (iZzvl == 42) {
                if (this.zzato == null) {
                    this.zzato = new zzkj();
                }
                zzacaVar.zza(this.zzato);
            } else if (!super.zza(zzacaVar, iZzvl)) {
                return this;
            }
        }
    }
}
