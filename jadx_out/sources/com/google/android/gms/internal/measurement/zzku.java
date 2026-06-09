package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzku extends zzacd<zzku> {
    private static volatile zzku[] zzavg;
    public Integer zzavh = null;
    public zzkr[] zzavi = zzkr.zzly();
    public zzkx[] zzavj = zzkx.zzmc();
    public Long zzavk = null;
    public Long zzavl = null;
    public Long zzavm = null;
    public Long zzavn = null;
    public Long zzavo = null;
    public String zzavp = null;
    public String zzavq = null;
    public String zzavr = null;
    public String zzahd = null;
    public Integer zzavs = null;
    public String zzafh = null;
    public String zzth = null;
    public String zztg = null;
    public Long zzavt = null;
    public Long zzavu = null;
    public String zzavv = null;
    public Boolean zzavw = null;
    public String zzaez = null;
    public Long zzavx = null;
    public Integer zzavy = null;
    public String zzafy = null;
    public String zzafa = null;
    public Boolean zzavz = null;
    public zzkp[] zzawa = zzkp.zzlw();
    public String zzafc = null;
    public Integer zzawb = null;
    private Integer zzawc = null;
    private Integer zzawd = null;
    public String zzawe = null;
    public Long zzawf = null;
    public Long zzawg = null;
    public String zzawh = null;
    private String zzawi = null;
    public Integer zzawj = null;
    private String zzawk = null;

    public zzku() {
        this.zzbzd = null;
        this.zzbzo = -1;
    }

    public static zzku[] zzma() {
        if (zzavg == null) {
            synchronized (zzach.zzbzn) {
                if (zzavg == null) {
                    zzavg = new zzku[0];
                }
            }
        }
        return zzavg;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzku)) {
            return false;
        }
        zzku zzkuVar = (zzku) obj;
        if (this.zzavh == null) {
            if (zzkuVar.zzavh != null) {
                return false;
            }
        } else if (!this.zzavh.equals(zzkuVar.zzavh)) {
            return false;
        }
        if (!zzach.equals(this.zzavi, zzkuVar.zzavi) || !zzach.equals(this.zzavj, zzkuVar.zzavj)) {
            return false;
        }
        if (this.zzavk == null) {
            if (zzkuVar.zzavk != null) {
                return false;
            }
        } else if (!this.zzavk.equals(zzkuVar.zzavk)) {
            return false;
        }
        if (this.zzavl == null) {
            if (zzkuVar.zzavl != null) {
                return false;
            }
        } else if (!this.zzavl.equals(zzkuVar.zzavl)) {
            return false;
        }
        if (this.zzavm == null) {
            if (zzkuVar.zzavm != null) {
                return false;
            }
        } else if (!this.zzavm.equals(zzkuVar.zzavm)) {
            return false;
        }
        if (this.zzavn == null) {
            if (zzkuVar.zzavn != null) {
                return false;
            }
        } else if (!this.zzavn.equals(zzkuVar.zzavn)) {
            return false;
        }
        if (this.zzavo == null) {
            if (zzkuVar.zzavo != null) {
                return false;
            }
        } else if (!this.zzavo.equals(zzkuVar.zzavo)) {
            return false;
        }
        if (this.zzavp == null) {
            if (zzkuVar.zzavp != null) {
                return false;
            }
        } else if (!this.zzavp.equals(zzkuVar.zzavp)) {
            return false;
        }
        if (this.zzavq == null) {
            if (zzkuVar.zzavq != null) {
                return false;
            }
        } else if (!this.zzavq.equals(zzkuVar.zzavq)) {
            return false;
        }
        if (this.zzavr == null) {
            if (zzkuVar.zzavr != null) {
                return false;
            }
        } else if (!this.zzavr.equals(zzkuVar.zzavr)) {
            return false;
        }
        if (this.zzahd == null) {
            if (zzkuVar.zzahd != null) {
                return false;
            }
        } else if (!this.zzahd.equals(zzkuVar.zzahd)) {
            return false;
        }
        if (this.zzavs == null) {
            if (zzkuVar.zzavs != null) {
                return false;
            }
        } else if (!this.zzavs.equals(zzkuVar.zzavs)) {
            return false;
        }
        if (this.zzafh == null) {
            if (zzkuVar.zzafh != null) {
                return false;
            }
        } else if (!this.zzafh.equals(zzkuVar.zzafh)) {
            return false;
        }
        if (this.zzth == null) {
            if (zzkuVar.zzth != null) {
                return false;
            }
        } else if (!this.zzth.equals(zzkuVar.zzth)) {
            return false;
        }
        if (this.zztg == null) {
            if (zzkuVar.zztg != null) {
                return false;
            }
        } else if (!this.zztg.equals(zzkuVar.zztg)) {
            return false;
        }
        if (this.zzavt == null) {
            if (zzkuVar.zzavt != null) {
                return false;
            }
        } else if (!this.zzavt.equals(zzkuVar.zzavt)) {
            return false;
        }
        if (this.zzavu == null) {
            if (zzkuVar.zzavu != null) {
                return false;
            }
        } else if (!this.zzavu.equals(zzkuVar.zzavu)) {
            return false;
        }
        if (this.zzavv == null) {
            if (zzkuVar.zzavv != null) {
                return false;
            }
        } else if (!this.zzavv.equals(zzkuVar.zzavv)) {
            return false;
        }
        if (this.zzavw == null) {
            if (zzkuVar.zzavw != null) {
                return false;
            }
        } else if (!this.zzavw.equals(zzkuVar.zzavw)) {
            return false;
        }
        if (this.zzaez == null) {
            if (zzkuVar.zzaez != null) {
                return false;
            }
        } else if (!this.zzaez.equals(zzkuVar.zzaez)) {
            return false;
        }
        if (this.zzavx == null) {
            if (zzkuVar.zzavx != null) {
                return false;
            }
        } else if (!this.zzavx.equals(zzkuVar.zzavx)) {
            return false;
        }
        if (this.zzavy == null) {
            if (zzkuVar.zzavy != null) {
                return false;
            }
        } else if (!this.zzavy.equals(zzkuVar.zzavy)) {
            return false;
        }
        if (this.zzafy == null) {
            if (zzkuVar.zzafy != null) {
                return false;
            }
        } else if (!this.zzafy.equals(zzkuVar.zzafy)) {
            return false;
        }
        if (this.zzafa == null) {
            if (zzkuVar.zzafa != null) {
                return false;
            }
        } else if (!this.zzafa.equals(zzkuVar.zzafa)) {
            return false;
        }
        if (this.zzavz == null) {
            if (zzkuVar.zzavz != null) {
                return false;
            }
        } else if (!this.zzavz.equals(zzkuVar.zzavz)) {
            return false;
        }
        if (!zzach.equals(this.zzawa, zzkuVar.zzawa)) {
            return false;
        }
        if (this.zzafc == null) {
            if (zzkuVar.zzafc != null) {
                return false;
            }
        } else if (!this.zzafc.equals(zzkuVar.zzafc)) {
            return false;
        }
        if (this.zzawb == null) {
            if (zzkuVar.zzawb != null) {
                return false;
            }
        } else if (!this.zzawb.equals(zzkuVar.zzawb)) {
            return false;
        }
        if (this.zzawc == null) {
            if (zzkuVar.zzawc != null) {
                return false;
            }
        } else if (!this.zzawc.equals(zzkuVar.zzawc)) {
            return false;
        }
        if (this.zzawd == null) {
            if (zzkuVar.zzawd != null) {
                return false;
            }
        } else if (!this.zzawd.equals(zzkuVar.zzawd)) {
            return false;
        }
        if (this.zzawe == null) {
            if (zzkuVar.zzawe != null) {
                return false;
            }
        } else if (!this.zzawe.equals(zzkuVar.zzawe)) {
            return false;
        }
        if (this.zzawf == null) {
            if (zzkuVar.zzawf != null) {
                return false;
            }
        } else if (!this.zzawf.equals(zzkuVar.zzawf)) {
            return false;
        }
        if (this.zzawg == null) {
            if (zzkuVar.zzawg != null) {
                return false;
            }
        } else if (!this.zzawg.equals(zzkuVar.zzawg)) {
            return false;
        }
        if (this.zzawh == null) {
            if (zzkuVar.zzawh != null) {
                return false;
            }
        } else if (!this.zzawh.equals(zzkuVar.zzawh)) {
            return false;
        }
        if (this.zzawi == null) {
            if (zzkuVar.zzawi != null) {
                return false;
            }
        } else if (!this.zzawi.equals(zzkuVar.zzawi)) {
            return false;
        }
        if (this.zzawj == null) {
            if (zzkuVar.zzawj != null) {
                return false;
            }
        } else if (!this.zzawj.equals(zzkuVar.zzawj)) {
            return false;
        }
        if (this.zzawk == null) {
            if (zzkuVar.zzawk != null) {
                return false;
            }
        } else if (!this.zzawk.equals(zzkuVar.zzawk)) {
            return false;
        }
        return (this.zzbzd == null || this.zzbzd.isEmpty()) ? zzkuVar.zzbzd == null || zzkuVar.zzbzd.isEmpty() : this.zzbzd.equals(zzkuVar.zzbzd);
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((getClass().getName().hashCode() + 527) * 31) + (this.zzavh == null ? 0 : this.zzavh.hashCode())) * 31) + zzach.hashCode(this.zzavi)) * 31) + zzach.hashCode(this.zzavj)) * 31) + (this.zzavk == null ? 0 : this.zzavk.hashCode())) * 31) + (this.zzavl == null ? 0 : this.zzavl.hashCode())) * 31) + (this.zzavm == null ? 0 : this.zzavm.hashCode())) * 31) + (this.zzavn == null ? 0 : this.zzavn.hashCode())) * 31) + (this.zzavo == null ? 0 : this.zzavo.hashCode())) * 31) + (this.zzavp == null ? 0 : this.zzavp.hashCode())) * 31) + (this.zzavq == null ? 0 : this.zzavq.hashCode())) * 31) + (this.zzavr == null ? 0 : this.zzavr.hashCode())) * 31) + (this.zzahd == null ? 0 : this.zzahd.hashCode())) * 31) + (this.zzavs == null ? 0 : this.zzavs.hashCode())) * 31) + (this.zzafh == null ? 0 : this.zzafh.hashCode())) * 31) + (this.zzth == null ? 0 : this.zzth.hashCode())) * 31) + (this.zztg == null ? 0 : this.zztg.hashCode())) * 31) + (this.zzavt == null ? 0 : this.zzavt.hashCode())) * 31) + (this.zzavu == null ? 0 : this.zzavu.hashCode())) * 31) + (this.zzavv == null ? 0 : this.zzavv.hashCode())) * 31) + (this.zzavw == null ? 0 : this.zzavw.hashCode())) * 31) + (this.zzaez == null ? 0 : this.zzaez.hashCode())) * 31) + (this.zzavx == null ? 0 : this.zzavx.hashCode())) * 31) + (this.zzavy == null ? 0 : this.zzavy.hashCode())) * 31) + (this.zzafy == null ? 0 : this.zzafy.hashCode())) * 31) + (this.zzafa == null ? 0 : this.zzafa.hashCode())) * 31) + (this.zzavz == null ? 0 : this.zzavz.hashCode())) * 31) + zzach.hashCode(this.zzawa)) * 31) + (this.zzafc == null ? 0 : this.zzafc.hashCode())) * 31) + (this.zzawb == null ? 0 : this.zzawb.hashCode())) * 31) + (this.zzawc == null ? 0 : this.zzawc.hashCode())) * 31) + (this.zzawd == null ? 0 : this.zzawd.hashCode())) * 31) + (this.zzawe == null ? 0 : this.zzawe.hashCode())) * 31) + (this.zzawf == null ? 0 : this.zzawf.hashCode())) * 31) + (this.zzawg == null ? 0 : this.zzawg.hashCode())) * 31) + (this.zzawh == null ? 0 : this.zzawh.hashCode())) * 31) + (this.zzawi == null ? 0 : this.zzawi.hashCode())) * 31) + (this.zzawj == null ? 0 : this.zzawj.hashCode())) * 31) + (this.zzawk == null ? 0 : this.zzawk.hashCode())) * 31;
        if (this.zzbzd != null && !this.zzbzd.isEmpty()) {
            iHashCode = this.zzbzd.hashCode();
        }
        return iHashCode2 + iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    protected final int zza() {
        int iZza = super.zza();
        if (this.zzavh != null) {
            iZza += zzacb.zzf(1, this.zzavh.intValue());
        }
        if (this.zzavi != null && this.zzavi.length > 0) {
            int iZzb = iZza;
            for (int i = 0; i < this.zzavi.length; i++) {
                zzkr zzkrVar = this.zzavi[i];
                if (zzkrVar != null) {
                    iZzb += zzacb.zzb(2, zzkrVar);
                }
            }
            iZza = iZzb;
        }
        if (this.zzavj != null && this.zzavj.length > 0) {
            int iZzb2 = iZza;
            for (int i2 = 0; i2 < this.zzavj.length; i2++) {
                zzkx zzkxVar = this.zzavj[i2];
                if (zzkxVar != null) {
                    iZzb2 += zzacb.zzb(3, zzkxVar);
                }
            }
            iZza = iZzb2;
        }
        if (this.zzavk != null) {
            iZza += zzacb.zzc(4, this.zzavk.longValue());
        }
        if (this.zzavl != null) {
            iZza += zzacb.zzc(5, this.zzavl.longValue());
        }
        if (this.zzavm != null) {
            iZza += zzacb.zzc(6, this.zzavm.longValue());
        }
        if (this.zzavo != null) {
            iZza += zzacb.zzc(7, this.zzavo.longValue());
        }
        if (this.zzavp != null) {
            iZza += zzacb.zzc(8, this.zzavp);
        }
        if (this.zzavq != null) {
            iZza += zzacb.zzc(9, this.zzavq);
        }
        if (this.zzavr != null) {
            iZza += zzacb.zzc(10, this.zzavr);
        }
        if (this.zzahd != null) {
            iZza += zzacb.zzc(11, this.zzahd);
        }
        if (this.zzavs != null) {
            iZza += zzacb.zzf(12, this.zzavs.intValue());
        }
        if (this.zzafh != null) {
            iZza += zzacb.zzc(13, this.zzafh);
        }
        if (this.zzth != null) {
            iZza += zzacb.zzc(14, this.zzth);
        }
        if (this.zztg != null) {
            iZza += zzacb.zzc(16, this.zztg);
        }
        if (this.zzavt != null) {
            iZza += zzacb.zzc(17, this.zzavt.longValue());
        }
        if (this.zzavu != null) {
            iZza += zzacb.zzc(18, this.zzavu.longValue());
        }
        if (this.zzavv != null) {
            iZza += zzacb.zzc(19, this.zzavv);
        }
        if (this.zzavw != null) {
            this.zzavw.booleanValue();
            iZza += zzacb.zzaq(20) + 1;
        }
        if (this.zzaez != null) {
            iZza += zzacb.zzc(21, this.zzaez);
        }
        if (this.zzavx != null) {
            iZza += zzacb.zzc(22, this.zzavx.longValue());
        }
        if (this.zzavy != null) {
            iZza += zzacb.zzf(23, this.zzavy.intValue());
        }
        if (this.zzafy != null) {
            iZza += zzacb.zzc(24, this.zzafy);
        }
        if (this.zzafa != null) {
            iZza += zzacb.zzc(25, this.zzafa);
        }
        if (this.zzavn != null) {
            iZza += zzacb.zzc(26, this.zzavn.longValue());
        }
        if (this.zzavz != null) {
            this.zzavz.booleanValue();
            iZza += zzacb.zzaq(28) + 1;
        }
        if (this.zzawa != null && this.zzawa.length > 0) {
            for (int i3 = 0; i3 < this.zzawa.length; i3++) {
                zzkp zzkpVar = this.zzawa[i3];
                if (zzkpVar != null) {
                    iZza += zzacb.zzb(29, zzkpVar);
                }
            }
        }
        if (this.zzafc != null) {
            iZza += zzacb.zzc(30, this.zzafc);
        }
        if (this.zzawb != null) {
            iZza += zzacb.zzf(31, this.zzawb.intValue());
        }
        if (this.zzawc != null) {
            iZza += zzacb.zzf(32, this.zzawc.intValue());
        }
        if (this.zzawd != null) {
            iZza += zzacb.zzf(33, this.zzawd.intValue());
        }
        if (this.zzawe != null) {
            iZza += zzacb.zzc(34, this.zzawe);
        }
        if (this.zzawf != null) {
            iZza += zzacb.zzc(35, this.zzawf.longValue());
        }
        if (this.zzawg != null) {
            iZza += zzacb.zzc(36, this.zzawg.longValue());
        }
        if (this.zzawh != null) {
            iZza += zzacb.zzc(37, this.zzawh);
        }
        if (this.zzawi != null) {
            iZza += zzacb.zzc(38, this.zzawi);
        }
        if (this.zzawj != null) {
            iZza += zzacb.zzf(39, this.zzawj.intValue());
        }
        return this.zzawk != null ? iZza + zzacb.zzc(41, this.zzawk) : iZza;
    }

    @Override // com.google.android.gms.internal.measurement.zzacd, com.google.android.gms.internal.measurement.zzacj
    public final void zza(zzacb zzacbVar) throws zzacc {
        if (this.zzavh != null) {
            zzacbVar.zze(1, this.zzavh.intValue());
        }
        if (this.zzavi != null && this.zzavi.length > 0) {
            for (int i = 0; i < this.zzavi.length; i++) {
                zzkr zzkrVar = this.zzavi[i];
                if (zzkrVar != null) {
                    zzacbVar.zza(2, zzkrVar);
                }
            }
        }
        if (this.zzavj != null && this.zzavj.length > 0) {
            for (int i2 = 0; i2 < this.zzavj.length; i2++) {
                zzkx zzkxVar = this.zzavj[i2];
                if (zzkxVar != null) {
                    zzacbVar.zza(3, zzkxVar);
                }
            }
        }
        if (this.zzavk != null) {
            zzacbVar.zzb(4, this.zzavk.longValue());
        }
        if (this.zzavl != null) {
            zzacbVar.zzb(5, this.zzavl.longValue());
        }
        if (this.zzavm != null) {
            zzacbVar.zzb(6, this.zzavm.longValue());
        }
        if (this.zzavo != null) {
            zzacbVar.zzb(7, this.zzavo.longValue());
        }
        if (this.zzavp != null) {
            zzacbVar.zzb(8, this.zzavp);
        }
        if (this.zzavq != null) {
            zzacbVar.zzb(9, this.zzavq);
        }
        if (this.zzavr != null) {
            zzacbVar.zzb(10, this.zzavr);
        }
        if (this.zzahd != null) {
            zzacbVar.zzb(11, this.zzahd);
        }
        if (this.zzavs != null) {
            zzacbVar.zze(12, this.zzavs.intValue());
        }
        if (this.zzafh != null) {
            zzacbVar.zzb(13, this.zzafh);
        }
        if (this.zzth != null) {
            zzacbVar.zzb(14, this.zzth);
        }
        if (this.zztg != null) {
            zzacbVar.zzb(16, this.zztg);
        }
        if (this.zzavt != null) {
            zzacbVar.zzb(17, this.zzavt.longValue());
        }
        if (this.zzavu != null) {
            zzacbVar.zzb(18, this.zzavu.longValue());
        }
        if (this.zzavv != null) {
            zzacbVar.zzb(19, this.zzavv);
        }
        if (this.zzavw != null) {
            zzacbVar.zza(20, this.zzavw.booleanValue());
        }
        if (this.zzaez != null) {
            zzacbVar.zzb(21, this.zzaez);
        }
        if (this.zzavx != null) {
            zzacbVar.zzb(22, this.zzavx.longValue());
        }
        if (this.zzavy != null) {
            zzacbVar.zze(23, this.zzavy.intValue());
        }
        if (this.zzafy != null) {
            zzacbVar.zzb(24, this.zzafy);
        }
        if (this.zzafa != null) {
            zzacbVar.zzb(25, this.zzafa);
        }
        if (this.zzavn != null) {
            zzacbVar.zzb(26, this.zzavn.longValue());
        }
        if (this.zzavz != null) {
            zzacbVar.zza(28, this.zzavz.booleanValue());
        }
        if (this.zzawa != null && this.zzawa.length > 0) {
            for (int i3 = 0; i3 < this.zzawa.length; i3++) {
                zzkp zzkpVar = this.zzawa[i3];
                if (zzkpVar != null) {
                    zzacbVar.zza(29, zzkpVar);
                }
            }
        }
        if (this.zzafc != null) {
            zzacbVar.zzb(30, this.zzafc);
        }
        if (this.zzawb != null) {
            zzacbVar.zze(31, this.zzawb.intValue());
        }
        if (this.zzawc != null) {
            zzacbVar.zze(32, this.zzawc.intValue());
        }
        if (this.zzawd != null) {
            zzacbVar.zze(33, this.zzawd.intValue());
        }
        if (this.zzawe != null) {
            zzacbVar.zzb(34, this.zzawe);
        }
        if (this.zzawf != null) {
            zzacbVar.zzb(35, this.zzawf.longValue());
        }
        if (this.zzawg != null) {
            zzacbVar.zzb(36, this.zzawg.longValue());
        }
        if (this.zzawh != null) {
            zzacbVar.zzb(37, this.zzawh);
        }
        if (this.zzawi != null) {
            zzacbVar.zzb(38, this.zzawi);
        }
        if (this.zzawj != null) {
            zzacbVar.zze(39, this.zzawj.intValue());
        }
        if (this.zzawk != null) {
            zzacbVar.zzb(41, this.zzawk);
        }
        super.zza(zzacbVar);
    }

    @Override // com.google.android.gms.internal.measurement.zzacj
    public final /* synthetic */ zzacj zzb(zzaca zzacaVar) throws zzaci {
        while (true) {
            int iZzvl = zzacaVar.zzvl();
            switch (iZzvl) {
                case 0:
                    return this;
                case 8:
                    this.zzavh = Integer.valueOf(zzacaVar.zzvn());
                    break;
                case 18:
                    int iZzb = zzacm.zzb(zzacaVar, 18);
                    int length = this.zzavi == null ? 0 : this.zzavi.length;
                    zzkr[] zzkrVarArr = new zzkr[iZzb + length];
                    if (length != 0) {
                        System.arraycopy(this.zzavi, 0, zzkrVarArr, 0, length);
                    }
                    while (length < zzkrVarArr.length - 1) {
                        zzkrVarArr[length] = new zzkr();
                        zzacaVar.zza(zzkrVarArr[length]);
                        zzacaVar.zzvl();
                        length++;
                    }
                    zzkrVarArr[length] = new zzkr();
                    zzacaVar.zza(zzkrVarArr[length]);
                    this.zzavi = zzkrVarArr;
                    break;
                case 26:
                    int iZzb2 = zzacm.zzb(zzacaVar, 26);
                    int length2 = this.zzavj == null ? 0 : this.zzavj.length;
                    zzkx[] zzkxVarArr = new zzkx[iZzb2 + length2];
                    if (length2 != 0) {
                        System.arraycopy(this.zzavj, 0, zzkxVarArr, 0, length2);
                    }
                    while (length2 < zzkxVarArr.length - 1) {
                        zzkxVarArr[length2] = new zzkx();
                        zzacaVar.zza(zzkxVarArr[length2]);
                        zzacaVar.zzvl();
                        length2++;
                    }
                    zzkxVarArr[length2] = new zzkx();
                    zzacaVar.zza(zzkxVarArr[length2]);
                    this.zzavj = zzkxVarArr;
                    break;
                case 32:
                    this.zzavk = Long.valueOf(zzacaVar.zzvo());
                    break;
                case 40:
                    this.zzavl = Long.valueOf(zzacaVar.zzvo());
                    break;
                case 48:
                    this.zzavm = Long.valueOf(zzacaVar.zzvo());
                    break;
                case 56:
                    this.zzavo = Long.valueOf(zzacaVar.zzvo());
                    break;
                case 66:
                    this.zzavp = zzacaVar.readString();
                    break;
                case 74:
                    this.zzavq = zzacaVar.readString();
                    break;
                case 82:
                    this.zzavr = zzacaVar.readString();
                    break;
                case 90:
                    this.zzahd = zzacaVar.readString();
                    break;
                case 96:
                    this.zzavs = Integer.valueOf(zzacaVar.zzvn());
                    break;
                case 106:
                    this.zzafh = zzacaVar.readString();
                    break;
                case 114:
                    this.zzth = zzacaVar.readString();
                    break;
                case 130:
                    this.zztg = zzacaVar.readString();
                    break;
                case 136:
                    this.zzavt = Long.valueOf(zzacaVar.zzvo());
                    break;
                case 144:
                    this.zzavu = Long.valueOf(zzacaVar.zzvo());
                    break;
                case 154:
                    this.zzavv = zzacaVar.readString();
                    break;
                case 160:
                    this.zzavw = Boolean.valueOf(zzacaVar.zzvm());
                    break;
                case 170:
                    this.zzaez = zzacaVar.readString();
                    break;
                case 176:
                    this.zzavx = Long.valueOf(zzacaVar.zzvo());
                    break;
                case 184:
                    this.zzavy = Integer.valueOf(zzacaVar.zzvn());
                    break;
                case 194:
                    this.zzafy = zzacaVar.readString();
                    break;
                case 202:
                    this.zzafa = zzacaVar.readString();
                    break;
                case 208:
                    this.zzavn = Long.valueOf(zzacaVar.zzvo());
                    break;
                case 224:
                    this.zzavz = Boolean.valueOf(zzacaVar.zzvm());
                    break;
                case 234:
                    int iZzb3 = zzacm.zzb(zzacaVar, 234);
                    int length3 = this.zzawa == null ? 0 : this.zzawa.length;
                    zzkp[] zzkpVarArr = new zzkp[iZzb3 + length3];
                    if (length3 != 0) {
                        System.arraycopy(this.zzawa, 0, zzkpVarArr, 0, length3);
                    }
                    while (length3 < zzkpVarArr.length - 1) {
                        zzkpVarArr[length3] = new zzkp();
                        zzacaVar.zza(zzkpVarArr[length3]);
                        zzacaVar.zzvl();
                        length3++;
                    }
                    zzkpVarArr[length3] = new zzkp();
                    zzacaVar.zza(zzkpVarArr[length3]);
                    this.zzawa = zzkpVarArr;
                    break;
                case 242:
                    this.zzafc = zzacaVar.readString();
                    break;
                case 248:
                    this.zzawb = Integer.valueOf(zzacaVar.zzvn());
                    break;
                case 256:
                    this.zzawc = Integer.valueOf(zzacaVar.zzvn());
                    break;
                case 264:
                    this.zzawd = Integer.valueOf(zzacaVar.zzvn());
                    break;
                case 274:
                    this.zzawe = zzacaVar.readString();
                    break;
                case 280:
                    this.zzawf = Long.valueOf(zzacaVar.zzvo());
                    break;
                case 288:
                    this.zzawg = Long.valueOf(zzacaVar.zzvo());
                    break;
                case 298:
                    this.zzawh = zzacaVar.readString();
                    break;
                case 306:
                    this.zzawi = zzacaVar.readString();
                    break;
                case 312:
                    this.zzawj = Integer.valueOf(zzacaVar.zzvn());
                    break;
                case 330:
                    this.zzawk = zzacaVar.readString();
                    break;
                default:
                    if (!super.zza(zzacaVar, iZzvl)) {
                        return this;
                    }
                    break;
                    break;
            }
        }
    }
}
