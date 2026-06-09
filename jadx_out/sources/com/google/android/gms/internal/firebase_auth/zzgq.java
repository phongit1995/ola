package com.google.android.gms.internal.firebase_auth;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
final class zzgq implements Cloneable {
    private Object value;
    private zzgo<?, ?> zzxx;
    private List<zzgv> zzxy = new ArrayList();

    zzgq() {
    }

    private final byte[] toByteArray() throws zzgm {
        byte[] bArr = new byte[zzb()];
        zza(zzgl.zzf(bArr));
        return bArr;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: zzgo, reason: merged with bridge method [inline-methods] */
    public final zzgq clone() {
        Object objClone;
        zzgq zzgqVar = new zzgq();
        try {
            zzgqVar.zzxx = this.zzxx;
            if (this.zzxy == null) {
                zzgqVar.zzxy = null;
            } else {
                zzgqVar.zzxy.addAll(this.zzxy);
            }
            if (this.value != null) {
                if (this.value instanceof zzgt) {
                    objClone = (zzgt) ((zzgt) this.value).clone();
                } else if (this.value instanceof byte[]) {
                    objClone = ((byte[]) this.value).clone();
                } else {
                    int i = 0;
                    if (this.value instanceof byte[][]) {
                        byte[][] bArr = (byte[][]) this.value;
                        byte[][] bArr2 = new byte[bArr.length][];
                        zzgqVar.value = bArr2;
                        while (i < bArr.length) {
                            bArr2[i] = (byte[]) bArr[i].clone();
                            i++;
                        }
                    } else if (this.value instanceof boolean[]) {
                        objClone = ((boolean[]) this.value).clone();
                    } else if (this.value instanceof int[]) {
                        objClone = ((int[]) this.value).clone();
                    } else if (this.value instanceof long[]) {
                        objClone = ((long[]) this.value).clone();
                    } else if (this.value instanceof float[]) {
                        objClone = ((float[]) this.value).clone();
                    } else if (this.value instanceof double[]) {
                        objClone = ((double[]) this.value).clone();
                    } else if (this.value instanceof zzgt[]) {
                        zzgt[] zzgtVarArr = (zzgt[]) this.value;
                        zzgt[] zzgtVarArr2 = new zzgt[zzgtVarArr.length];
                        zzgqVar.value = zzgtVarArr2;
                        while (i < zzgtVarArr.length) {
                            zzgtVarArr2[i] = (zzgt) zzgtVarArr[i].clone();
                            i++;
                        }
                    }
                }
                zzgqVar.value = objClone;
                return zzgqVar;
            }
            return zzgqVar;
        } catch (CloneNotSupportedException e) {
            throw new AssertionError(e);
        }
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzgq)) {
            return false;
        }
        zzgq zzgqVar = (zzgq) obj;
        if (this.value != null && zzgqVar.value != null) {
            if (this.zzxx != zzgqVar.zzxx) {
                return false;
            }
            return !this.zzxx.zzxs.isArray() ? this.value.equals(zzgqVar.value) : this.value instanceof byte[] ? Arrays.equals((byte[]) this.value, (byte[]) zzgqVar.value) : this.value instanceof int[] ? Arrays.equals((int[]) this.value, (int[]) zzgqVar.value) : this.value instanceof long[] ? Arrays.equals((long[]) this.value, (long[]) zzgqVar.value) : this.value instanceof float[] ? Arrays.equals((float[]) this.value, (float[]) zzgqVar.value) : this.value instanceof double[] ? Arrays.equals((double[]) this.value, (double[]) zzgqVar.value) : this.value instanceof boolean[] ? Arrays.equals((boolean[]) this.value, (boolean[]) zzgqVar.value) : Arrays.deepEquals((Object[]) this.value, (Object[]) zzgqVar.value);
        }
        if (this.zzxy != null && zzgqVar.zzxy != null) {
            return this.zzxy.equals(zzgqVar.zzxy);
        }
        try {
            return Arrays.equals(toByteArray(), zzgqVar.toByteArray());
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    public final int hashCode() {
        try {
            return Arrays.hashCode(toByteArray()) + 527;
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    final void zza(zzgl zzglVar) throws zzgm {
        if (this.value != null) {
            throw new NoSuchMethodError();
        }
        for (zzgv zzgvVar : this.zzxy) {
            zzglVar.zzba(zzgvVar.tag);
            zzglVar.zzg(zzgvVar.zzmp);
        }
    }

    final void zza(zzgv zzgvVar) throws zzgs {
        if (this.zzxy != null) {
            this.zzxy.add(zzgvVar);
            return;
        }
        if (!(this.value instanceof zzgt)) {
            if (this.value instanceof zzgt[]) {
                Collections.singletonList(zzgvVar);
                throw new NoSuchMethodError();
            }
            Collections.singletonList(zzgvVar);
            throw new NoSuchMethodError();
        }
        byte[] bArr = zzgvVar.zzmp;
        zzgk zzgkVarZzi = zzgk.zzi(bArr, 0, bArr.length);
        int iZzcu = zzgkVarZzi.zzcu();
        if (iZzcu != bArr.length - zzgl.zzab(iZzcu)) {
            throw zzgs.zzgp();
        }
        zzgt zzgtVarZza = ((zzgt) this.value).zza(zzgkVarZzi);
        this.zzxx = this.zzxx;
        this.value = zzgtVarZza;
        this.zzxy = null;
    }

    final int zzb() {
        if (this.value != null) {
            throw new NoSuchMethodError();
        }
        int iZzai = 0;
        for (zzgv zzgvVar : this.zzxy) {
            iZzai += zzgl.zzai(zzgvVar.tag) + 0 + zzgvVar.zzmp.length;
        }
        return iZzai;
    }
}
