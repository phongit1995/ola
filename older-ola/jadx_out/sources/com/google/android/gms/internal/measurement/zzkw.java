package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzkw extends zzacd<zzkw> {
    private static volatile zzkw[] zzawp;
    private Integer zzaux = null;
    private long[] zzawq = zzacm.zzbzt;

    public zzkw() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    public static zzkw[] zzmb() {
        if (zzawp == null) {
            synchronized (zzach.zzbzn) {
                if (zzawp == null) {
                    zzawp = new zzkw[0];
                }
            }
        }
        return zzawp;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzkw)) {
            return false;
        }
        zzkw zzkwVar = (zzkw) obj;
        if (this.zzaux == null) {
            if (zzkwVar.zzaux != null) {
                return false;
            }
        } else if (!this.zzaux.equals(zzkwVar.zzaux)) {
            return false;
        }
        if (zzach.equals(this.zzawq, zzkwVar.zzawq)) {
            return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzkwVar.zzbzd == null || zzkwVar.zzbzd.isEmpty() : this.zzbzd.equals(zzkwVar.zzbzd);
        }
        return false;
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = (((((getClass().getName().hashCode() + 527) * 31) + (this.zzaux == null ? 0 : this.zzaux.hashCode())) * 31) + zzach.hashCode(this.zzawq)) * 31;
        if (this.zzbzd != null && !this.zzbzd.isEmpty()) {
            iHashCode = this.zzbzd.hashCode();
        }
        return iHashCode2 + iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    protected final int zza() {
        int iZza = super.zza();
        if (this.zzaux != null) {
            iZza += zzacb.zzf(1, this.zzaux.intValue());
        }
        if (this.zzawq == null || this.zzawq.length <= 0) {
            return iZza;
        }
        int iZzat = 0;
        for (int i = 0; i < this.zzawq.length; i++) {
            iZzat += zzacb.zzat(this.zzawq[i]);
        }
        return iZza + iZzat + (this.zzawq.length * 1);
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzaux != null) {
            zzacbVar.zze(1, this.zzaux.intValue());
        }
        if (this.zzawq != null && this.zzawq.length > 0) {
            for (int i = 0; i < this.zzawq.length; i++) {
                zzacbVar.zzb(2, this.zzawq[i]);
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
                this.zzaux = Integer.valueOf(zzacaVar.zzvn());
            } else if (iZzvl == 16) {
                int iZzb = zzacm.zzb(zzacaVar, 16);
                int length = this.zzawq == null ? 0 : this.zzawq.length;
                long[] jArr = new long[iZzb + length];
                if (length != 0) {
                    System.arraycopy(this.zzawq, 0, jArr, 0, length);
                }
                while (length < jArr.length - 1) {
                    jArr[length] = zzacaVar.zzvo();
                    zzacaVar.zzvl();
                    length++;
                }
                jArr[length] = zzacaVar.zzvo();
                this.zzawq = jArr;
            } else if (iZzvl == 18) {
                int iZzaf = zzacaVar.zzaf(zzacaVar.zzvn());
                int position = zzacaVar.getPosition();
                int i = 0;
                while (zzacaVar.zzvr() > 0) {
                    zzacaVar.zzvo();
                    i++;
                }
                zzacaVar.zzam(position);
                int length2 = this.zzawq == null ? 0 : this.zzawq.length;
                long[] jArr2 = new long[i + length2];
                if (length2 != 0) {
                    System.arraycopy(this.zzawq, 0, jArr2, 0, length2);
                }
                while (length2 < jArr2.length) {
                    jArr2[length2] = zzacaVar.zzvo();
                    length2++;
                }
                this.zzawq = jArr2;
                zzacaVar.zzal(iZzaf);
            } else if (!super.zza(zzacaVar, iZzvl)) {
                return this;
            }
        }
    }
}
