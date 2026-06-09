package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzko extends zzacd<zzko> {
    private static volatile zzko[] zzaur;
    public String zzny = null;
    public String value = null;

    public zzko() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    public static zzko[] zzlv() {
        if (zzaur == null) {
            synchronized (zzach.zzbzn) {
                if (zzaur == null) {
                    zzaur = new zzko[0];
                }
            }
        }
        return zzaur;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzko)) {
            return false;
        }
        zzko zzkoVar = (zzko) obj;
        if (this.zzny == null) {
            if (zzkoVar.zzny != null) {
                return false;
            }
        } else if (!this.zzny.equals(zzkoVar.zzny)) {
            return false;
        }
        if (this.value == null) {
            if (zzkoVar.value != null) {
                return false;
            }
        } else if (!this.value.equals(zzkoVar.value)) {
            return false;
        }
        return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzkoVar.zzbzd == null || zzkoVar.zzbzd.isEmpty() : this.zzbzd.equals(zzkoVar.zzbzd);
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = (((((getClass().getName().hashCode() + 527) * 31) + (this.zzny == null ? 0 : this.zzny.hashCode())) * 31) + (this.value == null ? 0 : this.value.hashCode())) * 31;
        if (this.zzbzd != null && !this.zzbzd.isEmpty()) {
            iHashCode = this.zzbzd.hashCode();
        }
        return iHashCode2 + iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    protected final int zza() {
        int iZza = super.zza();
        if (this.zzny != null) {
            iZza += zzacb.zzc(1, this.zzny);
        }
        return this.value != null ? iZza + zzacb.zzc(2, this.value) : iZza;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzny != null) {
            zzacbVar.zzb(1, this.zzny);
        }
        if (this.value != null) {
            zzacbVar.zzb(2, this.value);
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
                this.zzny = zzacaVar.readString();
            } else if (iZzvl == 18) {
                this.value = zzacaVar.readString();
            } else if (!super.zza(zzacaVar, iZzvl)) {
                return this;
            }
        }
    }
}
