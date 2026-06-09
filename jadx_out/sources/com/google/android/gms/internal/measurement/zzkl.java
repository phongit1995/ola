package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzkl extends zzacd<zzkl> {
    public Integer zzaue = null;
    public String zzauf = null;
    public Boolean zzaug = null;
    public String[] zzauh = zzacm.zzbzx;

    public zzkl() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Override // com.google.android.gms.internal.measurement.zzacj
    /* JADX INFO: renamed from: zze, reason: merged with bridge method [inline-methods] */
    public final zzkl zzb(zzaca zzacaVar) throws zzaci {
        while (true) {
            int iZzvl = zzacaVar.zzvl();
            if (iZzvl == 0) {
                return this;
            }
            if (iZzvl == 8) {
                int position = zzacaVar.getPosition();
                try {
                    int iZzvn = zzacaVar.zzvn();
                    if (iZzvn < 0 || iZzvn > 6) {
                        StringBuilder sb = new StringBuilder(41);
                        sb.append(iZzvn);
                        sb.append(" is not a valid enum MatchType");
                        throw new IllegalArgumentException(sb.toString());
                    }
                    this.zzaue = Integer.valueOf(iZzvn);
                } catch (IllegalArgumentException unused) {
                    zzacaVar.zzam(position);
                    zza(zzacaVar, iZzvl);
                }
            } else if (iZzvl == 18) {
                this.zzauf = zzacaVar.readString();
            } else if (iZzvl == 24) {
                this.zzaug = Boolean.valueOf(zzacaVar.zzvm());
            } else if (iZzvl == 34) {
                int iZzb = zzacm.zzb(zzacaVar, 34);
                int length = this.zzauh == null ? 0 : this.zzauh.length;
                String[] strArr = new String[iZzb + length];
                if (length != 0) {
                    System.arraycopy(this.zzauh, 0, strArr, 0, length);
                }
                while (length < strArr.length - 1) {
                    strArr[length] = zzacaVar.readString();
                    zzacaVar.zzvl();
                    length++;
                }
                strArr[length] = zzacaVar.readString();
                this.zzauh = strArr;
            } else if (!super.zza(zzacaVar, iZzvl)) {
                return this;
            }
        }
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzkl)) {
            return false;
        }
        zzkl zzklVar = (zzkl) obj;
        if (this.zzaue == null) {
            if (zzklVar.zzaue != null) {
                return false;
            }
        } else if (!this.zzaue.equals(zzklVar.zzaue)) {
            return false;
        }
        if (this.zzauf == null) {
            if (zzklVar.zzauf != null) {
                return false;
            }
        } else if (!this.zzauf.equals(zzklVar.zzauf)) {
            return false;
        }
        if (this.zzaug == null) {
            if (zzklVar.zzaug != null) {
                return false;
            }
        } else if (!this.zzaug.equals(zzklVar.zzaug)) {
            return false;
        }
        if (zzach.equals(this.zzauh, zzklVar.zzauh)) {
            return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzklVar.zzbzd == null || zzklVar.zzbzd.isEmpty() : this.zzbzd.equals(zzklVar.zzbzd);
        }
        return false;
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = (((((((((getClass().getName().hashCode() + 527) * 31) + (this.zzaue == null ? 0 : this.zzaue.intValue())) * 31) + (this.zzauf == null ? 0 : this.zzauf.hashCode())) * 31) + (this.zzaug == null ? 0 : this.zzaug.hashCode())) * 31) + zzach.hashCode(this.zzauh)) * 31;
        if (this.zzbzd != null && !this.zzbzd.isEmpty()) {
            iHashCode = this.zzbzd.hashCode();
        }
        return iHashCode2 + iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    protected final int zza() {
        int iZza = super.zza();
        if (this.zzaue != null) {
            iZza += zzacb.zzf(1, this.zzaue.intValue());
        }
        if (this.zzauf != null) {
            iZza += zzacb.zzc(2, this.zzauf);
        }
        if (this.zzaug != null) {
            this.zzaug.booleanValue();
            iZza += zzacb.zzaq(3) + 1;
        }
        if (this.zzauh == null || this.zzauh.length <= 0) {
            return iZza;
        }
        int iZzfr = 0;
        int i = 0;
        for (int i2 = 0; i2 < this.zzauh.length; i2++) {
            String str = this.zzauh[i2];
            if (str != null) {
                i++;
                iZzfr += zzacb.zzfr(str);
            }
        }
        return iZza + iZzfr + (i * 1);
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzaue != null) {
            zzacbVar.zze(1, this.zzaue.intValue());
        }
        if (this.zzauf != null) {
            zzacbVar.zzb(2, this.zzauf);
        }
        if (this.zzaug != null) {
            zzacbVar.zza(3, this.zzaug.booleanValue());
        }
        if (this.zzauh != null && this.zzauh.length > 0) {
            for (int i = 0; i < this.zzauh.length; i++) {
                String str = this.zzauh[i];
                if (str != null) {
                    zzacbVar.zzb(4, str);
                }
            }
        }
        super.zza(zzacbVar);
    }
}
