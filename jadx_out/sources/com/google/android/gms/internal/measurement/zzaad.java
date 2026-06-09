package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public class zzaad {
    private static final zzzn zzbvd = zzzn.zztt();
    private zzzb zzbve;
    private volatile zzaaq zzbvf;
    private volatile zzzb zzbvg;

    private final zzaaq zzb(zzaaq zzaaqVar) {
        if (this.zzbvf == null) {
            synchronized (this) {
                if (this.zzbvf == null) {
                    try {
                        this.zzbvf = zzaaqVar;
                        this.zzbvg = zzzb.zzbte;
                    } catch (zzzy unused) {
                        this.zzbvf = zzaaqVar;
                        this.zzbvg = zzzb.zzbte;
                    }
                }
            }
        }
        return this.zzbvf;
    }

    private final zzzb zzue() {
        if (this.zzbvg != null) {
            return this.zzbvg;
        }
        synchronized (this) {
            if (this.zzbvg != null) {
                return this.zzbvg;
            }
            this.zzbvg = this.zzbvf == null ? zzzb.zzbte : this.zzbvf.zzue();
            return this.zzbvg;
        }
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof zzaad)) {
            return false;
        }
        zzaad zzaadVar = (zzaad) obj;
        zzaaq zzaaqVar = this.zzbvf;
        zzaaq zzaaqVar2 = zzaadVar.zzbvf;
        return (zzaaqVar == null && zzaaqVar2 == null) ? zzue().equals(zzaadVar.zzue()) : (zzaaqVar == null || zzaaqVar2 == null) ? zzaaqVar != null ? zzaaqVar.equals(zzaadVar.zzb(zzaaqVar.zzuo())) : zzb(zzaaqVar2.zzuo()).equals(zzaaqVar2) : zzaaqVar.equals(zzaaqVar2);
    }

    public int hashCode() {
        return 1;
    }

    public final zzaaq zzc(zzaaq zzaaqVar) {
        zzaaq zzaaqVar2 = this.zzbvf;
        this.zzbve = null;
        this.zzbvg = null;
        this.zzbvf = zzaaqVar;
        return zzaaqVar2;
    }
}
