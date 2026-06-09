package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public class zzdo {
    private static final zzco zzmc = zzco.zzdk();
    private zzbu zzsn;
    private volatile zzeh zzso;
    private volatile zzbu zzsp;

    private final zzeh zzh(zzeh zzehVar) {
        if (this.zzso == null) {
            synchronized (this) {
                if (this.zzso == null) {
                    try {
                        this.zzso = zzehVar;
                        this.zzsp = zzbu.zzmi;
                    } catch (zzdh unused) {
                        this.zzso = zzehVar;
                        this.zzsp = zzbu.zzmi;
                    }
                }
            }
        }
        return this.zzso;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof zzdo)) {
            return false;
        }
        zzdo zzdoVar = (zzdo) obj;
        zzeh zzehVar = this.zzso;
        zzeh zzehVar2 = zzdoVar.zzso;
        return (zzehVar == null && zzehVar2 == null) ? zzbo().equals(zzdoVar.zzbo()) : (zzehVar == null || zzehVar2 == null) ? zzehVar != null ? zzehVar.equals(zzdoVar.zzh(zzehVar.zzeb())) : zzh(zzehVar2.zzeb()).equals(zzehVar2) : zzehVar.equals(zzehVar2);
    }

    public int hashCode() {
        return 1;
    }

    public final zzbu zzbo() {
        if (this.zzsp != null) {
            return this.zzsp;
        }
        synchronized (this) {
            if (this.zzsp != null) {
                return this.zzsp;
            }
            this.zzsp = this.zzso == null ? zzbu.zzmi : this.zzso.zzbo();
            return this.zzsp;
        }
    }

    public final int zzdq() {
        if (this.zzsp != null) {
            return this.zzsp.size();
        }
        if (this.zzso != null) {
            return this.zzso.zzdq();
        }
        return 0;
    }

    public final zzeh zzi(zzeh zzehVar) {
        zzeh zzehVar2 = this.zzso;
        this.zzsn = null;
        this.zzsp = null;
        this.zzso = zzehVar;
        return zzehVar2;
    }
}
