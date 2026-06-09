package com.google.android.gms.internal.firebase_auth;

import java.io.IOException;

/* JADX INFO: loaded from: classes2.dex */
public abstract class zzgt {
    protected volatile int zzya = -1;

    public static final void zza(zzgt zzgtVar, byte[] bArr, int i, int i2) {
        try {
            zzgl zzglVarZzj = zzgl.zzj(bArr, 0, i2);
            zzgtVar.zza(zzglVarZzj);
            zzglVarZzj.zzgm();
        } catch (IOException e) {
            throw new RuntimeException("Serializing to a byte array threw an IOException (should never happen).", e);
        }
    }

    public static final <T extends zzgt> T zzb(T t, byte[] bArr, int i, int i2) throws zzgs {
        try {
            zzgk zzgkVarZzi = zzgk.zzi(bArr, 0, i2);
            t.zza(zzgkVarZzi);
            zzgkVarZzi.zzm(0);
            return t;
        } catch (zzgs e) {
            throw e;
        } catch (IOException e2) {
            throw new RuntimeException("Reading from a byte array threw an IOException (should never happen).", e2);
        }
    }

    public String toString() {
        return zzgu.zzc(this);
    }

    public abstract zzgt zza(zzgk zzgkVar);

    public void zza(zzgl zzglVar) {
    }

    protected int zzb() {
        return 0;
    }

    public final int zzdq() {
        int iZzb = zzb();
        this.zzya = iZzb;
        return iZzb;
    }

    @Override // 
    /* JADX INFO: renamed from: zzgn, reason: merged with bridge method [inline-methods] */
    public zzgt clone() {
        return (zzgt) super.clone();
    }
}
