package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzkv extends zzacd<zzkv> {
    public long[] zzawl = zzacm.zzbzt;
    public long[] zzawm = zzacm.zzbzt;
    public zzkq[] zzawn = zzkq.zzlx();
    private zzkw[] zzawo = zzkw.zzmb();

    public zzkv() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzkv)) {
            return false;
        }
        zzkv zzkvVar = (zzkv) obj;
        if (zzach.equals(this.zzawl, zzkvVar.zzawl) && zzach.equals(this.zzawm, zzkvVar.zzawm) && zzach.equals(this.zzawn, zzkvVar.zzawn) && zzach.equals(this.zzawo, zzkvVar.zzawo)) {
            return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzkvVar.zzbzd == null || zzkvVar.zzbzd.isEmpty() : this.zzbzd.equals(zzkvVar.zzbzd);
        }
        return false;
    }

    public final int hashCode() {
        return ((((((((((getClass().getName().hashCode() + 527) * 31) + zzach.hashCode(this.zzawl)) * 31) + zzach.hashCode(this.zzawm)) * 31) + zzach.hashCode(this.zzawn)) * 31) + zzach.hashCode(this.zzawo)) * 31) + ((this.zzbzd == null || this.zzbzd.isEmpty()) ? 0 : this.zzbzd.hashCode());
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    protected final int zza() {
        int iZza = super.zza();
        if (this.zzawl != null && this.zzawl.length > 0) {
            int iZzat = 0;
            for (int i = 0; i < this.zzawl.length; i++) {
                iZzat += zzacb.zzat(this.zzawl[i]);
            }
            iZza = iZza + iZzat + (this.zzawl.length * 1);
        }
        if (this.zzawm != null && this.zzawm.length > 0) {
            int iZzat2 = 0;
            for (int i2 = 0; i2 < this.zzawm.length; i2++) {
                iZzat2 += zzacb.zzat(this.zzawm[i2]);
            }
            iZza = iZza + iZzat2 + (this.zzawm.length * 1);
        }
        if (this.zzawn != null && this.zzawn.length > 0) {
            int iZzb = iZza;
            for (int i3 = 0; i3 < this.zzawn.length; i3++) {
                zzkq zzkqVar = this.zzawn[i3];
                if (zzkqVar != null) {
                    iZzb += zzacb.zzb(3, zzkqVar);
                }
            }
            iZza = iZzb;
        }
        if (this.zzawo != null && this.zzawo.length > 0) {
            for (int i4 = 0; i4 < this.zzawo.length; i4++) {
                zzkw zzkwVar = this.zzawo[i4];
                if (zzkwVar != null) {
                    iZza += zzacb.zzb(4, zzkwVar);
                }
            }
        }
        return iZza;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzawl != null && this.zzawl.length > 0) {
            for (int i = 0; i < this.zzawl.length; i++) {
                zzacbVar.zza(1, this.zzawl[i]);
            }
        }
        if (this.zzawm != null && this.zzawm.length > 0) {
            for (int i2 = 0; i2 < this.zzawm.length; i2++) {
                zzacbVar.zza(2, this.zzawm[i2]);
            }
        }
        if (this.zzawn != null && this.zzawn.length > 0) {
            for (int i3 = 0; i3 < this.zzawn.length; i3++) {
                zzkq zzkqVar = this.zzawn[i3];
                if (zzkqVar != null) {
                    zzacbVar.zza(3, zzkqVar);
                }
            }
        }
        if (this.zzawo != null && this.zzawo.length > 0) {
            for (int i4 = 0; i4 < this.zzawo.length; i4++) {
                zzkw zzkwVar = this.zzawo[i4];
                if (zzkwVar != null) {
                    zzacbVar.zza(4, zzkwVar);
                }
            }
        }
        super.zza(zzacbVar);
    }

    @Override // com.google.android.gms.internal.measurement.zzacj
    public final /* synthetic */ zzacj zzb(zzaca zzacaVar) throws zzaci {
        int iZzaf;
        while (true) {
            int iZzvl = zzacaVar.zzvl();
            if (iZzvl == 0) {
                return this;
            }
            if (iZzvl != 8) {
                if (iZzvl == 10) {
                    iZzaf = zzacaVar.zzaf(zzacaVar.zzvn());
                    int position = zzacaVar.getPosition();
                    int i = 0;
                    while (zzacaVar.zzvr() > 0) {
                        zzacaVar.zzvo();
                        i++;
                    }
                    zzacaVar.zzam(position);
                    int length = this.zzawl == null ? 0 : this.zzawl.length;
                    long[] jArr = new long[i + length];
                    if (length != 0) {
                        System.arraycopy(this.zzawl, 0, jArr, 0, length);
                    }
                    while (length < jArr.length) {
                        jArr[length] = zzacaVar.zzvo();
                        length++;
                    }
                    this.zzawl = jArr;
                } else if (iZzvl == 16) {
                    int iZzb = zzacm.zzb(zzacaVar, 16);
                    int length2 = this.zzawm == null ? 0 : this.zzawm.length;
                    long[] jArr2 = new long[iZzb + length2];
                    if (length2 != 0) {
                        System.arraycopy(this.zzawm, 0, jArr2, 0, length2);
                    }
                    while (length2 < jArr2.length - 1) {
                        jArr2[length2] = zzacaVar.zzvo();
                        zzacaVar.zzvl();
                        length2++;
                    }
                    jArr2[length2] = zzacaVar.zzvo();
                    this.zzawm = jArr2;
                } else if (iZzvl == 18) {
                    iZzaf = zzacaVar.zzaf(zzacaVar.zzvn());
                    int position2 = zzacaVar.getPosition();
                    int i2 = 0;
                    while (zzacaVar.zzvr() > 0) {
                        zzacaVar.zzvo();
                        i2++;
                    }
                    zzacaVar.zzam(position2);
                    int length3 = this.zzawm == null ? 0 : this.zzawm.length;
                    long[] jArr3 = new long[i2 + length3];
                    if (length3 != 0) {
                        System.arraycopy(this.zzawm, 0, jArr3, 0, length3);
                    }
                    while (length3 < jArr3.length) {
                        jArr3[length3] = zzacaVar.zzvo();
                        length3++;
                    }
                    this.zzawm = jArr3;
                } else if (iZzvl == 26) {
                    int iZzb2 = zzacm.zzb(zzacaVar, 26);
                    int length4 = this.zzawn == null ? 0 : this.zzawn.length;
                    zzkq[] zzkqVarArr = new zzkq[iZzb2 + length4];
                    if (length4 != 0) {
                        System.arraycopy(this.zzawn, 0, zzkqVarArr, 0, length4);
                    }
                    while (length4 < zzkqVarArr.length - 1) {
                        zzkqVarArr[length4] = new zzkq();
                        zzacaVar.zza(zzkqVarArr[length4]);
                        zzacaVar.zzvl();
                        length4++;
                    }
                    zzkqVarArr[length4] = new zzkq();
                    zzacaVar.zza(zzkqVarArr[length4]);
                    this.zzawn = zzkqVarArr;
                } else if (iZzvl == 34) {
                    int iZzb3 = zzacm.zzb(zzacaVar, 34);
                    int length5 = this.zzawo == null ? 0 : this.zzawo.length;
                    zzkw[] zzkwVarArr = new zzkw[iZzb3 + length5];
                    if (length5 != 0) {
                        System.arraycopy(this.zzawo, 0, zzkwVarArr, 0, length5);
                    }
                    while (length5 < zzkwVarArr.length - 1) {
                        zzkwVarArr[length5] = new zzkw();
                        zzacaVar.zza(zzkwVarArr[length5]);
                        zzacaVar.zzvl();
                        length5++;
                    }
                    zzkwVarArr[length5] = new zzkw();
                    zzacaVar.zza(zzkwVarArr[length5]);
                    this.zzawo = zzkwVarArr;
                } else if (!super.zza(zzacaVar, iZzvl)) {
                    return this;
                }
                zzacaVar.zzal(iZzaf);
            } else {
                int iZzb4 = zzacm.zzb(zzacaVar, 8);
                int length6 = this.zzawl == null ? 0 : this.zzawl.length;
                long[] jArr4 = new long[iZzb4 + length6];
                if (length6 != 0) {
                    System.arraycopy(this.zzawl, 0, jArr4, 0, length6);
                }
                while (length6 < jArr4.length - 1) {
                    jArr4[length6] = zzacaVar.zzvo();
                    zzacaVar.zzvl();
                    length6++;
                }
                jArr4[length6] = zzacaVar.zzvo();
                this.zzawl = jArr4;
            }
        }
    }
}
