package com.google.android.gms.internal.ads;

import com.google.android.gms.common.util.CrashUtils;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import sun.misc.Unsafe;

/* JADX INFO: loaded from: classes.dex */
final class zzbcy<T> implements zzbdm<T> {
    private static final Unsafe zzdwf = zzbek.zzagh();
    private final int[] zzdwg;
    private final Object[] zzdwh;
    private final int zzdwi;
    private final int zzdwj;
    private final int zzdwk;
    private final zzbcu zzdwl;
    private final boolean zzdwm;
    private final boolean zzdwn;
    private final boolean zzdwo;
    private final boolean zzdwp;
    private final int[] zzdwq;
    private final int[] zzdwr;
    private final int[] zzdws;
    private final zzbdc zzdwt;
    private final zzbce zzdwu;
    private final zzbee<?, ?> zzdwv;
    private final zzbbd<?> zzdww;
    private final zzbcp zzdwx;

    private zzbcy(int[] iArr, Object[] objArr, int i, int i2, int i3, zzbcu zzbcuVar, boolean z, boolean z2, int[] iArr2, int[] iArr3, int[] iArr4, zzbdc zzbdcVar, zzbce zzbceVar, zzbee<?, ?> zzbeeVar, zzbbd<?> zzbbdVar, zzbcp zzbcpVar) {
        this.zzdwg = iArr;
        this.zzdwh = objArr;
        this.zzdwi = i;
        this.zzdwj = i2;
        this.zzdwk = i3;
        this.zzdwn = zzbcuVar instanceof zzbbo;
        this.zzdwo = z;
        this.zzdwm = zzbbdVar != null && zzbbdVar.zzh(zzbcuVar);
        this.zzdwp = false;
        this.zzdwq = iArr2;
        this.zzdwr = iArr3;
        this.zzdws = iArr4;
        this.zzdwt = zzbdcVar;
        this.zzdwu = zzbceVar;
        this.zzdwv = zzbeeVar;
        this.zzdww = zzbbdVar;
        this.zzdwl = zzbcuVar;
        this.zzdwx = zzbcpVar;
    }

    private static int zza(int i, byte[] bArr, int i2, int i3, Object obj, zzbae zzbaeVar) {
        return zzbad.zza(i, bArr, i2, i3, zzz(obj), zzbaeVar);
    }

    private static int zza(zzbdm<?> zzbdmVar, int i, byte[] bArr, int i2, int i3, zzbbt<?> zzbbtVar, zzbae zzbaeVar) throws zzbbu {
        int iZza = zza((zzbdm) zzbdmVar, bArr, i2, i3, zzbaeVar);
        while (true) {
            zzbbtVar.add(zzbaeVar.zzdpn);
            if (iZza >= i3) {
                break;
            }
            int iZza2 = zzbad.zza(bArr, iZza, zzbaeVar);
            if (i != zzbaeVar.zzdpl) {
                break;
            }
            iZza = zza((zzbdm) zzbdmVar, bArr, iZza2, i3, zzbaeVar);
        }
        return iZza;
    }

    /* JADX WARN: Multi-variable type inference failed */
    private static int zza(zzbdm zzbdmVar, byte[] bArr, int i, int i2, int i3, zzbae zzbaeVar) throws zzbbu {
        zzbcy zzbcyVar = (zzbcy) zzbdmVar;
        Object objNewInstance = zzbcyVar.newInstance();
        int iZza = zzbcyVar.zza(objNewInstance, bArr, i, i2, i3, zzbaeVar);
        zzbcyVar.zzo(objNewInstance);
        zzbaeVar.zzdpn = objNewInstance;
        return iZza;
    }

    /* JADX WARN: Multi-variable type inference failed */
    private static int zza(zzbdm zzbdmVar, byte[] bArr, int i, int i2, zzbae zzbaeVar) throws zzbbu {
        int iZza = i + 1;
        int i3 = bArr[i];
        if (i3 < 0) {
            iZza = zzbad.zza(i3, bArr, iZza, zzbaeVar);
            i3 = zzbaeVar.zzdpl;
        }
        int i4 = iZza;
        if (i3 < 0 || i3 > i2 - i4) {
            throw zzbbu.zzadl();
        }
        Object objNewInstance = zzbdmVar.newInstance();
        int i5 = i3 + i4;
        zzbdmVar.zza(objNewInstance, bArr, i4, i5, zzbaeVar);
        zzbdmVar.zzo(objNewInstance);
        zzbaeVar.zzdpn = objNewInstance;
        return i5;
    }

    private static <UT, UB> int zza(zzbee<UT, UB> zzbeeVar, T t) {
        return zzbeeVar.zzy(zzbeeVar.zzac(t));
    }

    private final int zza(T t, byte[] bArr, int i, int i2, int i3, int i4, int i5, int i6, int i7, long j, int i8, zzbae zzbaeVar) throws zzbbu {
        Object objValueOf;
        Object objValueOf2;
        int iZzb;
        long jZzl;
        int iZzbu;
        Object objValueOf3;
        int i9;
        Unsafe unsafe = zzdwf;
        long j2 = this.zzdwg[i8 + 2] & 1048575;
        switch (i7) {
            case 51:
                if (i5 != 1) {
                    return i;
                }
                objValueOf = Double.valueOf(zzbad.zzg(bArr, i));
                unsafe.putObject(t, j, objValueOf);
                iZzb = i + 8;
                unsafe.putInt(t, j2, i4);
                return iZzb;
            case 52:
                if (i5 != 5) {
                    return i;
                }
                objValueOf2 = Float.valueOf(zzbad.zzh(bArr, i));
                unsafe.putObject(t, j, objValueOf2);
                iZzb = i + 4;
                unsafe.putInt(t, j2, i4);
                return iZzb;
            case 53:
            case 54:
                if (i5 != 0) {
                    return i;
                }
                iZzb = zzbad.zzb(bArr, i, zzbaeVar);
                jZzl = zzbaeVar.zzdpm;
                objValueOf3 = Long.valueOf(jZzl);
                unsafe.putObject(t, j, objValueOf3);
                unsafe.putInt(t, j2, i4);
                return iZzb;
            case 55:
            case 62:
                if (i5 != 0) {
                    return i;
                }
                iZzb = zzbad.zza(bArr, i, zzbaeVar);
                iZzbu = zzbaeVar.zzdpl;
                objValueOf3 = Integer.valueOf(iZzbu);
                unsafe.putObject(t, j, objValueOf3);
                unsafe.putInt(t, j2, i4);
                return iZzb;
            case 56:
            case 65:
                if (i5 != 1) {
                    return i;
                }
                objValueOf = Long.valueOf(zzbad.zzf(bArr, i));
                unsafe.putObject(t, j, objValueOf);
                iZzb = i + 8;
                unsafe.putInt(t, j2, i4);
                return iZzb;
            case 57:
            case 64:
                if (i5 != 5) {
                    return i;
                }
                objValueOf2 = Integer.valueOf(zzbad.zze(bArr, i));
                unsafe.putObject(t, j, objValueOf2);
                iZzb = i + 4;
                unsafe.putInt(t, j2, i4);
                return iZzb;
            case 58:
                if (i5 != 0) {
                    return i;
                }
                iZzb = zzbad.zzb(bArr, i, zzbaeVar);
                objValueOf3 = Boolean.valueOf(zzbaeVar.zzdpm != 0);
                unsafe.putObject(t, j, objValueOf3);
                unsafe.putInt(t, j2, i4);
                return iZzb;
            case 59:
                if (i5 != 2) {
                    return i;
                }
                iZzb = zzbad.zza(bArr, i, zzbaeVar);
                i9 = zzbaeVar.zzdpl;
                if (i9 == 0) {
                    objValueOf3 = "";
                    unsafe.putObject(t, j, objValueOf3);
                    unsafe.putInt(t, j2, i4);
                    return iZzb;
                }
                if ((i6 & CrashUtils.ErrorDialogData.DYNAMITE_CRASH) != 0 && !zzbem.zzf(bArr, iZzb, iZzb + i9)) {
                    throw zzbbu.zzads();
                }
                unsafe.putObject(t, j, new String(bArr, iZzb, i9, zzbbq.UTF_8));
                iZzb += i9;
                unsafe.putInt(t, j2, i4);
                return iZzb;
            case 60:
                if (i5 != 2) {
                    return i;
                }
                iZzb = zza(zzcq(i8), bArr, i, i2, zzbaeVar);
                Object object = unsafe.getInt(t, j2) == i4 ? unsafe.getObject(t, j) : null;
                objValueOf3 = object == null ? zzbaeVar.zzdpn : zzbbq.zza(object, zzbaeVar.zzdpn);
                unsafe.putObject(t, j, objValueOf3);
                unsafe.putInt(t, j2, i4);
                return iZzb;
            case 61:
                if (i5 != 2) {
                    return i;
                }
                iZzb = zzbad.zza(bArr, i, zzbaeVar);
                i9 = zzbaeVar.zzdpl;
                if (i9 == 0) {
                    objValueOf3 = zzbah.zzdpq;
                    unsafe.putObject(t, j, objValueOf3);
                    unsafe.putInt(t, j2, i4);
                    return iZzb;
                }
                unsafe.putObject(t, j, zzbah.zzc(bArr, iZzb, i9));
                iZzb += i9;
                unsafe.putInt(t, j2, i4);
                return iZzb;
            case 63:
                if (i5 != 0) {
                    return i;
                }
                int iZza = zzbad.zza(bArr, i, zzbaeVar);
                int i10 = zzbaeVar.zzdpl;
                zzbbs<?> zzbbsVarZzcs = zzcs(i8);
                if (zzbbsVarZzcs != null && zzbbsVarZzcs.zzq(i10) == null) {
                    zzz(t).zzb(i3, Long.valueOf(i10));
                    return iZza;
                }
                unsafe.putObject(t, j, Integer.valueOf(i10));
                iZzb = iZza;
                unsafe.putInt(t, j2, i4);
                return iZzb;
            case 66:
                if (i5 != 0) {
                    return i;
                }
                iZzb = zzbad.zza(bArr, i, zzbaeVar);
                iZzbu = zzbaq.zzbu(zzbaeVar.zzdpl);
                objValueOf3 = Integer.valueOf(iZzbu);
                unsafe.putObject(t, j, objValueOf3);
                unsafe.putInt(t, j2, i4);
                return iZzb;
            case 67:
                if (i5 != 0) {
                    return i;
                }
                iZzb = zzbad.zzb(bArr, i, zzbaeVar);
                jZzl = zzbaq.zzl(zzbaeVar.zzdpm);
                objValueOf3 = Long.valueOf(jZzl);
                unsafe.putObject(t, j, objValueOf3);
                unsafe.putInt(t, j2, i4);
                return iZzb;
            case 68:
                if (i5 != 3) {
                    return i;
                }
                iZzb = zza(zzcq(i8), bArr, i, i2, (i3 & (-8)) | 4, zzbaeVar);
                Object object2 = unsafe.getInt(t, j2) == i4 ? unsafe.getObject(t, j) : null;
                objValueOf3 = object2 == null ? zzbaeVar.zzdpn : zzbbq.zza(object2, zzbaeVar.zzdpn);
                unsafe.putObject(t, j, objValueOf3);
                unsafe.putInt(t, j2, i4);
                return iZzb;
            default:
                return i;
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:123:0x0216, code lost:
    
        if (r31.zzdpm != 0) goto L124;
     */
    /* JADX WARN: Code restructure failed: missing block: B:124:0x0218, code lost:
    
        r3 = true;
     */
    /* JADX WARN: Code restructure failed: missing block: B:125:0x021a, code lost:
    
        r3 = false;
     */
    /* JADX WARN: Code restructure failed: missing block: B:126:0x021b, code lost:
    
        r12.addBoolean(r3);
     */
    /* JADX WARN: Code restructure failed: missing block: B:127:0x021e, code lost:
    
        if (r2 >= r21) goto L237;
     */
    /* JADX WARN: Code restructure failed: missing block: B:128:0x0220, code lost:
    
        r3 = com.google.android.gms.internal.ads.zzbad.zza(r19, r2, r31);
     */
    /* JADX WARN: Code restructure failed: missing block: B:129:0x0226, code lost:
    
        if (r22 != r31.zzdpl) goto L235;
     */
    /* JADX WARN: Code restructure failed: missing block: B:130:0x0228, code lost:
    
        r2 = com.google.android.gms.internal.ads.zzbad.zzb(r19, r3, r31);
     */
    /* JADX WARN: Code restructure failed: missing block: B:131:0x0230, code lost:
    
        if (r31.zzdpm == 0) goto L125;
     */
    /* JADX WARN: Code restructure failed: missing block: B:207:0x0134, code lost:
    
        r12.add(com.google.android.gms.internal.ads.zzbah.zzc(r19, r1, r2));
        r1 = r1 + r2;
     */
    /* JADX WARN: Code restructure failed: missing block: B:210:0x021b, code lost:
    
        r3 = false;
     */
    /* JADX WARN: Code restructure failed: missing block: B:281:?, code lost:
    
        return r1;
     */
    /* JADX WARN: Code restructure failed: missing block: B:282:?, code lost:
    
        return r1;
     */
    /* JADX WARN: Code restructure failed: missing block: B:62:0x0124, code lost:
    
        if (r2 == 0) goto L63;
     */
    /* JADX WARN: Code restructure failed: missing block: B:63:0x0126, code lost:
    
        r12.add(com.google.android.gms.internal.ads.zzbah.zzdpq);
     */
    /* JADX WARN: Code restructure failed: missing block: B:64:0x012c, code lost:
    
        r12.add(com.google.android.gms.internal.ads.zzbah.zzc(r19, r1, r2));
        r1 = r1 + r2;
     */
    /* JADX WARN: Code restructure failed: missing block: B:65:0x0134, code lost:
    
        if (r1 >= r21) goto L219;
     */
    /* JADX WARN: Code restructure failed: missing block: B:66:0x0136, code lost:
    
        r2 = com.google.android.gms.internal.ads.zzbad.zza(r19, r1, r31);
     */
    /* JADX WARN: Code restructure failed: missing block: B:67:0x013c, code lost:
    
        if (r22 != r31.zzdpl) goto L220;
     */
    /* JADX WARN: Code restructure failed: missing block: B:68:0x013e, code lost:
    
        r1 = com.google.android.gms.internal.ads.zzbad.zza(r19, r2, r31);
        r2 = r31.zzdpl;
     */
    /* JADX WARN: Code restructure failed: missing block: B:69:0x0144, code lost:
    
        if (r2 != 0) goto L64;
     */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:83:0x017d  */
    /* JADX WARN: Removed duplicated region for block: B:99:0x01be  */
    /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:102:0x01cc -> B:91:0x019e). Please report as a decompilation issue!!! */
    /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:131:0x0230 -> B:124:0x0218). Please report as a decompilation issue!!! */
    /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:69:0x0144 -> B:63:0x0126). Please report as a decompilation issue!!! */
    /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:86:0x018b -> B:79:0x016a). Please report as a decompilation issue!!! */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final int zza(T r18, byte[] r19, int r20, int r21, int r22, int r23, int r24, int r25, long r26, int r28, long r29, com.google.android.gms.internal.ads.zzbae r31) throws com.google.android.gms.internal.ads.zzbbu {
        /*
            Method dump skipped, instruction units count: 964
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbcy.zza(java.lang.Object, byte[], int, int, int, int, int, int, long, int, long, com.google.android.gms.internal.ads.zzbae):int");
    }

    private final <K, V> int zza(T t, byte[] bArr, int i, int i2, int i3, int i4, long j, zzbae zzbaeVar) throws zzbbu {
        Unsafe unsafe = zzdwf;
        Object objZzcr = zzcr(i3);
        Object object = unsafe.getObject(t, j);
        if (this.zzdwx.zzu(object)) {
            Object objZzw = this.zzdwx.zzw(objZzcr);
            this.zzdwx.zzb(objZzw, object);
            unsafe.putObject(t, j, objZzw);
            object = objZzw;
        }
        zzbcn<?, ?> zzbcnVarZzx = this.zzdwx.zzx(objZzcr);
        Map<?, ?> mapZzs = this.zzdwx.zzs(object);
        int iZza = zzbad.zza(bArr, i, zzbaeVar);
        int i5 = zzbaeVar.zzdpl;
        if (i5 < 0 || i5 > i2 - iZza) {
            throw zzbbu.zzadl();
        }
        int i6 = i5 + iZza;
        K k = zzbcnVarZzx.zzdvz;
        V v = zzbcnVarZzx.zzdwb;
        while (iZza < i6) {
            int iZza2 = iZza + 1;
            int i7 = bArr[iZza];
            if (i7 < 0) {
                iZza2 = zzbad.zza(i7, bArr, iZza2, zzbaeVar);
                i7 = zzbaeVar.zzdpl;
            }
            int i8 = iZza2;
            int i9 = i7 & 7;
            switch (i7 >>> 3) {
                case 1:
                    if (i9 != zzbcnVarZzx.zzdvy.zzagm()) {
                        iZza = zzbad.zza(i7, bArr, i8, i2, zzbaeVar);
                    } else {
                        iZza = zza(bArr, i8, i2, zzbcnVarZzx.zzdvy, (Class<?>) null, zzbaeVar);
                        k = (K) zzbaeVar.zzdpn;
                    }
                    break;
                case 2:
                    if (i9 != zzbcnVarZzx.zzdwa.zzagm()) {
                        iZza = zzbad.zza(i7, bArr, i8, i2, zzbaeVar);
                    } else {
                        iZza = zza(bArr, i8, i2, zzbcnVarZzx.zzdwa, zzbcnVarZzx.zzdwb.getClass(), zzbaeVar);
                        v = zzbaeVar.zzdpn;
                    }
                    break;
                default:
                    iZza = zzbad.zza(i7, bArr, i8, i2, zzbaeVar);
                    break;
            }
        }
        if (iZza != i6) {
            throw zzbbu.zzadr();
        }
        mapZzs.put(k, v);
        return i6;
    }

    /* JADX WARN: Code restructure failed: missing block: B:117:0x0308, code lost:
    
        if (r0 == r15) goto L122;
     */
    /* JADX WARN: Code restructure failed: missing block: B:121:0x0329, code lost:
    
        if (r0 == r15) goto L122;
     */
    /* JADX WARN: Code restructure failed: missing block: B:122:0x032b, code lost:
    
        r2 = r0;
     */
    /* JADX WARN: Code restructure failed: missing block: B:123:0x032d, code lost:
    
        r12 = r33;
        r13 = r35;
        r9 = r37;
        r15 = r14;
        r6 = r17;
        r7 = r24;
        r10 = r29;
        r1 = r30;
        r8 = -1;
        r11 = r36;
     */
    /* JADX WARN: Failed to find 'out' block for switch in B:19:0x006c. Please report as an issue. */
    /* JADX WARN: Removed duplicated region for block: B:130:0x0351 A[ADDED_TO_REGION] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final int zza(T r32, byte[] r33, int r34, int r35, int r36, com.google.android.gms.internal.ads.zzbae r37) throws com.google.android.gms.internal.ads.zzbbu {
        /*
            Method dump skipped, instruction units count: 1008
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbcy.zza(java.lang.Object, byte[], int, int, int, com.google.android.gms.internal.ads.zzbae):int");
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private static int zza(byte[] bArr, int i, int i2, zzbes zzbesVar, Class<?> cls, zzbae zzbaeVar) {
        int iZzb;
        Object objValueOf;
        Object objValueOf2;
        Object objValueOf3;
        int iZzbu;
        long jZzl;
        switch (zzbcz.zzdql[zzbesVar.ordinal()]) {
            case 1:
                iZzb = zzbad.zzb(bArr, i, zzbaeVar);
                objValueOf = Boolean.valueOf(zzbaeVar.zzdpm != 0);
                zzbaeVar.zzdpn = objValueOf;
                return iZzb;
            case 2:
                return zzbad.zze(bArr, i, zzbaeVar);
            case 3:
                objValueOf2 = Double.valueOf(zzbad.zzg(bArr, i));
                zzbaeVar.zzdpn = objValueOf2;
                return i + 8;
            case 4:
            case 5:
                objValueOf3 = Integer.valueOf(zzbad.zze(bArr, i));
                zzbaeVar.zzdpn = objValueOf3;
                return i + 4;
            case 6:
            case 7:
                objValueOf2 = Long.valueOf(zzbad.zzf(bArr, i));
                zzbaeVar.zzdpn = objValueOf2;
                return i + 8;
            case 8:
                objValueOf3 = Float.valueOf(zzbad.zzh(bArr, i));
                zzbaeVar.zzdpn = objValueOf3;
                return i + 4;
            case 9:
            case 10:
            case 11:
                iZzb = zzbad.zza(bArr, i, zzbaeVar);
                iZzbu = zzbaeVar.zzdpl;
                objValueOf = Integer.valueOf(iZzbu);
                zzbaeVar.zzdpn = objValueOf;
                return iZzb;
            case 12:
            case 13:
                iZzb = zzbad.zzb(bArr, i, zzbaeVar);
                jZzl = zzbaeVar.zzdpm;
                objValueOf = Long.valueOf(jZzl);
                zzbaeVar.zzdpn = objValueOf;
                return iZzb;
            case 14:
                return zza((zzbdm) zzbdg.zzaeo().zze(cls), bArr, i, i2, zzbaeVar);
            case 15:
                iZzb = zzbad.zza(bArr, i, zzbaeVar);
                iZzbu = zzbaq.zzbu(zzbaeVar.zzdpl);
                objValueOf = Integer.valueOf(iZzbu);
                zzbaeVar.zzdpn = objValueOf;
                return iZzb;
            case 16:
                iZzb = zzbad.zzb(bArr, i, zzbaeVar);
                jZzl = zzbaq.zzl(zzbaeVar.zzdpm);
                objValueOf = Long.valueOf(jZzl);
                zzbaeVar.zzdpn = objValueOf;
                return iZzb;
            case 17:
                return zzbad.zzd(bArr, i, zzbaeVar);
            default:
                throw new RuntimeException("unsupported field type.");
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:41:0x00c7  */
    /* JADX WARN: Removed duplicated region for block: B:42:0x00ca  */
    /* JADX WARN: Removed duplicated region for block: B:45:0x00d2  */
    /* JADX WARN: Removed duplicated region for block: B:46:0x00d5  */
    /* JADX WARN: Removed duplicated region for block: B:49:0x00f2  */
    /* JADX WARN: Removed duplicated region for block: B:55:0x0119  */
    /* JADX WARN: Removed duplicated region for block: B:63:0x0146  */
    /* JADX WARN: Removed duplicated region for block: B:64:0x014c  */
    /* JADX WARN: Removed duplicated region for block: B:71:0x0165  */
    /* JADX WARN: Removed duplicated region for block: B:77:0x016d A[EDGE_INSN: B:77:0x016d->B:73:0x016d BREAK  A[LOOP:0: B:23:0x0067->B:72:0x0169], SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    static <T> com.google.android.gms.internal.ads.zzbcy<T> zza(java.lang.Class<T> r22, com.google.android.gms.internal.ads.zzbcs r23, com.google.android.gms.internal.ads.zzbdc r24, com.google.android.gms.internal.ads.zzbce r25, com.google.android.gms.internal.ads.zzbee<?, ?> r26, com.google.android.gms.internal.ads.zzbbd<?> r27, com.google.android.gms.internal.ads.zzbcp r28) {
        /*
            Method dump skipped, instruction units count: 406
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbcy.zza(java.lang.Class, com.google.android.gms.internal.ads.zzbcs, com.google.android.gms.internal.ads.zzbdc, com.google.android.gms.internal.ads.zzbce, com.google.android.gms.internal.ads.zzbee, com.google.android.gms.internal.ads.zzbbd, com.google.android.gms.internal.ads.zzbcp):com.google.android.gms.internal.ads.zzbcy");
    }

    private final <K, V, UT, UB> UB zza(int i, int i2, Map<K, V> map, zzbbs<?> zzbbsVar, UB ub, zzbee<UT, UB> zzbeeVar) {
        zzbcn<?, ?> zzbcnVarZzx = this.zzdwx.zzx(zzcr(i));
        Iterator<Map.Entry<K, V>> it2 = map.entrySet().iterator();
        while (it2.hasNext()) {
            Map.Entry<K, V> next = it2.next();
            if (zzbbsVar.zzq(((Integer) next.getValue()).intValue()) == null) {
                if (ub == null) {
                    ub = zzbeeVar.zzagb();
                }
                zzbam zzbamVarZzbo = zzbah.zzbo(zzbcm.zza(zzbcnVarZzx, next.getKey(), next.getValue()));
                try {
                    zzbcm.zza(zzbamVarZzbo.zzabj(), zzbcnVarZzx, next.getKey(), next.getValue());
                    zzbeeVar.zza(ub, i2, zzbamVarZzbo.zzabi());
                    it2.remove();
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
        }
        return ub;
    }

    private final <UT, UB> UB zza(Object obj, int i, UB ub, zzbee<UT, UB> zzbeeVar) {
        zzbbs<?> zzbbsVarZzcs;
        int i2 = this.zzdwg[i];
        Object objZzp = zzbek.zzp(obj, zzct(i) & 1048575);
        return (objZzp == null || (zzbbsVarZzcs = zzcs(i)) == null) ? ub : (UB) zza(i, i2, this.zzdwx.zzs(objZzp), zzbbsVarZzcs, ub, zzbeeVar);
    }

    private static void zza(int i, Object obj, zzbey zzbeyVar) {
        if (obj instanceof String) {
            zzbeyVar.zzf(i, (String) obj);
        } else {
            zzbeyVar.zza(i, (zzbah) obj);
        }
    }

    private static <UT, UB> void zza(zzbee<UT, UB> zzbeeVar, T t, zzbey zzbeyVar) {
        zzbeeVar.zza(zzbeeVar.zzac(t), zzbeyVar);
    }

    private final <K, V> void zza(zzbey zzbeyVar, int i, Object obj, int i2) {
        if (obj != null) {
            zzbeyVar.zza(i, this.zzdwx.zzx(zzcr(i2)), this.zzdwx.zzt(obj));
        }
    }

    private final void zza(Object obj, int i, zzbdl zzbdlVar) {
        long j;
        Object objZzabs;
        if (zzcv(i)) {
            j = i & 1048575;
            objZzabs = zzbdlVar.zzabr();
        } else if (this.zzdwn) {
            j = i & 1048575;
            objZzabs = zzbdlVar.readString();
        } else {
            j = i & 1048575;
            objZzabs = zzbdlVar.zzabs();
        }
        zzbek.zza(obj, j, objZzabs);
    }

    private final void zza(T t, T t2, int i) {
        long jZzct = zzct(i) & 1048575;
        if (zza(t2, i)) {
            Object objZzp = zzbek.zzp(t, jZzct);
            Object objZzp2 = zzbek.zzp(t2, jZzct);
            if (objZzp != null && objZzp2 != null) {
                zzbek.zza(t, jZzct, zzbbq.zza(objZzp, objZzp2));
                zzb(t, i);
            } else if (objZzp2 != null) {
                zzbek.zza(t, jZzct, objZzp2);
                zzb(t, i);
            }
        }
    }

    private final boolean zza(T t, int i) {
        if (!this.zzdwo) {
            int iZzcu = zzcu(i);
            return (zzbek.zzk(t, (long) (iZzcu & 1048575)) & (1 << (iZzcu >>> 20))) != 0;
        }
        int iZzct = zzct(i);
        long j = iZzct & 1048575;
        switch ((iZzct & 267386880) >>> 20) {
            case 0:
                return zzbek.zzo(t, j) != 0.0d;
            case 1:
                return zzbek.zzn(t, j) != 0.0f;
            case 2:
                return zzbek.zzl(t, j) != 0;
            case 3:
                return zzbek.zzl(t, j) != 0;
            case 4:
                return zzbek.zzk(t, j) != 0;
            case 5:
                return zzbek.zzl(t, j) != 0;
            case 6:
                return zzbek.zzk(t, j) != 0;
            case 7:
                return zzbek.zzm(t, j);
            case 8:
                Object objZzp = zzbek.zzp(t, j);
                if (objZzp instanceof String) {
                    return !((String) objZzp).isEmpty();
                }
                if (objZzp instanceof zzbah) {
                    return !zzbah.zzdpq.equals(objZzp);
                }
                throw new IllegalArgumentException();
            case 9:
                return zzbek.zzp(t, j) != null;
            case 10:
                return !zzbah.zzdpq.equals(zzbek.zzp(t, j));
            case 11:
                return zzbek.zzk(t, j) != 0;
            case 12:
                return zzbek.zzk(t, j) != 0;
            case 13:
                return zzbek.zzk(t, j) != 0;
            case 14:
                return zzbek.zzl(t, j) != 0;
            case 15:
                return zzbek.zzk(t, j) != 0;
            case 16:
                return zzbek.zzl(t, j) != 0;
            case 17:
                return zzbek.zzp(t, j) != null;
            default:
                throw new IllegalArgumentException();
        }
    }

    private final boolean zza(T t, int i, int i2) {
        return zzbek.zzk(t, (long) (zzcu(i2) & 1048575)) == i;
    }

    private final boolean zza(T t, int i, int i2, int i3) {
        return this.zzdwo ? zza(t, i) : (i2 & i3) != 0;
    }

    /* JADX WARN: Multi-variable type inference failed */
    private static boolean zza(Object obj, int i, zzbdm zzbdmVar) {
        return zzbdmVar.zzaa(zzbek.zzp(obj, i & 1048575));
    }

    private final void zzb(T t, int i) {
        if (this.zzdwo) {
            return;
        }
        int iZzcu = zzcu(i);
        long j = iZzcu & 1048575;
        zzbek.zzb(t, j, zzbek.zzk(t, j) | (1 << (iZzcu >>> 20)));
    }

    private final void zzb(T t, int i, int i2) {
        zzbek.zzb(t, zzcu(i2) & 1048575, i);
    }

    /* JADX WARN: Removed duplicated region for block: B:7:0x0021  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final void zzb(T r21, com.google.android.gms.internal.ads.zzbey r22) {
        /*
            Method dump skipped, instruction units count: 1440
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbcy.zzb(java.lang.Object, com.google.android.gms.internal.ads.zzbey):void");
    }

    private final void zzb(T t, T t2, int i) {
        int iZzct = zzct(i);
        int i2 = this.zzdwg[i];
        long j = iZzct & 1048575;
        if (zza(t2, i2, i)) {
            Object objZzp = zzbek.zzp(t, j);
            Object objZzp2 = zzbek.zzp(t2, j);
            if (objZzp != null && objZzp2 != null) {
                zzbek.zza(t, j, zzbbq.zza(objZzp, objZzp2));
                zzb(t, i2, i);
            } else if (objZzp2 != null) {
                zzbek.zza(t, j, objZzp2);
                zzb(t, i2, i);
            }
        }
    }

    private final boolean zzc(T t, T t2, int i) {
        return zza(t, i) == zza(t2, i);
    }

    private final zzbdm zzcq(int i) {
        int i2 = (i / 4) << 1;
        zzbdm zzbdmVar = (zzbdm) this.zzdwh[i2];
        if (zzbdmVar != null) {
            return zzbdmVar;
        }
        zzbdm<T> zzbdmVarZze = zzbdg.zzaeo().zze((Class) this.zzdwh[i2 + 1]);
        this.zzdwh[i2] = zzbdmVarZze;
        return zzbdmVarZze;
    }

    private final Object zzcr(int i) {
        return this.zzdwh[(i / 4) << 1];
    }

    private final zzbbs<?> zzcs(int i) {
        return (zzbbs) this.zzdwh[((i / 4) << 1) + 1];
    }

    private final int zzct(int i) {
        return this.zzdwg[i + 1];
    }

    private final int zzcu(int i) {
        return this.zzdwg[i + 2];
    }

    private static boolean zzcv(int i) {
        return (i & CrashUtils.ErrorDialogData.DYNAMITE_CRASH) != 0;
    }

    private final int zzcw(int i) {
        if (i >= this.zzdwi) {
            if (i < this.zzdwk) {
                int i2 = (i - this.zzdwi) << 2;
                if (this.zzdwg[i2] == i) {
                    return i2;
                }
                return -1;
            }
            if (i <= this.zzdwj) {
                int i3 = this.zzdwk - this.zzdwi;
                int length = (this.zzdwg.length / 4) - 1;
                while (i3 <= length) {
                    int i4 = (length + i3) >>> 1;
                    int i5 = i4 << 2;
                    int i6 = this.zzdwg[i5];
                    if (i == i6) {
                        return i5;
                    }
                    if (i < i6) {
                        length = i4 - 1;
                    } else {
                        i3 = i4 + 1;
                    }
                }
            }
        }
        return -1;
    }

    private static <E> List<E> zze(Object obj, long j) {
        return (List) zzbek.zzp(obj, j);
    }

    private static <T> double zzf(T t, long j) {
        return ((Double) zzbek.zzp(t, j)).doubleValue();
    }

    private static <T> float zzg(T t, long j) {
        return ((Float) zzbek.zzp(t, j)).floatValue();
    }

    private static <T> int zzh(T t, long j) {
        return ((Integer) zzbek.zzp(t, j)).intValue();
    }

    private static <T> long zzi(T t, long j) {
        return ((Long) zzbek.zzp(t, j)).longValue();
    }

    private static <T> boolean zzj(T t, long j) {
        return ((Boolean) zzbek.zzp(t, j)).booleanValue();
    }

    private static zzbef zzz(Object obj) {
        zzbbo zzbboVar = (zzbbo) obj;
        zzbef zzbefVar = zzbboVar.zzdtt;
        if (zzbefVar != zzbef.zzagc()) {
            return zzbefVar;
        }
        zzbef zzbefVarZzagd = zzbef.zzagd();
        zzbboVar.zzdtt = zzbefVarZzagd;
        return zzbefVarZzagd;
    }

    /* JADX WARN: Removed duplicated region for block: B:103:0x01a2  */
    @Override // com.google.android.gms.internal.ads.zzbdm
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final boolean equals(T r10, T r11) {
        /*
            Method dump skipped, instruction units count: 610
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbcy.equals(java.lang.Object, java.lang.Object):boolean");
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Removed duplicated region for block: B:68:0x00e2 A[PHI: r3
      0x00e2: PHI (r3v13 java.lang.Object) = (r3v11 java.lang.Object), (r3v14 java.lang.Object) binds: [B:67:0x00e0, B:62:0x00ce] A[DONT_GENERATE, DONT_INLINE]] */
    @Override // com.google.android.gms.internal.ads.zzbdm
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final int hashCode(T r9) {
        /*
            Method dump skipped, instruction units count: 476
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbcy.hashCode(java.lang.Object):int");
    }

    @Override // com.google.android.gms.internal.ads.zzbdm
    public final T newInstance() {
        return (T) this.zzdwt.newInstance(this.zzdwl);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference incomplete: some casts might be missing */
    @Override // com.google.android.gms.internal.ads.zzbdm
    public final void zza(T t, zzbdl zzbdlVar, zzbbb zzbbbVar) {
        long j;
        Object objZza;
        int iZzabu;
        List<Double> listZza;
        List<Float> listZza2;
        List<Long> listZza3;
        List<Long> listZza4;
        List<Integer> listZza5;
        List<Long> listZza6;
        List<Integer> listZza7;
        List<Boolean> listZza8;
        List<Integer> listZza9;
        List<Integer> listZza10;
        zzbbs<?> zzbbsVarZzcs;
        List<Integer> listZza11;
        List<Long> listZza12;
        List<Integer> listZza13;
        List<Long> listZza14;
        Object objZza2;
        if (zzbbbVar == null) {
            throw new NullPointerException();
        }
        zzbee<?, ?> zzbeeVar = this.zzdwv;
        zzbbd<?> zzbbdVar = this.zzdww;
        zzbbg zzbbgVarZzn = null;
        Object objZza3 = null;
        while (true) {
            try {
                int iZzaci = zzbdlVar.zzaci();
                int iZzcw = zzcw(iZzaci);
                if (iZzcw >= 0) {
                    int iZzct = zzct(iZzcw);
                    switch ((267386880 & iZzct) >>> 20) {
                        case 0:
                            zzbek.zza(t, iZzct & 1048575, zzbdlVar.readDouble());
                            zzb(t, iZzcw);
                            break;
                        case 1:
                            zzbek.zza((Object) t, iZzct & 1048575, zzbdlVar.readFloat());
                            zzb(t, iZzcw);
                            break;
                        case 2:
                            zzbek.zza((Object) t, iZzct & 1048575, zzbdlVar.zzabm());
                            zzb(t, iZzcw);
                            break;
                        case 3:
                            zzbek.zza((Object) t, iZzct & 1048575, zzbdlVar.zzabl());
                            zzb(t, iZzcw);
                            break;
                        case 4:
                            zzbek.zzb(t, iZzct & 1048575, zzbdlVar.zzabn());
                            zzb(t, iZzcw);
                            break;
                        case 5:
                            zzbek.zza((Object) t, iZzct & 1048575, zzbdlVar.zzabo());
                            zzb(t, iZzcw);
                            break;
                        case 6:
                            zzbek.zzb(t, iZzct & 1048575, zzbdlVar.zzabp());
                            zzb(t, iZzcw);
                            break;
                        case 7:
                            zzbek.zza(t, iZzct & 1048575, zzbdlVar.zzabq());
                            zzb(t, iZzcw);
                            break;
                        case 8:
                            zza(t, iZzct, zzbdlVar);
                            zzb(t, iZzcw);
                            break;
                        case 9:
                            if (zza(t, iZzcw)) {
                                j = iZzct & 1048575;
                                objZza = zzbbq.zza(zzbek.zzp(t, j), zzbdlVar.zza(zzcq(iZzcw), zzbbbVar));
                                zzbek.zza(t, j, objZza);
                            } else {
                                zzbek.zza(t, iZzct & 1048575, zzbdlVar.zza(zzcq(iZzcw), zzbbbVar));
                                zzb(t, iZzcw);
                            }
                            break;
                        case 10:
                            zzbek.zza(t, iZzct & 1048575, zzbdlVar.zzabs());
                            zzb(t, iZzcw);
                            break;
                        case 11:
                            zzbek.zzb(t, iZzct & 1048575, zzbdlVar.zzabt());
                            zzb(t, iZzcw);
                            break;
                        case 12:
                            iZzabu = zzbdlVar.zzabu();
                            zzbbs<?> zzbbsVarZzcs2 = zzcs(iZzcw);
                            if (zzbbsVarZzcs2 == null || zzbbsVarZzcs2.zzq(iZzabu) != null) {
                                zzbek.zzb(t, iZzct & 1048575, iZzabu);
                                zzb(t, iZzcw);
                            } else {
                                objZza2 = zzbdo.zza(iZzaci, iZzabu, objZza3, (zzbee<UT, Object>) zzbeeVar);
                                objZza3 = objZza2;
                            }
                            break;
                        case 13:
                            zzbek.zzb(t, iZzct & 1048575, zzbdlVar.zzabv());
                            zzb(t, iZzcw);
                            break;
                        case 14:
                            zzbek.zza((Object) t, iZzct & 1048575, zzbdlVar.zzabw());
                            zzb(t, iZzcw);
                            break;
                        case 15:
                            zzbek.zzb(t, iZzct & 1048575, zzbdlVar.zzabx());
                            zzb(t, iZzcw);
                            break;
                        case 16:
                            zzbek.zza((Object) t, iZzct & 1048575, zzbdlVar.zzaby());
                            zzb(t, iZzcw);
                            break;
                        case 17:
                            if (zza(t, iZzcw)) {
                                j = iZzct & 1048575;
                                objZza = zzbbq.zza(zzbek.zzp(t, j), zzbdlVar.zzb(zzcq(iZzcw), zzbbbVar));
                                zzbek.zza(t, j, objZza);
                            } else {
                                zzbek.zza(t, iZzct & 1048575, zzbdlVar.zzb(zzcq(iZzcw), zzbbbVar));
                                zzb(t, iZzcw);
                            }
                            break;
                        case 18:
                            listZza = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzp(listZza);
                            break;
                        case 19:
                            listZza2 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzq(listZza2);
                            break;
                        case 20:
                            listZza3 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzs(listZza3);
                            break;
                        case 21:
                            listZza4 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzr(listZza4);
                            break;
                        case 22:
                            listZza5 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzt(listZza5);
                            break;
                        case 23:
                            listZza6 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzu(listZza6);
                            break;
                        case 24:
                            listZza7 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzv(listZza7);
                            break;
                        case 25:
                            listZza8 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzw(listZza8);
                            break;
                        case 26:
                            if (zzcv(iZzct)) {
                                zzbdlVar.zzx(this.zzdwu.zza(t, iZzct & 1048575));
                            } else {
                                zzbdlVar.readStringList(this.zzdwu.zza(t, iZzct & 1048575));
                            }
                            break;
                        case 27:
                            zzbdlVar.zza(this.zzdwu.zza(t, iZzct & 1048575), zzcq(iZzcw), zzbbbVar);
                            break;
                        case 28:
                            zzbdlVar.zzy(this.zzdwu.zza(t, iZzct & 1048575));
                            break;
                        case 29:
                            listZza9 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzz(listZza9);
                            break;
                        case 30:
                            listZza10 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzaa(listZza10);
                            zzbbsVarZzcs = zzcs(iZzcw);
                            objZza2 = zzbdo.zza(iZzaci, listZza10, zzbbsVarZzcs, objZza3, zzbeeVar);
                            objZza3 = objZza2;
                            break;
                        case 31:
                            listZza11 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzab(listZza11);
                            break;
                        case 32:
                            listZza12 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzac(listZza12);
                            break;
                        case 33:
                            listZza13 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzad(listZza13);
                            break;
                        case 34:
                            listZza14 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzae(listZza14);
                            break;
                        case 35:
                            listZza = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzp(listZza);
                            break;
                        case 36:
                            listZza2 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzq(listZza2);
                            break;
                        case 37:
                            listZza3 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzs(listZza3);
                            break;
                        case 38:
                            listZza4 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzr(listZza4);
                            break;
                        case 39:
                            listZza5 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzt(listZza5);
                            break;
                        case 40:
                            listZza6 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzu(listZza6);
                            break;
                        case 41:
                            listZza7 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzv(listZza7);
                            break;
                        case 42:
                            listZza8 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzw(listZza8);
                            break;
                        case 43:
                            listZza9 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzz(listZza9);
                            break;
                        case 44:
                            listZza10 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzaa(listZza10);
                            zzbbsVarZzcs = zzcs(iZzcw);
                            objZza2 = zzbdo.zza(iZzaci, listZza10, zzbbsVarZzcs, objZza3, zzbeeVar);
                            objZza3 = objZza2;
                            break;
                        case 45:
                            listZza11 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzab(listZza11);
                            break;
                        case 46:
                            listZza12 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzac(listZza12);
                            break;
                        case 47:
                            listZza13 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzad(listZza13);
                            break;
                        case 48:
                            listZza14 = this.zzdwu.zza(t, iZzct & 1048575);
                            zzbdlVar.zzae(listZza14);
                            break;
                        case 49:
                            zzbdlVar.zzb(this.zzdwu.zza(t, iZzct & 1048575), zzcq(iZzcw), zzbbbVar);
                            break;
                        case 50:
                            Object objZzcr = zzcr(iZzcw);
                            long jZzct = zzct(iZzcw) & 1048575;
                            Object objZzp = zzbek.zzp(t, jZzct);
                            if (objZzp == null) {
                                objZzp = this.zzdwx.zzw(objZzcr);
                                zzbek.zza(t, jZzct, objZzp);
                            } else if (this.zzdwx.zzu(objZzp)) {
                                Object objZzw = this.zzdwx.zzw(objZzcr);
                                this.zzdwx.zzb(objZzw, objZzp);
                                zzbek.zza(t, jZzct, objZzw);
                                objZzp = objZzw;
                            }
                            zzbdlVar.zza(this.zzdwx.zzs(objZzp), this.zzdwx.zzx(objZzcr), zzbbbVar);
                            break;
                        case 51:
                            zzbek.zza(t, iZzct & 1048575, Double.valueOf(zzbdlVar.readDouble()));
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 52:
                            zzbek.zza(t, iZzct & 1048575, Float.valueOf(zzbdlVar.readFloat()));
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 53:
                            zzbek.zza(t, iZzct & 1048575, Long.valueOf(zzbdlVar.zzabm()));
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 54:
                            zzbek.zza(t, iZzct & 1048575, Long.valueOf(zzbdlVar.zzabl()));
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 55:
                            zzbek.zza(t, iZzct & 1048575, Integer.valueOf(zzbdlVar.zzabn()));
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 56:
                            zzbek.zza(t, iZzct & 1048575, Long.valueOf(zzbdlVar.zzabo()));
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 57:
                            zzbek.zza(t, iZzct & 1048575, Integer.valueOf(zzbdlVar.zzabp()));
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 58:
                            zzbek.zza(t, iZzct & 1048575, Boolean.valueOf(zzbdlVar.zzabq()));
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 59:
                            zza(t, iZzct, zzbdlVar);
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 60:
                            if (zza(t, iZzaci, iZzcw)) {
                                long j2 = iZzct & 1048575;
                                zzbek.zza(t, j2, zzbbq.zza(zzbek.zzp(t, j2), zzbdlVar.zza(zzcq(iZzcw), zzbbbVar)));
                            } else {
                                zzbek.zza(t, iZzct & 1048575, zzbdlVar.zza(zzcq(iZzcw), zzbbbVar));
                                zzb(t, iZzcw);
                            }
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 61:
                            zzbek.zza(t, iZzct & 1048575, zzbdlVar.zzabs());
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 62:
                            zzbek.zza(t, iZzct & 1048575, Integer.valueOf(zzbdlVar.zzabt()));
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 63:
                            iZzabu = zzbdlVar.zzabu();
                            zzbbs<?> zzbbsVarZzcs3 = zzcs(iZzcw);
                            if (zzbbsVarZzcs3 != null && zzbbsVarZzcs3.zzq(iZzabu) == null) {
                                objZza2 = zzbdo.zza(iZzaci, iZzabu, objZza3, (zzbee<UT, Object>) zzbeeVar);
                                objZza3 = objZza2;
                            }
                            zzbek.zza(t, iZzct & 1048575, Integer.valueOf(iZzabu));
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 64:
                            zzbek.zza(t, iZzct & 1048575, Integer.valueOf(zzbdlVar.zzabv()));
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 65:
                            zzbek.zza(t, iZzct & 1048575, Long.valueOf(zzbdlVar.zzabw()));
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 66:
                            zzbek.zza(t, iZzct & 1048575, Integer.valueOf(zzbdlVar.zzabx()));
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 67:
                            zzbek.zza(t, iZzct & 1048575, Long.valueOf(zzbdlVar.zzaby()));
                            zzb(t, iZzaci, iZzcw);
                            break;
                        case 68:
                            zzbek.zza(t, iZzct & 1048575, zzbdlVar.zzb(zzcq(iZzcw), zzbbbVar));
                            zzb(t, iZzaci, iZzcw);
                            break;
                        default:
                            if (objZza3 == null) {
                                try {
                                    objZza3 = zzbeeVar.zzagb();
                                } catch (zzbbv unused) {
                                    zzbeeVar.zza(zzbdlVar);
                                    if (objZza3 == null) {
                                        objZza3 = zzbeeVar.zzad(t);
                                    }
                                    if (!zzbeeVar.zza((Object) objZza3, zzbdlVar)) {
                                        if (this.zzdwr != null) {
                                            for (int i : this.zzdwr) {
                                                objZza3 = zza((Object) t, i, objZza3, (zzbee<UT, Object>) zzbeeVar);
                                            }
                                        }
                                        if (objZza3 != null) {
                                            zzbeeVar.zzf(t, (Object) objZza3);
                                            return;
                                        }
                                        return;
                                    }
                                }
                                break;
                            }
                            if (!zzbeeVar.zza((Object) objZza3, zzbdlVar)) {
                                if (this.zzdwr != null) {
                                    for (int i2 : this.zzdwr) {
                                        objZza3 = zza((Object) t, i2, objZza3, (zzbee<UT, Object>) zzbeeVar);
                                    }
                                }
                                if (objZza3 != null) {
                                    zzbeeVar.zzf(t, (Object) objZza3);
                                    return;
                                }
                                return;
                            }
                            break;
                            break;
                    }
                } else {
                    if (iZzaci == Integer.MAX_VALUE) {
                        if (this.zzdwr != null) {
                            for (int i3 : this.zzdwr) {
                                objZza3 = zza((Object) t, i3, objZza3, (zzbee<UT, Object>) zzbeeVar);
                            }
                        }
                        if (objZza3 != null) {
                            zzbeeVar.zzf(t, (Object) objZza3);
                            return;
                        }
                        return;
                    }
                    Object objZza4 = !this.zzdwm ? null : zzbbdVar.zza(zzbbbVar, this.zzdwl, iZzaci);
                    if (objZza4 != null) {
                        if (zzbbgVarZzn == null) {
                            zzbbgVarZzn = zzbbdVar.zzn(t);
                        }
                        zzbbg zzbbgVar = zzbbgVarZzn;
                        objZza3 = zzbbdVar.zza(zzbdlVar, objZza4, zzbbbVar, zzbbgVar, objZza3, zzbeeVar);
                        zzbbgVarZzn = zzbbgVar;
                    } else {
                        zzbeeVar.zza(zzbdlVar);
                        if (objZza3 == null) {
                            objZza3 = zzbeeVar.zzad(t);
                        }
                        if (!zzbeeVar.zza((Object) objZza3, zzbdlVar)) {
                            if (this.zzdwr != null) {
                                for (int i4 : this.zzdwr) {
                                    objZza3 = zza((Object) t, i4, objZza3, (zzbee<UT, Object>) zzbeeVar);
                                }
                            }
                            if (objZza3 != null) {
                                zzbeeVar.zzf(t, (Object) objZza3);
                                return;
                            }
                            return;
                        }
                    }
                }
            } finally {
            }
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:112:0x0385  */
    /* JADX WARN: Removed duplicated region for block: B:139:0x0400  */
    /* JADX WARN: Removed duplicated region for block: B:142:0x0413  */
    /* JADX WARN: Removed duplicated region for block: B:145:0x0428  */
    /* JADX WARN: Removed duplicated region for block: B:192:0x04ee  */
    /* JADX WARN: Removed duplicated region for block: B:295:0x0843  */
    /* JADX WARN: Removed duplicated region for block: B:322:0x08be  */
    /* JADX WARN: Removed duplicated region for block: B:325:0x08d1  */
    /* JADX WARN: Removed duplicated region for block: B:328:0x08e6  */
    /* JADX WARN: Removed duplicated region for block: B:9:0x0030  */
    @Override // com.google.android.gms.internal.ads.zzbdm
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final void zza(T r14, com.google.android.gms.internal.ads.zzbey r15) {
        /*
            Method dump skipped, instruction units count: 2738
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbcy.zza(java.lang.Object, com.google.android.gms.internal.ads.zzbey):void");
    }

    /* JADX WARN: Code restructure failed: missing block: B:80:0x0190, code lost:
    
        if (r0 == r15) goto L74;
     */
    /* JADX WARN: Code restructure failed: missing block: B:84:0x01ac, code lost:
    
        if (r0 == r15) goto L74;
     */
    @Override // com.google.android.gms.internal.ads.zzbdm
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final void zza(T r25, byte[] r26, int r27, int r28, com.google.android.gms.internal.ads.zzbae r29) throws com.google.android.gms.internal.ads.zzbbu {
        /*
            Method dump skipped, instruction units count: 526
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbcy.zza(java.lang.Object, byte[], int, int, com.google.android.gms.internal.ads.zzbae):void");
    }

    /* JADX WARN: Code restructure failed: missing block: B:96:0x011a, code lost:
    
        continue;
     */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:49:0x00c7  */
    /* JADX WARN: Removed duplicated region for block: B:57:0x00dc  */
    /* JADX WARN: Removed duplicated region for block: B:86:0x00ca A[SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:88:0x0108 A[SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:90:0x011a A[SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:93:0x011a A[SYNTHETIC] */
    /* JADX WARN: Type inference failed for: r4v17 */
    /* JADX WARN: Type inference failed for: r4v18 */
    /* JADX WARN: Type inference failed for: r4v19, types: [com.google.android.gms.internal.ads.zzbdm] */
    /* JADX WARN: Type inference failed for: r4v22 */
    /* JADX WARN: Type inference failed for: r4v23 */
    /* JADX WARN: Type inference failed for: r4v7, types: [com.google.android.gms.internal.ads.zzbdm] */
    @Override // com.google.android.gms.internal.ads.zzbdm
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final boolean zzaa(T r17) {
        /*
            Method dump skipped, instruction units count: 318
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbcy.zzaa(java.lang.Object):boolean");
    }

    /* JADX WARN: Removed duplicated region for block: B:17:0x0037  */
    @Override // com.google.android.gms.internal.ads.zzbdm
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final void zzc(T r7, T r8) {
        /*
            Method dump skipped, instruction units count: 410
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbcy.zzc(java.lang.Object, java.lang.Object):void");
    }

    @Override // com.google.android.gms.internal.ads.zzbdm
    public final void zzo(T t) {
        if (this.zzdwr != null) {
            for (int i : this.zzdwr) {
                long jZzct = zzct(i) & 1048575;
                Object objZzp = zzbek.zzp(t, jZzct);
                if (objZzp != null) {
                    zzbek.zza(t, jZzct, this.zzdwx.zzv(objZzp));
                }
            }
        }
        if (this.zzdws != null) {
            int length = this.zzdws.length;
            for (int i2 = 0; i2 < length; i2++) {
                this.zzdwu.zzb(t, r0[i2]);
            }
        }
        this.zzdwv.zzo(t);
        if (this.zzdwm) {
            this.zzdww.zzo(t);
        }
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Code restructure failed: missing block: B:247:0x0418, code lost:
    
        if (zza(r22, r14, r3) != false) goto L393;
     */
    /* JADX WARN: Code restructure failed: missing block: B:256:0x0438, code lost:
    
        if (zza(r22, r14, r3) != false) goto L404;
     */
    /* JADX WARN: Code restructure failed: missing block: B:259:0x0440, code lost:
    
        if (zza(r22, r14, r3) != false) goto L407;
     */
    /* JADX WARN: Code restructure failed: missing block: B:268:0x0460, code lost:
    
        if (zza(r22, r14, r3) != false) goto L419;
     */
    /* JADX WARN: Code restructure failed: missing block: B:271:0x0468, code lost:
    
        if (zza(r22, r14, r3) != false) goto L423;
     */
    /* JADX WARN: Code restructure failed: missing block: B:279:0x0480, code lost:
    
        if (zza(r22, r14, r3) != false) goto L432;
     */
    /* JADX WARN: Code restructure failed: missing block: B:392:0x06b8, code lost:
    
        if ((r12 & r16) != 0) goto L393;
     */
    /* JADX WARN: Code restructure failed: missing block: B:393:0x06ba, code lost:
    
        r6 = com.google.android.gms.internal.ads.zzbav.zzc(r14, (com.google.android.gms.internal.ads.zzbcu) r2.getObject(r22, r9), zzcq(r3));
     */
    /* JADX WARN: Code restructure failed: missing block: B:403:0x06e5, code lost:
    
        if ((r12 & r16) != 0) goto L404;
     */
    /* JADX WARN: Code restructure failed: missing block: B:404:0x06e7, code lost:
    
        r6 = com.google.android.gms.internal.ads.zzbav.zzh(r14, 0);
     */
    /* JADX WARN: Code restructure failed: missing block: B:406:0x06f0, code lost:
    
        if ((r12 & r16) != 0) goto L407;
     */
    /* JADX WARN: Code restructure failed: missing block: B:407:0x06f2, code lost:
    
        r9 = com.google.android.gms.internal.ads.zzbav.zzu(r14, 0);
     */
    /* JADX WARN: Code restructure failed: missing block: B:418:0x0715, code lost:
    
        if ((r12 & r16) != 0) goto L419;
     */
    /* JADX WARN: Code restructure failed: missing block: B:419:0x0717, code lost:
    
        r6 = r2.getObject(r22, r9);
     */
    /* JADX WARN: Code restructure failed: missing block: B:422:0x0724, code lost:
    
        if ((r12 & r16) != 0) goto L423;
     */
    /* JADX WARN: Code restructure failed: missing block: B:423:0x0726, code lost:
    
        r6 = com.google.android.gms.internal.ads.zzbdo.zzc(r14, r2.getObject(r22, r9), zzcq(r3));
     */
    /* JADX WARN: Code restructure failed: missing block: B:431:0x074b, code lost:
    
        if ((r12 & r16) != 0) goto L432;
     */
    /* JADX WARN: Code restructure failed: missing block: B:432:0x074d, code lost:
    
        r6 = com.google.android.gms.internal.ads.zzbav.zzg(r14, true);
     */
    /* JADX WARN: Removed duplicated region for block: B:142:0x020d A[PHI: r4
      0x020d: PHI (r4v84 int) = 
      (r4v47 int)
      (r4v50 int)
      (r4v53 int)
      (r4v56 int)
      (r4v59 int)
      (r4v62 int)
      (r4v65 int)
      (r4v68 int)
      (r4v71 int)
      (r4v74 int)
      (r4v77 int)
      (r4v80 int)
      (r4v83 int)
      (r4v88 int)
     binds: [B:141:0x020b, B:136:0x01fa, B:131:0x01e9, B:126:0x01d8, B:121:0x01c7, B:116:0x01b6, B:111:0x01a5, B:106:0x0193, B:101:0x0181, B:96:0x016f, B:91:0x015d, B:86:0x014b, B:81:0x0139, B:76:0x0127] A[DONT_GENERATE, DONT_INLINE]] */
    /* JADX WARN: Removed duplicated region for block: B:186:0x030a A[PHI: r4
      0x030a: PHI (r4v107 java.lang.Object) = (r4v25 java.lang.Object), (r4v105 java.lang.Object), (r4v109 java.lang.Object) binds: [B:193:0x0331, B:45:0x00ab, B:185:0x0306] A[DONT_GENERATE, DONT_INLINE]] */
    /* JADX WARN: Removed duplicated region for block: B:195:0x0334 A[PHI: r4
      0x0334: PHI (r4v103 java.lang.Object) = (r4v25 java.lang.Object), (r4v105 java.lang.Object) binds: [B:193:0x0331, B:45:0x00ab] A[DONT_GENERATE, DONT_INLINE]] */
    /* JADX WARN: Removed duplicated region for block: B:373:0x05fe A[PHI: r9
      0x05fe: PHI (r9v62 int) = 
      (r9v25 int)
      (r9v28 int)
      (r9v31 int)
      (r9v34 int)
      (r9v37 int)
      (r9v40 int)
      (r9v43 int)
      (r9v46 int)
      (r9v49 int)
      (r9v52 int)
      (r9v55 int)
      (r9v58 int)
      (r9v61 int)
      (r9v66 int)
     binds: [B:372:0x05fc, B:367:0x05eb, B:362:0x05da, B:357:0x05c9, B:352:0x05b8, B:347:0x05a7, B:342:0x0596, B:337:0x0584, B:332:0x0572, B:327:0x0560, B:322:0x054e, B:317:0x053c, B:312:0x052a, B:307:0x0518] A[DONT_GENERATE, DONT_INLINE]] */
    /* JADX WARN: Removed duplicated region for block: B:389:0x06ae A[PHI: r4
      0x06ae: PHI (r4v4 int) = 
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v14 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v1 int)
      (r4v15 int)
      (r4v1 int)
     binds: [B:244:0x040f, B:434:0x0755, B:431:0x074b, B:425:0x0736, B:422:0x0724, B:418:0x0715, B:414:0x0708, B:410:0x06fb, B:406:0x06f0, B:403:0x06e5, B:399:0x06d8, B:395:0x06cb, B:392:0x06b8, B:370:0x05f8, B:365:0x05e7, B:360:0x05d6, B:355:0x05c5, B:350:0x05b4, B:345:0x05a3, B:340:0x0592, B:335:0x0580, B:330:0x056e, B:325:0x055c, B:320:0x054a, B:315:0x0538, B:310:0x0526, B:305:0x0514, B:300:0x04e0, B:297:0x04d3, B:294:0x04c3, B:291:0x04b3, B:288:0x04a3, B:285:0x0495, B:282:0x0488, B:279:0x0480, B:274:0x0470, B:271:0x0468, B:268:0x0460, B:265:0x0454, B:262:0x0448, B:408:0x06f7, B:259:0x0440, B:256:0x0438, B:253:0x042c, B:250:0x0420, B:388:0x06ad, B:247:0x0418] A[DONT_GENERATE, DONT_INLINE]] */
    /* JADX WARN: Removed duplicated region for block: B:420:0x071b A[PHI: r6
      0x071b: PHI (r6v110 java.lang.Object) = (r6v25 java.lang.Object), (r6v106 java.lang.Object), (r6v113 java.lang.Object) binds: [B:427:0x073e, B:276:0x0478, B:419:0x0717] A[DONT_GENERATE, DONT_INLINE]] */
    /* JADX WARN: Removed duplicated region for block: B:429:0x0741 A[PHI: r6
      0x0741: PHI (r6v102 java.lang.Object) = (r6v25 java.lang.Object), (r6v106 java.lang.Object) binds: [B:427:0x073e, B:276:0x0478] A[DONT_GENERATE, DONT_INLINE]] */
    @Override // com.google.android.gms.internal.ads.zzbdm
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final int zzy(T r22) {
        /*
            Method dump skipped, instruction units count: 2298
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbcy.zzy(java.lang.Object):int");
    }
}
