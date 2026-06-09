package com.google.android.gms.internal.firebase_auth;

import com.google.android.gms.common.util.CrashUtils;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import sun.misc.Unsafe;

/* JADX INFO: loaded from: classes2.dex */
final class zzel<T> implements zzev<T> {
    private static final int[] zzti = new int[0];
    private static final Unsafe zztj = zzfv.zzge();
    private final int[] zztk;
    private final Object[] zztl;
    private final int zztm;
    private final int zztn;
    private final zzeh zzto;
    private final boolean zztp;
    private final boolean zztq;
    private final boolean zztr;
    private final boolean zzts;
    private final int[] zztt;
    private final int zztu;
    private final int zztv;
    private final zzeo zztw;
    private final zzdr zztx;
    private final zzfp<?, ?> zzty;
    private final zzcp<?> zztz;
    private final zzec zzua;

    private zzel(int[] iArr, Object[] objArr, int i, int i2, zzeh zzehVar, boolean z, boolean z2, int[] iArr2, int i3, int i4, zzeo zzeoVar, zzdr zzdrVar, zzfp<?, ?> zzfpVar, zzcp<?> zzcpVar, zzec zzecVar) {
        this.zztk = iArr;
        this.zztl = objArr;
        this.zztm = i;
        this.zztn = i2;
        this.zztq = zzehVar instanceof zzdb;
        this.zztr = z;
        this.zztp = zzcpVar != null && zzcpVar.zze(zzehVar);
        this.zzts = false;
        this.zztt = iArr2;
        this.zztu = i3;
        this.zztv = i4;
        this.zztw = zzeoVar;
        this.zztx = zzdrVar;
        this.zzty = zzfpVar;
        this.zztz = zzcpVar;
        this.zzto = zzehVar;
        this.zzua = zzecVar;
    }

    private static <UT, UB> int zza(zzfp<UT, UB> zzfpVar, T t) {
        return zzfpVar.zzo(zzfpVar.zzr(t));
    }

    /* JADX WARN: Removed duplicated region for block: B:173:0x03ba  */
    /* JADX WARN: Removed duplicated region for block: B:188:0x040d  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    static <T> com.google.android.gms.internal.firebase_auth.zzel<T> zza(java.lang.Class<T> r40, com.google.android.gms.internal.firebase_auth.zzef r41, com.google.android.gms.internal.firebase_auth.zzeo r42, com.google.android.gms.internal.firebase_auth.zzdr r43, com.google.android.gms.internal.firebase_auth.zzfp<?, ?> r44, com.google.android.gms.internal.firebase_auth.zzcp<?> r45, com.google.android.gms.internal.firebase_auth.zzec r46) {
        /*
            Method dump skipped, instruction units count: 1167
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.firebase_auth.zzel.zza(java.lang.Class, com.google.android.gms.internal.firebase_auth.zzef, com.google.android.gms.internal.firebase_auth.zzeo, com.google.android.gms.internal.firebase_auth.zzdr, com.google.android.gms.internal.firebase_auth.zzfp, com.google.android.gms.internal.firebase_auth.zzcp, com.google.android.gms.internal.firebase_auth.zzec):com.google.android.gms.internal.firebase_auth.zzel");
    }

    private final <K, V, UT, UB> UB zza(int i, int i2, Map<K, V> map, zzdf<?> zzdfVar, UB ub, zzfp<UT, UB> zzfpVar) {
        zzea<?, ?> zzeaVarZzn = this.zzua.zzn(zzao(i));
        Iterator<Map.Entry<K, V>> it2 = map.entrySet().iterator();
        while (it2.hasNext()) {
            Map.Entry<K, V> next = it2.next();
            if (zzdfVar.zzam(((Integer) next.getValue()).intValue()) == null) {
                if (ub == null) {
                    ub = zzfpVar.zzfy();
                }
                zzbz zzbzVarZzl = zzbu.zzl(zzdz.zza(zzeaVarZzn, next.getKey(), next.getValue()));
                try {
                    zzdz.zza(zzbzVarZzl.zzcb(), zzeaVarZzn, next.getKey(), next.getValue());
                    zzfpVar.zza(ub, i2, zzbzVarZzl.zzca());
                    it2.remove();
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
        }
        return ub;
    }

    private final <UT, UB> UB zza(Object obj, int i, UB ub, zzfp<UT, UB> zzfpVar) {
        zzdf<?> zzdfVarZzap;
        int i2 = this.zztk[i];
        Object objZzp = zzfv.zzp(obj, zzaq(i) & 1048575);
        return (objZzp == null || (zzdfVarZzap = zzap(i)) == null) ? ub : (UB) zza(i, i2, this.zzua.zzi(objZzp), zzdfVarZzap, ub, zzfpVar);
    }

    private static Field zza(Class<?> cls, String str) {
        try {
            return cls.getDeclaredField(str);
        } catch (NoSuchFieldException unused) {
            Field[] declaredFields = cls.getDeclaredFields();
            for (Field field : declaredFields) {
                if (str.equals(field.getName())) {
                    return field;
                }
            }
            String name = cls.getName();
            String string = Arrays.toString(declaredFields);
            StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 40 + String.valueOf(name).length() + String.valueOf(string).length());
            sb.append("Field ");
            sb.append(str);
            sb.append(" for ");
            sb.append(name);
            sb.append(" not found. Known fields are ");
            sb.append(string);
            throw new RuntimeException(sb.toString());
        }
    }

    private static void zza(int i, Object obj, zzgj zzgjVar) {
        if (obj instanceof String) {
            zzgjVar.zza(i, (String) obj);
        } else {
            zzgjVar.zza(i, (zzbu) obj);
        }
    }

    private static <UT, UB> void zza(zzfp<UT, UB> zzfpVar, T t, zzgj zzgjVar) {
        zzfpVar.zza(zzfpVar.zzr(t), zzgjVar);
    }

    private final <K, V> void zza(zzgj zzgjVar, int i, Object obj, int i2) {
        if (obj != null) {
            zzgjVar.zza(i, this.zzua.zzn(zzao(i2)), this.zzua.zzj(obj));
        }
    }

    private final void zza(Object obj, int i, zzeu zzeuVar) {
        long j;
        Object objZzck;
        if (zzas(i)) {
            j = i & 1048575;
            objZzck = zzeuVar.zzcj();
        } else if (this.zztq) {
            j = i & 1048575;
            objZzck = zzeuVar.readString();
        } else {
            j = i & 1048575;
            objZzck = zzeuVar.zzck();
        }
        zzfv.zza(obj, j, objZzck);
    }

    private final void zza(T t, T t2, int i) {
        long jZzaq = zzaq(i) & 1048575;
        if (zza(t2, i)) {
            Object objZzp = zzfv.zzp(t, jZzaq);
            Object objZzp2 = zzfv.zzp(t2, jZzaq);
            if (objZzp != null && objZzp2 != null) {
                zzfv.zza(t, jZzaq, zzdd.zza(objZzp, objZzp2));
                zzb(t, i);
            } else if (objZzp2 != null) {
                zzfv.zza(t, jZzaq, objZzp2);
                zzb(t, i);
            }
        }
    }

    private final boolean zza(T t, int i) {
        if (!this.zztr) {
            int iZzar = zzar(i);
            return (zzfv.zzk(t, (long) (iZzar & 1048575)) & (1 << (iZzar >>> 20))) != 0;
        }
        int iZzaq = zzaq(i);
        long j = iZzaq & 1048575;
        switch ((iZzaq & 267386880) >>> 20) {
            case 0:
                return zzfv.zzo(t, j) != 0.0d;
            case 1:
                return zzfv.zzn(t, j) != 0.0f;
            case 2:
                return zzfv.zzl(t, j) != 0;
            case 3:
                return zzfv.zzl(t, j) != 0;
            case 4:
                return zzfv.zzk(t, j) != 0;
            case 5:
                return zzfv.zzl(t, j) != 0;
            case 6:
                return zzfv.zzk(t, j) != 0;
            case 7:
                return zzfv.zzm(t, j);
            case 8:
                Object objZzp = zzfv.zzp(t, j);
                if (objZzp instanceof String) {
                    return !((String) objZzp).isEmpty();
                }
                if (objZzp instanceof zzbu) {
                    return !zzbu.zzmi.equals(objZzp);
                }
                throw new IllegalArgumentException();
            case 9:
                return zzfv.zzp(t, j) != null;
            case 10:
                return !zzbu.zzmi.equals(zzfv.zzp(t, j));
            case 11:
                return zzfv.zzk(t, j) != 0;
            case 12:
                return zzfv.zzk(t, j) != 0;
            case 13:
                return zzfv.zzk(t, j) != 0;
            case 14:
                return zzfv.zzl(t, j) != 0;
            case 15:
                return zzfv.zzk(t, j) != 0;
            case 16:
                return zzfv.zzl(t, j) != 0;
            case 17:
                return zzfv.zzp(t, j) != null;
            default:
                throw new IllegalArgumentException();
        }
    }

    private final boolean zza(T t, int i, int i2) {
        return zzfv.zzk(t, (long) (zzar(i2) & 1048575)) == i;
    }

    private final boolean zza(T t, int i, int i2, int i3) {
        return this.zztr ? zza(t, i) : (i2 & i3) != 0;
    }

    /* JADX WARN: Multi-variable type inference failed */
    private static boolean zza(Object obj, int i, zzev zzevVar) {
        return zzevVar.zzp(zzfv.zzp(obj, i & 1048575));
    }

    private final zzev zzan(int i) {
        int i2 = (i / 3) << 1;
        zzev zzevVar = (zzev) this.zztl[i2];
        if (zzevVar != null) {
            return zzevVar;
        }
        zzev<T> zzevVarZzf = zzes.zzfg().zzf((Class) this.zztl[i2 + 1]);
        this.zztl[i2] = zzevVarZzf;
        return zzevVarZzf;
    }

    private final Object zzao(int i) {
        return this.zztl[(i / 3) << 1];
    }

    private final zzdf<?> zzap(int i) {
        return (zzdf) this.zztl[((i / 3) << 1) + 1];
    }

    private final int zzaq(int i) {
        return this.zztk[i + 1];
    }

    private final int zzar(int i) {
        return this.zztk[i + 2];
    }

    private static boolean zzas(int i) {
        return (i & CrashUtils.ErrorDialogData.DYNAMITE_CRASH) != 0;
    }

    private final void zzb(T t, int i) {
        if (this.zztr) {
            return;
        }
        int iZzar = zzar(i);
        long j = iZzar & 1048575;
        zzfv.zzb(t, j, zzfv.zzk(t, j) | (1 << (iZzar >>> 20)));
    }

    private final void zzb(T t, int i, int i2) {
        zzfv.zzb(t, zzar(i2) & 1048575, i);
    }

    /* JADX WARN: Removed duplicated region for block: B:7:0x0021  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final void zzb(T r21, com.google.android.gms.internal.firebase_auth.zzgj r22) {
        /*
            Method dump skipped, instruction units count: 1440
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.firebase_auth.zzel.zzb(java.lang.Object, com.google.android.gms.internal.firebase_auth.zzgj):void");
    }

    private final void zzb(T t, T t2, int i) {
        int iZzaq = zzaq(i);
        int i2 = this.zztk[i];
        long j = iZzaq & 1048575;
        if (zza(t2, i2, i)) {
            Object objZzp = zzfv.zzp(t, j);
            Object objZzp2 = zzfv.zzp(t2, j);
            if (objZzp != null && objZzp2 != null) {
                zzfv.zza(t, j, zzdd.zza(objZzp, objZzp2));
                zzb(t, i2, i);
            } else if (objZzp2 != null) {
                zzfv.zza(t, j, objZzp2);
                zzb(t, i2, i);
            }
        }
    }

    private final boolean zzc(T t, T t2, int i) {
        return zza(t, i) == zza(t2, i);
    }

    private static <E> List<E> zze(Object obj, long j) {
        return (List) zzfv.zzp(obj, j);
    }

    private static <T> double zzf(T t, long j) {
        return ((Double) zzfv.zzp(t, j)).doubleValue();
    }

    private static <T> float zzg(T t, long j) {
        return ((Float) zzfv.zzp(t, j)).floatValue();
    }

    private static <T> int zzh(T t, long j) {
        return ((Integer) zzfv.zzp(t, j)).intValue();
    }

    private static <T> long zzi(T t, long j) {
        return ((Long) zzfv.zzp(t, j)).longValue();
    }

    private static <T> boolean zzj(T t, long j) {
        return ((Boolean) zzfv.zzp(t, j)).booleanValue();
    }

    /* JADX WARN: Removed duplicated region for block: B:103:0x01a2  */
    @Override // com.google.android.gms.internal.firebase_auth.zzev
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final boolean equals(T r10, T r11) {
        /*
            Method dump skipped, instruction units count: 610
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.firebase_auth.zzel.equals(java.lang.Object, java.lang.Object):boolean");
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Removed duplicated region for block: B:68:0x00e2 A[PHI: r3
      0x00e2: PHI (r3v13 java.lang.Object) = (r3v11 java.lang.Object), (r3v14 java.lang.Object) binds: [B:67:0x00e0, B:62:0x00ce] A[DONT_GENERATE, DONT_INLINE]] */
    @Override // com.google.android.gms.internal.firebase_auth.zzev
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final int hashCode(T r9) {
        /*
            Method dump skipped, instruction units count: 476
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.firebase_auth.zzel.hashCode(java.lang.Object):int");
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzev
    public final T newInstance() {
        return (T) this.zztw.newInstance(this.zzto);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference incomplete: some casts might be missing */
    @Override // com.google.android.gms.internal.firebase_auth.zzev
    public final void zza(T t, zzeu zzeuVar, zzco zzcoVar) {
        int i;
        long j;
        Object objZza;
        int iZzcm;
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
        zzdf<?> zzdfVarZzap;
        List<Integer> listZza11;
        List<Long> listZza12;
        List<Integer> listZza13;
        List<Long> listZza14;
        Object objZza2;
        if (zzcoVar == null) {
            throw new NullPointerException();
        }
        zzfp<?, ?> zzfpVar = this.zzty;
        zzcp<?> zzcpVar = this.zztz;
        zzcs zzcsVarZzd = null;
        Object objZza3 = null;
        while (true) {
            try {
                int iZzda = zzeuVar.zzda();
                if (iZzda < this.zztm || iZzda > this.zztn) {
                    i = -1;
                } else {
                    int i2 = 0;
                    int length = (this.zztk.length / 3) - 1;
                    while (i2 <= length) {
                        int i3 = (length + i2) >>> 1;
                        i = i3 * 3;
                        int i4 = this.zztk[i];
                        if (iZzda != i4) {
                            if (iZzda < i4) {
                                length = i3 - 1;
                            } else {
                                i2 = i3 + 1;
                            }
                        }
                    }
                    i = -1;
                }
                if (i >= 0) {
                    int iZzaq = zzaq(i);
                    switch ((267386880 & iZzaq) >>> 20) {
                        case 0:
                            zzfv.zza(t, iZzaq & 1048575, zzeuVar.readDouble());
                            zzb(t, i);
                            break;
                        case 1:
                            zzfv.zza((Object) t, iZzaq & 1048575, zzeuVar.readFloat());
                            zzb(t, i);
                            break;
                        case 2:
                            zzfv.zza((Object) t, iZzaq & 1048575, zzeuVar.zzce());
                            zzb(t, i);
                            break;
                        case 3:
                            zzfv.zza((Object) t, iZzaq & 1048575, zzeuVar.zzcd());
                            zzb(t, i);
                            break;
                        case 4:
                            zzfv.zzb(t, iZzaq & 1048575, zzeuVar.zzcf());
                            zzb(t, i);
                            break;
                        case 5:
                            zzfv.zza((Object) t, iZzaq & 1048575, zzeuVar.zzcg());
                            zzb(t, i);
                            break;
                        case 6:
                            zzfv.zzb(t, iZzaq & 1048575, zzeuVar.zzch());
                            zzb(t, i);
                            break;
                        case 7:
                            zzfv.zza(t, iZzaq & 1048575, zzeuVar.zzci());
                            zzb(t, i);
                            break;
                        case 8:
                            zza(t, iZzaq, zzeuVar);
                            zzb(t, i);
                            break;
                        case 9:
                            if (zza(t, i)) {
                                j = iZzaq & 1048575;
                                objZza = zzdd.zza(zzfv.zzp(t, j), zzeuVar.zza(zzan(i), zzcoVar));
                                zzfv.zza(t, j, objZza);
                            } else {
                                zzfv.zza(t, iZzaq & 1048575, zzeuVar.zza(zzan(i), zzcoVar));
                                zzb(t, i);
                            }
                            break;
                        case 10:
                            zzfv.zza(t, iZzaq & 1048575, zzeuVar.zzck());
                            zzb(t, i);
                            break;
                        case 11:
                            zzfv.zzb(t, iZzaq & 1048575, zzeuVar.zzcl());
                            zzb(t, i);
                            break;
                        case 12:
                            iZzcm = zzeuVar.zzcm();
                            zzdf<?> zzdfVarZzap2 = zzap(i);
                            if (zzdfVarZzap2 == null || zzdfVarZzap2.zzam(iZzcm) != null) {
                                zzfv.zzb(t, iZzaq & 1048575, iZzcm);
                                zzb(t, i);
                            } else {
                                objZza2 = zzex.zza(iZzda, iZzcm, objZza3, (zzfp<UT, Object>) zzfpVar);
                                objZza3 = objZza2;
                            }
                            break;
                        case 13:
                            zzfv.zzb(t, iZzaq & 1048575, zzeuVar.zzcn());
                            zzb(t, i);
                            break;
                        case 14:
                            zzfv.zza((Object) t, iZzaq & 1048575, zzeuVar.zzco());
                            zzb(t, i);
                            break;
                        case 15:
                            zzfv.zzb(t, iZzaq & 1048575, zzeuVar.zzcp());
                            zzb(t, i);
                            break;
                        case 16:
                            zzfv.zza((Object) t, iZzaq & 1048575, zzeuVar.zzcq());
                            zzb(t, i);
                            break;
                        case 17:
                            if (zza(t, i)) {
                                j = iZzaq & 1048575;
                                objZza = zzdd.zza(zzfv.zzp(t, j), zzeuVar.zzb(zzan(i), zzcoVar));
                                zzfv.zza(t, j, objZza);
                            } else {
                                zzfv.zza(t, iZzaq & 1048575, zzeuVar.zzb(zzan(i), zzcoVar));
                                zzb(t, i);
                            }
                            break;
                        case 18:
                            listZza = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzc(listZza);
                            break;
                        case 19:
                            listZza2 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzd(listZza2);
                            break;
                        case 20:
                            listZza3 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzf(listZza3);
                            break;
                        case 21:
                            listZza4 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zze(listZza4);
                            break;
                        case 22:
                            listZza5 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzg(listZza5);
                            break;
                        case 23:
                            listZza6 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzh(listZza6);
                            break;
                        case 24:
                            listZza7 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzi(listZza7);
                            break;
                        case 25:
                            listZza8 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzj(listZza8);
                            break;
                        case 26:
                            if (zzas(iZzaq)) {
                                zzeuVar.zzk(this.zztx.zza(t, iZzaq & 1048575));
                            } else {
                                zzeuVar.readStringList(this.zztx.zza(t, iZzaq & 1048575));
                            }
                            break;
                        case 27:
                            zzeuVar.zza(this.zztx.zza(t, iZzaq & 1048575), zzan(i), zzcoVar);
                            break;
                        case 28:
                            zzeuVar.zzl(this.zztx.zza(t, iZzaq & 1048575));
                            break;
                        case 29:
                            listZza9 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzm(listZza9);
                            break;
                        case 30:
                            listZza10 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzn(listZza10);
                            zzdfVarZzap = zzap(i);
                            objZza2 = zzex.zza(iZzda, listZza10, zzdfVarZzap, objZza3, zzfpVar);
                            objZza3 = objZza2;
                            break;
                        case 31:
                            listZza11 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzo(listZza11);
                            break;
                        case 32:
                            listZza12 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzp(listZza12);
                            break;
                        case 33:
                            listZza13 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzq(listZza13);
                            break;
                        case 34:
                            listZza14 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzr(listZza14);
                            break;
                        case 35:
                            listZza = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzc(listZza);
                            break;
                        case 36:
                            listZza2 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzd(listZza2);
                            break;
                        case 37:
                            listZza3 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzf(listZza3);
                            break;
                        case 38:
                            listZza4 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zze(listZza4);
                            break;
                        case 39:
                            listZza5 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzg(listZza5);
                            break;
                        case 40:
                            listZza6 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzh(listZza6);
                            break;
                        case 41:
                            listZza7 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzi(listZza7);
                            break;
                        case 42:
                            listZza8 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzj(listZza8);
                            break;
                        case 43:
                            listZza9 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzm(listZza9);
                            break;
                        case 44:
                            listZza10 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzn(listZza10);
                            zzdfVarZzap = zzap(i);
                            objZza2 = zzex.zza(iZzda, listZza10, zzdfVarZzap, objZza3, zzfpVar);
                            objZza3 = objZza2;
                            break;
                        case 45:
                            listZza11 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzo(listZza11);
                            break;
                        case 46:
                            listZza12 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzp(listZza12);
                            break;
                        case 47:
                            listZza13 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzq(listZza13);
                            break;
                        case 48:
                            listZza14 = this.zztx.zza(t, iZzaq & 1048575);
                            zzeuVar.zzr(listZza14);
                            break;
                        case 49:
                            zzeuVar.zzb(this.zztx.zza(t, iZzaq & 1048575), zzan(i), zzcoVar);
                            break;
                        case 50:
                            Object objZzao = zzao(i);
                            long jZzaq = zzaq(i) & 1048575;
                            Object objZzp = zzfv.zzp(t, jZzaq);
                            if (objZzp == null) {
                                objZzp = this.zzua.zzm(objZzao);
                                zzfv.zza(t, jZzaq, objZzp);
                            } else if (this.zzua.zzk(objZzp)) {
                                Object objZzm = this.zzua.zzm(objZzao);
                                this.zzua.zzb(objZzm, objZzp);
                                zzfv.zza(t, jZzaq, objZzm);
                                objZzp = objZzm;
                            }
                            zzeuVar.zza(this.zzua.zzi(objZzp), this.zzua.zzn(objZzao), zzcoVar);
                            break;
                        case 51:
                            zzfv.zza(t, iZzaq & 1048575, Double.valueOf(zzeuVar.readDouble()));
                            zzb(t, iZzda, i);
                            break;
                        case 52:
                            zzfv.zza(t, iZzaq & 1048575, Float.valueOf(zzeuVar.readFloat()));
                            zzb(t, iZzda, i);
                            break;
                        case 53:
                            zzfv.zza(t, iZzaq & 1048575, Long.valueOf(zzeuVar.zzce()));
                            zzb(t, iZzda, i);
                            break;
                        case 54:
                            zzfv.zza(t, iZzaq & 1048575, Long.valueOf(zzeuVar.zzcd()));
                            zzb(t, iZzda, i);
                            break;
                        case 55:
                            zzfv.zza(t, iZzaq & 1048575, Integer.valueOf(zzeuVar.zzcf()));
                            zzb(t, iZzda, i);
                            break;
                        case 56:
                            zzfv.zza(t, iZzaq & 1048575, Long.valueOf(zzeuVar.zzcg()));
                            zzb(t, iZzda, i);
                            break;
                        case 57:
                            zzfv.zza(t, iZzaq & 1048575, Integer.valueOf(zzeuVar.zzch()));
                            zzb(t, iZzda, i);
                            break;
                        case 58:
                            zzfv.zza(t, iZzaq & 1048575, Boolean.valueOf(zzeuVar.zzci()));
                            zzb(t, iZzda, i);
                            break;
                        case 59:
                            zza(t, iZzaq, zzeuVar);
                            zzb(t, iZzda, i);
                            break;
                        case 60:
                            if (zza(t, iZzda, i)) {
                                long j2 = iZzaq & 1048575;
                                zzfv.zza(t, j2, zzdd.zza(zzfv.zzp(t, j2), zzeuVar.zza(zzan(i), zzcoVar)));
                            } else {
                                zzfv.zza(t, iZzaq & 1048575, zzeuVar.zza(zzan(i), zzcoVar));
                                zzb(t, i);
                            }
                            zzb(t, iZzda, i);
                            break;
                        case 61:
                            zzfv.zza(t, iZzaq & 1048575, zzeuVar.zzck());
                            zzb(t, iZzda, i);
                            break;
                        case 62:
                            zzfv.zza(t, iZzaq & 1048575, Integer.valueOf(zzeuVar.zzcl()));
                            zzb(t, iZzda, i);
                            break;
                        case 63:
                            iZzcm = zzeuVar.zzcm();
                            zzdf<?> zzdfVarZzap3 = zzap(i);
                            if (zzdfVarZzap3 != null && zzdfVarZzap3.zzam(iZzcm) == null) {
                                objZza2 = zzex.zza(iZzda, iZzcm, objZza3, (zzfp<UT, Object>) zzfpVar);
                                objZza3 = objZza2;
                            }
                            zzfv.zza(t, iZzaq & 1048575, Integer.valueOf(iZzcm));
                            zzb(t, iZzda, i);
                            break;
                        case 64:
                            zzfv.zza(t, iZzaq & 1048575, Integer.valueOf(zzeuVar.zzcn()));
                            zzb(t, iZzda, i);
                            break;
                        case 65:
                            zzfv.zza(t, iZzaq & 1048575, Long.valueOf(zzeuVar.zzco()));
                            zzb(t, iZzda, i);
                            break;
                        case 66:
                            zzfv.zza(t, iZzaq & 1048575, Integer.valueOf(zzeuVar.zzcp()));
                            zzb(t, iZzda, i);
                            break;
                        case 67:
                            zzfv.zza(t, iZzaq & 1048575, Long.valueOf(zzeuVar.zzcq()));
                            zzb(t, iZzda, i);
                            break;
                        case 68:
                            zzfv.zza(t, iZzaq & 1048575, zzeuVar.zzb(zzan(i), zzcoVar));
                            zzb(t, iZzda, i);
                            break;
                        default:
                            if (objZza3 == null) {
                                try {
                                    objZza3 = zzfpVar.zzfy();
                                } catch (zzdi unused) {
                                    zzfpVar.zza(zzeuVar);
                                    if (objZza3 == null) {
                                        objZza3 = zzfpVar.zzs(t);
                                    }
                                    if (!zzfpVar.zza((Object) objZza3, zzeuVar)) {
                                        for (int i5 = this.zztu; i5 < this.zztv; i5++) {
                                            objZza3 = zza((Object) t, this.zztt[i5], objZza3, (zzfp<UT, Object>) zzfpVar);
                                        }
                                        if (objZza3 != null) {
                                            zzfpVar.zzf(t, (Object) objZza3);
                                            return;
                                        }
                                        return;
                                    }
                                }
                                break;
                            }
                            if (!zzfpVar.zza((Object) objZza3, zzeuVar)) {
                                for (int i6 = this.zztu; i6 < this.zztv; i6++) {
                                    objZza3 = zza((Object) t, this.zztt[i6], objZza3, (zzfp<UT, Object>) zzfpVar);
                                }
                                if (objZza3 != null) {
                                    zzfpVar.zzf(t, (Object) objZza3);
                                    return;
                                }
                                return;
                            }
                            break;
                            break;
                    }
                } else {
                    if (iZzda == Integer.MAX_VALUE) {
                        for (int i7 = this.zztu; i7 < this.zztv; i7++) {
                            objZza3 = zza((Object) t, this.zztt[i7], objZza3, (zzfp<UT, Object>) zzfpVar);
                        }
                        if (objZza3 != null) {
                            zzfpVar.zzf(t, (Object) objZza3);
                            return;
                        }
                        return;
                    }
                    Object objZza4 = !this.zztp ? null : zzcpVar.zza(zzcoVar, this.zzto, iZzda);
                    if (objZza4 != null) {
                        if (zzcsVarZzd == null) {
                            zzcsVarZzd = zzcpVar.zzd(t);
                        }
                        zzcs zzcsVar = zzcsVarZzd;
                        objZza3 = zzcpVar.zza(zzeuVar, objZza4, zzcoVar, zzcsVar, objZza3, zzfpVar);
                        zzcsVarZzd = zzcsVar;
                    } else {
                        zzfpVar.zza(zzeuVar);
                        if (objZza3 == null) {
                            objZza3 = zzfpVar.zzs(t);
                        }
                        if (!zzfpVar.zza((Object) objZza3, zzeuVar)) {
                            for (int i8 = this.zztu; i8 < this.zztv; i8++) {
                                objZza3 = zza((Object) t, this.zztt[i8], objZza3, (zzfp<UT, Object>) zzfpVar);
                            }
                            if (objZza3 != null) {
                                zzfpVar.zzf(t, (Object) objZza3);
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
    @Override // com.google.android.gms.internal.firebase_auth.zzev
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final void zza(T r14, com.google.android.gms.internal.firebase_auth.zzgj r15) {
        /*
            Method dump skipped, instruction units count: 2738
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.firebase_auth.zzel.zza(java.lang.Object, com.google.android.gms.internal.firebase_auth.zzgj):void");
    }

    /* JADX WARN: Removed duplicated region for block: B:17:0x0037  */
    @Override // com.google.android.gms.internal.firebase_auth.zzev
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final void zzc(T r7, T r8) {
        /*
            Method dump skipped, instruction units count: 410
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.firebase_auth.zzel.zzc(java.lang.Object, java.lang.Object):void");
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzev
    public final void zze(T t) {
        for (int i = this.zztu; i < this.zztv; i++) {
            long jZzaq = zzaq(this.zztt[i]) & 1048575;
            Object objZzp = zzfv.zzp(t, jZzaq);
            if (objZzp != null) {
                zzfv.zza(t, jZzaq, this.zzua.zzl(objZzp));
            }
        }
        int length = this.zztt.length;
        for (int i2 = this.zztv; i2 < length; i2++) {
            this.zztx.zzb(t, this.zztt[i2]);
        }
        this.zzty.zze(t);
        if (this.zztp) {
            this.zztz.zze(t);
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
    
        r6 = com.google.android.gms.internal.firebase_auth.zzci.zzc(r14, (com.google.android.gms.internal.firebase_auth.zzeh) r2.getObject(r22, r9), zzan(r3));
     */
    /* JADX WARN: Code restructure failed: missing block: B:403:0x06e5, code lost:
    
        if ((r12 & r16) != 0) goto L404;
     */
    /* JADX WARN: Code restructure failed: missing block: B:404:0x06e7, code lost:
    
        r6 = com.google.android.gms.internal.firebase_auth.zzci.zzh(r14, 0L);
     */
    /* JADX WARN: Code restructure failed: missing block: B:406:0x06f0, code lost:
    
        if ((r12 & r16) != 0) goto L407;
     */
    /* JADX WARN: Code restructure failed: missing block: B:407:0x06f2, code lost:
    
        r9 = com.google.android.gms.internal.firebase_auth.zzci.zzk(r14, 0);
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
    
        r6 = com.google.android.gms.internal.firebase_auth.zzex.zzc(r14, r2.getObject(r22, r9), zzan(r3));
     */
    /* JADX WARN: Code restructure failed: missing block: B:431:0x074b, code lost:
    
        if ((r12 & r16) != 0) goto L432;
     */
    /* JADX WARN: Code restructure failed: missing block: B:432:0x074d, code lost:
    
        r6 = com.google.android.gms.internal.firebase_auth.zzci.zzc(r14, true);
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
    @Override // com.google.android.gms.internal.firebase_auth.zzev
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final int zzo(T r22) {
        /*
            Method dump skipped, instruction units count: 2298
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.firebase_auth.zzel.zzo(java.lang.Object):int");
    }

    /* JADX WARN: Code restructure failed: missing block: B:86:0x0104, code lost:
    
        continue;
     */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:51:0x00c7  */
    /* JADX WARN: Type inference failed for: r4v12 */
    /* JADX WARN: Type inference failed for: r4v13 */
    /* JADX WARN: Type inference failed for: r4v14, types: [com.google.android.gms.internal.firebase_auth.zzev] */
    /* JADX WARN: Type inference failed for: r4v17 */
    /* JADX WARN: Type inference failed for: r4v18 */
    /* JADX WARN: Type inference failed for: r4v5, types: [com.google.android.gms.internal.firebase_auth.zzev] */
    @Override // com.google.android.gms.internal.firebase_auth.zzev
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final boolean zzp(T r14) {
        /*
            Method dump skipped, instruction units count: 290
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.firebase_auth.zzel.zzp(java.lang.Object):boolean");
    }
}
