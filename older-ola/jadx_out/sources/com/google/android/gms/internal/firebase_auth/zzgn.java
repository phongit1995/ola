package com.google.android.gms.internal.firebase_auth;

import com.google.android.gms.internal.firebase_auth.zzgn;

/* JADX INFO: loaded from: classes2.dex */
public abstract class zzgn<M extends zzgn<M>> extends zzgt {
    protected zzgp zzxr;

    @Override // com.google.android.gms.internal.firebase_auth.zzgt
    public /* synthetic */ Object clone() {
        zzgn zzgnVar = (zzgn) super.clone();
        zzgr.zza(this, zzgnVar);
        return zzgnVar;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgt
    public void zza(zzgl zzglVar) throws zzgm {
        if (this.zzxr == null) {
            return;
        }
        for (int i = 0; i < this.zzxr.size(); i++) {
            this.zzxr.zzbc(i).zza(zzglVar);
        }
    }

    protected final boolean zza(zzgk zzgkVar, int i) throws zzgs {
        int position = zzgkVar.getPosition();
        if (!zzgkVar.zzn(i)) {
            return false;
        }
        int i2 = i >>> 3;
        zzgv zzgvVar = new zzgv(i, zzgkVar.zzr(position, zzgkVar.getPosition() - position));
        zzgq zzgqVarZzbb = null;
        if (this.zzxr == null) {
            this.zzxr = new zzgp();
        } else {
            zzgqVarZzbb = this.zzxr.zzbb(i2);
        }
        if (zzgqVarZzbb == null) {
            zzgqVarZzbb = new zzgq();
            this.zzxr.zza(i2, zzgqVarZzbb);
        }
        zzgqVarZzbb.zza(zzgvVar);
        return true;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgt
    protected int zzb() {
        if (this.zzxr == null) {
            return 0;
        }
        int iZzb = 0;
        for (int i = 0; i < this.zzxr.size(); i++) {
            iZzb += this.zzxr.zzbc(i).zzb();
        }
        return iZzb;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgt
    /* JADX INFO: renamed from: zzgn */
    public final /* synthetic */ zzgt clone() {
        return (zzgn) clone();
    }
}
