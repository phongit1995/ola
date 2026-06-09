package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzkn extends zzacd<zzkn> {
    public Long zzaum = null;
    public String zzafa = null;
    private Integer zzaun = null;
    public zzko[] zzauo = zzko.zzlv();
    public zzkm[] zzaup = zzkm.zzlu();
    public zzkg[] zzauq = zzkg.zzlq();

    public zzkn() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzkn)) {
            return false;
        }
        zzkn zzknVar = (zzkn) obj;
        if (this.zzaum == null) {
            if (zzknVar.zzaum != null) {
                return false;
            }
        } else if (!this.zzaum.equals(zzknVar.zzaum)) {
            return false;
        }
        if (this.zzafa == null) {
            if (zzknVar.zzafa != null) {
                return false;
            }
        } else if (!this.zzafa.equals(zzknVar.zzafa)) {
            return false;
        }
        if (this.zzaun == null) {
            if (zzknVar.zzaun != null) {
                return false;
            }
        } else if (!this.zzaun.equals(zzknVar.zzaun)) {
            return false;
        }
        if (zzach.equals(this.zzauo, zzknVar.zzauo) && zzach.equals(this.zzaup, zzknVar.zzaup) && zzach.equals(this.zzauq, zzknVar.zzauq)) {
            return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzknVar.zzbzd == null || zzknVar.zzbzd.isEmpty() : this.zzbzd.equals(zzknVar.zzbzd);
        }
        return false;
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = (((((((((((((getClass().getName().hashCode() + 527) * 31) + (this.zzaum == null ? 0 : this.zzaum.hashCode())) * 31) + (this.zzafa == null ? 0 : this.zzafa.hashCode())) * 31) + (this.zzaun == null ? 0 : this.zzaun.hashCode())) * 31) + zzach.hashCode(this.zzauo)) * 31) + zzach.hashCode(this.zzaup)) * 31) + zzach.hashCode(this.zzauq)) * 31;
        if (this.zzbzd != null && !this.zzbzd.isEmpty()) {
            iHashCode = this.zzbzd.hashCode();
        }
        return iHashCode2 + iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    protected final int zza() {
        int iZza = super.zza();
        if (this.zzaum != null) {
            iZza += zzacb.zzc(1, this.zzaum.longValue());
        }
        if (this.zzafa != null) {
            iZza += zzacb.zzc(2, this.zzafa);
        }
        if (this.zzaun != null) {
            iZza += zzacb.zzf(3, this.zzaun.intValue());
        }
        if (this.zzauo != null && this.zzauo.length > 0) {
            int iZzb = iZza;
            for (int i = 0; i < this.zzauo.length; i++) {
                zzko zzkoVar = this.zzauo[i];
                if (zzkoVar != null) {
                    iZzb += zzacb.zzb(4, zzkoVar);
                }
            }
            iZza = iZzb;
        }
        if (this.zzaup != null && this.zzaup.length > 0) {
            int iZzb2 = iZza;
            for (int i2 = 0; i2 < this.zzaup.length; i2++) {
                zzkm zzkmVar = this.zzaup[i2];
                if (zzkmVar != null) {
                    iZzb2 += zzacb.zzb(5, zzkmVar);
                }
            }
            iZza = iZzb2;
        }
        if (this.zzauq != null && this.zzauq.length > 0) {
            for (int i3 = 0; i3 < this.zzauq.length; i3++) {
                zzkg zzkgVar = this.zzauq[i3];
                if (zzkgVar != null) {
                    iZza += zzacb.zzb(6, zzkgVar);
                }
            }
        }
        return iZza;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzaum != null) {
            zzacbVar.zzb(1, this.zzaum.longValue());
        }
        if (this.zzafa != null) {
            zzacbVar.zzb(2, this.zzafa);
        }
        if (this.zzaun != null) {
            zzacbVar.zze(3, this.zzaun.intValue());
        }
        if (this.zzauo != null && this.zzauo.length > 0) {
            for (int i = 0; i < this.zzauo.length; i++) {
                zzko zzkoVar = this.zzauo[i];
                if (zzkoVar != null) {
                    zzacbVar.zza(4, zzkoVar);
                }
            }
        }
        if (this.zzaup != null && this.zzaup.length > 0) {
            for (int i2 = 0; i2 < this.zzaup.length; i2++) {
                zzkm zzkmVar = this.zzaup[i2];
                if (zzkmVar != null) {
                    zzacbVar.zza(5, zzkmVar);
                }
            }
        }
        if (this.zzauq != null && this.zzauq.length > 0) {
            for (int i3 = 0; i3 < this.zzauq.length; i3++) {
                zzkg zzkgVar = this.zzauq[i3];
                if (zzkgVar != null) {
                    zzacbVar.zza(6, zzkgVar);
                }
            }
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
                this.zzaum = Long.valueOf(zzacaVar.zzvo());
            } else if (iZzvl == 18) {
                this.zzafa = zzacaVar.readString();
            } else if (iZzvl == 24) {
                this.zzaun = Integer.valueOf(zzacaVar.zzvn());
            } else if (iZzvl == 34) {
                int iZzb = zzacm.zzb(zzacaVar, 34);
                int length = this.zzauo == null ? 0 : this.zzauo.length;
                zzko[] zzkoVarArr = new zzko[iZzb + length];
                if (length != 0) {
                    System.arraycopy(this.zzauo, 0, zzkoVarArr, 0, length);
                }
                while (length < zzkoVarArr.length - 1) {
                    zzkoVarArr[length] = new zzko();
                    zzacaVar.zza(zzkoVarArr[length]);
                    zzacaVar.zzvl();
                    length++;
                }
                zzkoVarArr[length] = new zzko();
                zzacaVar.zza(zzkoVarArr[length]);
                this.zzauo = zzkoVarArr;
            } else if (iZzvl == 42) {
                int iZzb2 = zzacm.zzb(zzacaVar, 42);
                int length2 = this.zzaup == null ? 0 : this.zzaup.length;
                zzkm[] zzkmVarArr = new zzkm[iZzb2 + length2];
                if (length2 != 0) {
                    System.arraycopy(this.zzaup, 0, zzkmVarArr, 0, length2);
                }
                while (length2 < zzkmVarArr.length - 1) {
                    zzkmVarArr[length2] = new zzkm();
                    zzacaVar.zza(zzkmVarArr[length2]);
                    zzacaVar.zzvl();
                    length2++;
                }
                zzkmVarArr[length2] = new zzkm();
                zzacaVar.zza(zzkmVarArr[length2]);
                this.zzaup = zzkmVarArr;
            } else if (iZzvl == 50) {
                int iZzb3 = zzacm.zzb(zzacaVar, 50);
                int length3 = this.zzauq == null ? 0 : this.zzauq.length;
                zzkg[] zzkgVarArr = new zzkg[iZzb3 + length3];
                if (length3 != 0) {
                    System.arraycopy(this.zzauq, 0, zzkgVarArr, 0, length3);
                }
                while (length3 < zzkgVarArr.length - 1) {
                    zzkgVarArr[length3] = new zzkg();
                    zzacaVar.zza(zzkgVarArr[length3]);
                    zzacaVar.zzvl();
                    length3++;
                }
                zzkgVarArr[length3] = new zzkg();
                zzacaVar.zza(zzkgVarArr[length3]);
                this.zzauq = zzkgVarArr;
            } else if (!super.zza(zzacaVar, iZzvl)) {
                return this;
            }
        }
    }
}
