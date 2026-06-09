package com.google.android.gms.internal.ads;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
final class zzbff implements Cloneable {
    private Object value;
    private zzbfd<?, ?> zzebq;
    private List<zzbfk> zzebr = new ArrayList();

    zzbff() {
    }

    private final byte[] toByteArray() throws zzbfb {
        byte[] bArr = new byte[zzr()];
        zza(zzbfa.zzu(bArr));
        return bArr;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: zzagp, reason: merged with bridge method [inline-methods] */
    public final zzbff clone() {
        Object objClone;
        zzbff zzbffVar = new zzbff();
        try {
            zzbffVar.zzebq = this.zzebq;
            if (this.zzebr == null) {
                zzbffVar.zzebr = null;
            } else {
                zzbffVar.zzebr.addAll(this.zzebr);
            }
            if (this.value != null) {
                if (this.value instanceof zzbfi) {
                    objClone = (zzbfi) ((zzbfi) this.value).clone();
                } else if (this.value instanceof byte[]) {
                    objClone = ((byte[]) this.value).clone();
                } else {
                    int i = 0;
                    if (this.value instanceof byte[][]) {
                        byte[][] bArr = (byte[][]) this.value;
                        byte[][] bArr2 = new byte[bArr.length][];
                        zzbffVar.value = bArr2;
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
                    } else if (this.value instanceof zzbfi[]) {
                        zzbfi[] zzbfiVarArr = (zzbfi[]) this.value;
                        zzbfi[] zzbfiVarArr2 = new zzbfi[zzbfiVarArr.length];
                        zzbffVar.value = zzbfiVarArr2;
                        while (i < zzbfiVarArr.length) {
                            zzbfiVarArr2[i] = (zzbfi) zzbfiVarArr[i].clone();
                            i++;
                        }
                    }
                }
                zzbffVar.value = objClone;
                return zzbffVar;
            }
            return zzbffVar;
        } catch (CloneNotSupportedException e) {
            throw new AssertionError(e);
        }
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzbff)) {
            return false;
        }
        zzbff zzbffVar = (zzbff) obj;
        if (this.value != null && zzbffVar.value != null) {
            if (this.zzebq != zzbffVar.zzebq) {
                return false;
            }
            return !this.zzebq.zzebl.isArray() ? this.value.equals(zzbffVar.value) : this.value instanceof byte[] ? Arrays.equals((byte[]) this.value, (byte[]) zzbffVar.value) : this.value instanceof int[] ? Arrays.equals((int[]) this.value, (int[]) zzbffVar.value) : this.value instanceof long[] ? Arrays.equals((long[]) this.value, (long[]) zzbffVar.value) : this.value instanceof float[] ? Arrays.equals((float[]) this.value, (float[]) zzbffVar.value) : this.value instanceof double[] ? Arrays.equals((double[]) this.value, (double[]) zzbffVar.value) : this.value instanceof boolean[] ? Arrays.equals((boolean[]) this.value, (boolean[]) zzbffVar.value) : Arrays.deepEquals((Object[]) this.value, (Object[]) zzbffVar.value);
        }
        if (this.zzebr != null && zzbffVar.zzebr != null) {
            return this.zzebr.equals(zzbffVar.zzebr);
        }
        try {
            return Arrays.equals(toByteArray(), zzbffVar.toByteArray());
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

    final void zza(zzbfa zzbfaVar) throws zzbfb {
        if (this.value != null) {
            throw new NoSuchMethodError();
        }
        for (zzbfk zzbfkVar : this.zzebr) {
            zzbfaVar.zzde(zzbfkVar.tag);
            zzbfaVar.zzw(zzbfkVar.zzdpw);
        }
    }

    final void zza(zzbfk zzbfkVar) throws zzbfh {
        if (this.zzebr != null) {
            this.zzebr.add(zzbfkVar);
            return;
        }
        if (!(this.value instanceof zzbfi)) {
            if (this.value instanceof zzbfi[]) {
                Collections.singletonList(zzbfkVar);
                throw new NoSuchMethodError();
            }
            Collections.singletonList(zzbfkVar);
            throw new NoSuchMethodError();
        }
        byte[] bArr = zzbfkVar.zzdpw;
        zzbez zzbezVarZzi = zzbez.zzi(bArr, 0, bArr.length);
        int iZzacc = zzbezVarZzi.zzacc();
        if (iZzacc != bArr.length - zzbfa.zzce(iZzacc)) {
            throw zzbfh.zzagq();
        }
        zzbfi zzbfiVarZza = ((zzbfi) this.value).zza(zzbezVarZzi);
        this.zzebq = this.zzebq;
        this.value = zzbfiVarZza;
        this.zzebr = null;
    }

    final int zzr() {
        if (this.value != null) {
            throw new NoSuchMethodError();
        }
        int iZzcl = 0;
        for (zzbfk zzbfkVar : this.zzebr) {
            iZzcl += zzbfa.zzcl(zzbfkVar.tag) + 0 + zzbfkVar.zzdpw.length;
        }
        return iZzcl;
    }
}
