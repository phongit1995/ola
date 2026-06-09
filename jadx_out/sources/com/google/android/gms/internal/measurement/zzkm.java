package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzkm extends zzacd<zzkm> {
    private static volatile zzkm[] zzaui;
    public String name = null;
    public Boolean zzauj = null;
    public Boolean zzauk = null;
    public Integer zzaul = null;

    public zzkm() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    public static zzkm[] zzlu() {
        if (zzaui == null) {
            synchronized (zzach.zzbzn) {
                if (zzaui == null) {
                    zzaui = new zzkm[0];
                }
            }
        }
        return zzaui;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzkm)) {
            return false;
        }
        zzkm zzkmVar = (zzkm) obj;
        if (this.name == null) {
            if (zzkmVar.name != null) {
                return false;
            }
        } else if (!this.name.equals(zzkmVar.name)) {
            return false;
        }
        if (this.zzauj == null) {
            if (zzkmVar.zzauj != null) {
                return false;
            }
        } else if (!this.zzauj.equals(zzkmVar.zzauj)) {
            return false;
        }
        if (this.zzauk == null) {
            if (zzkmVar.zzauk != null) {
                return false;
            }
        } else if (!this.zzauk.equals(zzkmVar.zzauk)) {
            return false;
        }
        if (this.zzaul == null) {
            if (zzkmVar.zzaul != null) {
                return false;
            }
        } else if (!this.zzaul.equals(zzkmVar.zzaul)) {
            return false;
        }
        return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzkmVar.zzbzd == null || zzkmVar.zzbzd.isEmpty() : this.zzbzd.equals(zzkmVar.zzbzd);
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = (((((((((getClass().getName().hashCode() + 527) * 31) + (this.name == null ? 0 : this.name.hashCode())) * 31) + (this.zzauj == null ? 0 : this.zzauj.hashCode())) * 31) + (this.zzauk == null ? 0 : this.zzauk.hashCode())) * 31) + (this.zzaul == null ? 0 : this.zzaul.hashCode())) * 31;
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
        if (this.zzauj != null) {
            this.zzauj.booleanValue();
            iZza += zzacb.zzaq(2) + 1;
        }
        if (this.zzauk != null) {
            this.zzauk.booleanValue();
            iZza += zzacb.zzaq(3) + 1;
        }
        return this.zzaul != null ? iZza + zzacb.zzf(4, this.zzaul.intValue()) : iZza;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.name != null) {
            zzacbVar.zzb(1, this.name);
        }
        if (this.zzauj != null) {
            zzacbVar.zza(2, this.zzauj.booleanValue());
        }
        if (this.zzauk != null) {
            zzacbVar.zza(3, this.zzauk.booleanValue());
        }
        if (this.zzaul != null) {
            zzacbVar.zze(4, this.zzaul.intValue());
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
            } else if (iZzvl == 16) {
                this.zzauj = Boolean.valueOf(zzacaVar.zzvm());
            } else if (iZzvl == 24) {
                this.zzauk = Boolean.valueOf(zzacaVar.zzvm());
            } else if (iZzvl == 32) {
                this.zzaul = Integer.valueOf(zzacaVar.zzvn());
            } else if (!super.zza(zzacaVar, iZzvl)) {
                return this;
            }
        }
    }
}
