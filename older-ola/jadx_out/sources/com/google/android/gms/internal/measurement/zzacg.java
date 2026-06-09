package com.google.android.gms.internal.measurement;

import java.io.IOException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
final class zzacg implements Cloneable {
    private Object value;
    private zzace<?, ?> zzbzl;
    private List<zzacl> zzbzm = new ArrayList();

    zzacg() {
    }

    private final byte[] toByteArray() throws zzacc {
        byte[] bArr = new byte[zza()];
        zza(zzacb.zzj(bArr));
        return bArr;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: zzvv, reason: merged with bridge method [inline-methods] */
    public final zzacg clone() {
        Object objClone;
        zzacg zzacgVar = new zzacg();
        try {
            zzacgVar.zzbzl = this.zzbzl;
            if (this.zzbzm == null) {
                zzacgVar.zzbzm = null;
            } else {
                zzacgVar.zzbzm.addAll(this.zzbzm);
            }
            if (this.value != null) {
                if (this.value instanceof zzacj) {
                    objClone = (zzacj) ((zzacj) this.value).clone();
                } else if (this.value instanceof byte[]) {
                    objClone = ((byte[]) this.value).clone();
                } else {
                    int i = 0;
                    if (this.value instanceof byte[][]) {
                        byte[][] bArr = (byte[][]) this.value;
                        byte[][] bArr2 = new byte[bArr.length][];
                        zzacgVar.value = bArr2;
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
                    } else if (this.value instanceof zzacj[]) {
                        zzacj[] zzacjVarArr = (zzacj[]) this.value;
                        zzacj[] zzacjVarArr2 = new zzacj[zzacjVarArr.length];
                        zzacgVar.value = zzacjVarArr2;
                        while (i < zzacjVarArr.length) {
                            zzacjVarArr2[i] = (zzacj) zzacjVarArr[i].clone();
                            i++;
                        }
                    }
                }
                zzacgVar.value = objClone;
                return zzacgVar;
            }
            return zzacgVar;
        } catch (CloneNotSupportedException e) {
            throw new AssertionError(e);
        }
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzacg)) {
            return false;
        }
        zzacg zzacgVar = (zzacg) obj;
        if (this.value != null && zzacgVar.value != null) {
            if (this.zzbzl != zzacgVar.zzbzl) {
                return false;
            }
            return !this.zzbzl.zzbze.isArray() ? this.value.equals(zzacgVar.value) : this.value instanceof byte[] ? Arrays.equals((byte[]) this.value, (byte[]) zzacgVar.value) : this.value instanceof int[] ? Arrays.equals((int[]) this.value, (int[]) zzacgVar.value) : this.value instanceof long[] ? Arrays.equals((long[]) this.value, (long[]) zzacgVar.value) : this.value instanceof float[] ? Arrays.equals((float[]) this.value, (float[]) zzacgVar.value) : this.value instanceof double[] ? Arrays.equals((double[]) this.value, (double[]) zzacgVar.value) : this.value instanceof boolean[] ? Arrays.equals((boolean[]) this.value, (boolean[]) zzacgVar.value) : Arrays.deepEquals((Object[]) this.value, (Object[]) zzacgVar.value);
        }
        if (this.zzbzm != null && zzacgVar.zzbzm != null) {
            return this.zzbzm.equals(zzacgVar.zzbzm);
        }
        try {
            return Arrays.equals(toByteArray(), zzacgVar.toByteArray());
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

    final int zza() {
        int iZzas;
        if (this.value != null) {
            zzace<?, ?> zzaceVar = this.zzbzl;
            Object obj = this.value;
            if (!zzaceVar.zzbzf) {
                return zzaceVar.zzv(obj);
            }
            int length = Array.getLength(obj);
            iZzas = 0;
            for (int i = 0; i < length; i++) {
                if (Array.get(obj, i) != null) {
                    iZzas += zzaceVar.zzv(Array.get(obj, i));
                }
            }
        } else {
            iZzas = 0;
            for (zzacl zzaclVar : this.zzbzm) {
                iZzas += zzacb.zzas(zzaclVar.tag) + 0 + zzaclVar.zzbtj.length;
            }
        }
        return iZzas;
    }

    final void zza(zzacb zzacbVar) throws zzacc {
        if (this.value == null) {
            for (zzacl zzaclVar : this.zzbzm) {
                zzacbVar.zzar(zzaclVar.tag);
                zzacbVar.zzk(zzaclVar.zzbtj);
            }
            return;
        }
        zzace<?, ?> zzaceVar = this.zzbzl;
        Object obj = this.value;
        if (!zzaceVar.zzbzf) {
            zzaceVar.zza(obj, zzacbVar);
            return;
        }
        int length = Array.getLength(obj);
        for (int i = 0; i < length; i++) {
            Object obj2 = Array.get(obj, i);
            if (obj2 != null) {
                zzaceVar.zza(obj2, zzacbVar);
            }
        }
    }

    final void zza(zzacl zzaclVar) throws zzaci {
        Object objZzi;
        if (this.zzbzm != null) {
            this.zzbzm.add(zzaclVar);
            return;
        }
        if (this.value instanceof zzacj) {
            byte[] bArr = zzaclVar.zzbtj;
            zzaca zzacaVarZza = zzaca.zza(bArr, 0, bArr.length);
            int iZzvn = zzacaVarZza.zzvn();
            if (iZzvn != bArr.length - zzacb.zzao(iZzvn)) {
                throw zzaci.zzvw();
            }
            objZzi = ((zzacj) this.value).zzb(zzacaVarZza);
        } else if (this.value instanceof zzacj[]) {
            zzacj[] zzacjVarArr = (zzacj[]) this.zzbzl.zzi(Collections.singletonList(zzaclVar));
            zzacj[] zzacjVarArr2 = (zzacj[]) this.value;
            zzacj[] zzacjVarArr3 = (zzacj[]) Arrays.copyOf(zzacjVarArr2, zzacjVarArr2.length + zzacjVarArr.length);
            System.arraycopy(zzacjVarArr, 0, zzacjVarArr3, zzacjVarArr2.length, zzacjVarArr.length);
            objZzi = zzacjVarArr3;
        } else {
            objZzi = this.zzbzl.zzi(Collections.singletonList(zzaclVar));
        }
        this.zzbzl = this.zzbzl;
        this.value = objZzi;
        this.zzbzm = null;
    }

    /* JADX WARN: Multi-variable type inference failed */
    final <T> T zzb(zzace<?, T> zzaceVar) {
        if (this.value == null) {
            this.zzbzl = zzaceVar;
            this.value = zzaceVar.zzi(this.zzbzm);
            this.zzbzm = null;
        } else if (!this.zzbzl.equals(zzaceVar)) {
            throw new IllegalStateException("Tried to getExtension with a different Extension.");
        }
        return (T) this.value;
    }
}
