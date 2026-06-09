package com.google.android.gms.internal.measurement;

import java.io.IOException;

/* JADX INFO: loaded from: classes2.dex */
public abstract class zzacj {
    protected volatile int zzbzo = -1;

    public static final <T extends zzacj> T zza(T t, byte[] bArr) {
        return (T) zzb(t, bArr, 0, bArr.length);
    }

    public static final void zza(zzacj zzacjVar, byte[] bArr, int i, int i2) {
        try {
            zzacb zzacbVarZzb = zzacb.zzb(bArr, 0, i2);
            zzacjVar.zza(zzacbVarZzb);
            zzacbVarZzb.zzvt();
        } catch (IOException e) {
            throw new RuntimeException("Serializing to a byte array threw an IOException (should never happen).", e);
        }
    }

    private static final <T extends zzacj> T zzb(T t, byte[] bArr, int i, int i2) throws zzaci {
        try {
            zzaca zzacaVarZza = zzaca.zza(bArr, 0, i2);
            t.zzb(zzacaVarZza);
            zzacaVarZza.zzaj(0);
            return t;
        } catch (zzaci e) {
            throw e;
        } catch (IOException e2) {
            throw new RuntimeException("Reading from a byte array threw an IOException (should never happen).", e2);
        }
    }

    public String toString() {
        return zzack.zzc(this);
    }

    protected int zza() {
        return 0;
    }

    public void zza(zzacb zzacbVar) {
    }

    public abstract zzacj zzb(zzaca zzacaVar);

    @Override // 
    /* JADX INFO: renamed from: zzvu, reason: merged with bridge method [inline-methods] */
    public zzacj clone() {
        return (zzacj) super.clone();
    }

    public final int zzwa() {
        if (this.zzbzo < 0) {
            zzwb();
        }
        return this.zzbzo;
    }

    public final int zzwb() {
        int iZza = zza();
        this.zzbzo = iZza;
        return iZza;
    }
}
