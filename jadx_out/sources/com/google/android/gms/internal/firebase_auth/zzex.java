package com.google.android.gms.internal.firebase_auth;

import java.util.Iterator;
import java.util.List;
import java.util.RandomAccess;

/* JADX INFO: loaded from: classes2.dex */
final class zzex {
    private static final Class<?> zzug = zzfm();
    private static final zzfp<?, ?> zzuh = zzi(false);
    private static final zzfp<?, ?> zzui = zzi(true);
    private static final zzfp<?, ?> zzuj = new zzfr();

    static <UT, UB> UB zza(int i, int i2, UB ub, zzfp<UT, UB> zzfpVar) {
        if (ub == null) {
            ub = zzfpVar.zzfy();
        }
        zzfpVar.zza(ub, i, i2);
        return ub;
    }

    static <UT, UB> UB zza(int i, List<Integer> list, zzdf<?> zzdfVar, UB ub, zzfp<UT, UB> zzfpVar) {
        UB ub2;
        int iIntValue;
        if (zzdfVar == null) {
            return ub;
        }
        if (list instanceof RandomAccess) {
            int size = list.size();
            ub2 = ub;
            int i2 = 0;
            for (int i3 = 0; i3 < size; i3++) {
                int iIntValue2 = list.get(i3).intValue();
                if (zzdfVar.zzam(iIntValue2) != null) {
                    if (i3 != i2) {
                        list.set(i2, Integer.valueOf(iIntValue2));
                    }
                    i2++;
                } else {
                    ub2 = (UB) zza(i, iIntValue2, ub2, zzfpVar);
                }
            }
            if (i2 != size) {
                list.subList(i2, size).clear();
                return ub2;
            }
        } else {
            Iterator<Integer> it2 = list.iterator();
            loop1: while (true) {
                ub2 = ub;
                while (it2.hasNext()) {
                    iIntValue = it2.next().intValue();
                    if (zzdfVar.zzam(iIntValue) == null) {
                        break;
                    }
                }
                ub = (UB) zza(i, iIntValue, ub2, zzfpVar);
                it2.remove();
            }
        }
        return ub2;
    }

    public static void zza(int i, List<String> list, zzgj zzgjVar) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zza(i, list);
    }

    public static void zza(int i, List<?> list, zzgj zzgjVar, zzev zzevVar) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zza(i, list, zzevVar);
    }

    public static void zza(int i, List<Double> list, zzgj zzgjVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zzg(i, list, z);
    }

    /* JADX WARN: Multi-variable type inference failed */
    static <T, FT extends zzcu<FT>> void zza(zzcp<FT> zzcpVar, T t, T t2) {
        zzcs<T> zzcsVarZzc = zzcpVar.zzc(t2);
        if (zzcsVarZzc.isEmpty()) {
            return;
        }
        zzcpVar.zzd(t).zza(zzcsVarZzc);
    }

    static <T> void zza(zzec zzecVar, T t, T t2, long j) {
        zzfv.zza(t, j, zzecVar.zzb(zzfv.zzp(t, j), zzfv.zzp(t2, j)));
    }

    static <T, UT, UB> void zza(zzfp<UT, UB> zzfpVar, T t, T t2) {
        zzfpVar.zze(t, zzfpVar.zzg(zzfpVar.zzr(t), zzfpVar.zzr(t2)));
    }

    static int zzaa(List<?> list) {
        return list.size() << 3;
    }

    static int zzab(List<?> list) {
        return list.size();
    }

    public static void zzb(int i, List<zzbu> list, zzgj zzgjVar) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zzb(i, list);
    }

    public static void zzb(int i, List<?> list, zzgj zzgjVar, zzev zzevVar) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zzb(i, list, zzevVar);
    }

    public static void zzb(int i, List<Float> list, zzgj zzgjVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zzf(i, list, z);
    }

    static int zzc(int i, Object obj, zzev zzevVar) {
        return obj instanceof zzdo ? zzci.zza(i, (zzdo) obj) : zzci.zzb(i, (zzeh) obj, zzevVar);
    }

    static int zzc(int i, List<?> list) {
        int size = list.size();
        int i2 = 0;
        if (size == 0) {
            return 0;
        }
        int iZzaa = zzci.zzaa(i) * size;
        if (list instanceof zzdq) {
            zzdq zzdqVar = (zzdq) list;
            while (i2 < size) {
                Object raw = zzdqVar.getRaw(i2);
                iZzaa += raw instanceof zzbu ? zzci.zzb((zzbu) raw) : zzci.zzam((String) raw);
                i2++;
            }
        } else {
            while (i2 < size) {
                Object obj = list.get(i2);
                iZzaa += obj instanceof zzbu ? zzci.zzb((zzbu) obj) : zzci.zzam((String) obj);
                i2++;
            }
        }
        return iZzaa;
    }

    static int zzc(int i, List<?> list, zzev zzevVar) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        int iZzaa = zzci.zzaa(i) * size;
        for (int i2 = 0; i2 < size; i2++) {
            Object obj = list.get(i2);
            iZzaa += obj instanceof zzdo ? zzci.zza((zzdo) obj) : zzci.zzb((zzeh) obj, zzevVar);
        }
        return iZzaa;
    }

    public static void zzc(int i, List<Long> list, zzgj zzgjVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zzc(i, list, z);
    }

    static int zzd(int i, List<zzbu> list) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        int iZzaa = size * zzci.zzaa(i);
        for (int i2 = 0; i2 < list.size(); i2++) {
            iZzaa += zzci.zzb(list.get(i2));
        }
        return iZzaa;
    }

    static int zzd(int i, List<zzeh> list, zzev zzevVar) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        int iZzc = 0;
        for (int i2 = 0; i2 < size; i2++) {
            iZzc += zzci.zzc(i, list.get(i2), zzevVar);
        }
        return iZzc;
    }

    public static void zzd(int i, List<Long> list, zzgj zzgjVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zzd(i, list, z);
    }

    static boolean zzd(Object obj, Object obj2) {
        if (obj != obj2) {
            return obj != null && obj.equals(obj2);
        }
        return true;
    }

    public static void zze(int i, List<Long> list, zzgj zzgjVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zzn(i, list, z);
    }

    public static void zzf(int i, List<Long> list, zzgj zzgjVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zze(i, list, z);
    }

    public static zzfp<?, ?> zzfj() {
        return zzuh;
    }

    public static zzfp<?, ?> zzfk() {
        return zzui;
    }

    public static zzfp<?, ?> zzfl() {
        return zzuj;
    }

    private static Class<?> zzfm() {
        try {
            return Class.forName("com.google.protobuf.GeneratedMessage");
        } catch (Throwable unused) {
            return null;
        }
    }

    private static Class<?> zzfn() {
        try {
            return Class.forName("com.google.protobuf.UnknownFieldSetSchema");
        } catch (Throwable unused) {
            return null;
        }
    }

    public static void zzg(int i, List<Long> list, zzgj zzgjVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zzl(i, list, z);
    }

    public static void zzg(Class<?> cls) {
        if (!zzdb.class.isAssignableFrom(cls) && zzug != null && !zzug.isAssignableFrom(cls)) {
            throw new IllegalArgumentException("Message classes must extend GeneratedMessage or GeneratedMessageLite");
        }
    }

    public static void zzh(int i, List<Integer> list, zzgj zzgjVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zza(i, list, z);
    }

    private static zzfp<?, ?> zzi(boolean z) {
        try {
            Class<?> clsZzfn = zzfn();
            if (clsZzfn == null) {
                return null;
            }
            return (zzfp) clsZzfn.getConstructor(Boolean.TYPE).newInstance(Boolean.valueOf(z));
        } catch (Throwable unused) {
            return null;
        }
    }

    public static void zzi(int i, List<Integer> list, zzgj zzgjVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zzj(i, list, z);
    }

    public static void zzj(int i, List<Integer> list, zzgj zzgjVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zzm(i, list, z);
    }

    public static void zzk(int i, List<Integer> list, zzgj zzgjVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zzb(i, list, z);
    }

    public static void zzl(int i, List<Integer> list, zzgj zzgjVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zzk(i, list, z);
    }

    public static void zzm(int i, List<Integer> list, zzgj zzgjVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zzh(i, list, z);
    }

    public static void zzn(int i, List<Boolean> list, zzgj zzgjVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzgjVar.zzi(i, list, z);
    }

    static int zzo(int i, List<Long> list, boolean z) {
        if (list.size() == 0) {
            return 0;
        }
        return zzs(list) + (list.size() * zzci.zzaa(i));
    }

    static int zzp(int i, List<Long> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return zzt(list) + (size * zzci.zzaa(i));
    }

    static int zzq(int i, List<Long> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return zzu(list) + (size * zzci.zzaa(i));
    }

    static int zzr(int i, List<Integer> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return zzv(list) + (size * zzci.zzaa(i));
    }

    static int zzs(int i, List<Integer> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return zzw(list) + (size * zzci.zzaa(i));
    }

    static int zzs(List<Long> list) {
        int iZzd;
        int size = list.size();
        int i = 0;
        if (size == 0) {
            return 0;
        }
        if (list instanceof zzdv) {
            zzdv zzdvVar = (zzdv) list;
            iZzd = 0;
            while (i < size) {
                iZzd += zzci.zzd(zzdvVar.getLong(i));
                i++;
            }
        } else {
            iZzd = 0;
            while (i < size) {
                iZzd += zzci.zzd(list.get(i).longValue());
                i++;
            }
        }
        return iZzd;
    }

    static int zzt(int i, List<Integer> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return zzx(list) + (size * zzci.zzaa(i));
    }

    static int zzt(List<Long> list) {
        int iZze;
        int size = list.size();
        int i = 0;
        if (size == 0) {
            return 0;
        }
        if (list instanceof zzdv) {
            zzdv zzdvVar = (zzdv) list;
            iZze = 0;
            while (i < size) {
                iZze += zzci.zze(zzdvVar.getLong(i));
                i++;
            }
        } else {
            iZze = 0;
            while (i < size) {
                iZze += zzci.zze(list.get(i).longValue());
                i++;
            }
        }
        return iZze;
    }

    static int zzu(int i, List<Integer> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return zzy(list) + (size * zzci.zzaa(i));
    }

    static int zzu(List<Long> list) {
        int iZzf;
        int size = list.size();
        int i = 0;
        if (size == 0) {
            return 0;
        }
        if (list instanceof zzdv) {
            zzdv zzdvVar = (zzdv) list;
            iZzf = 0;
            while (i < size) {
                iZzf += zzci.zzf(zzdvVar.getLong(i));
                i++;
            }
        } else {
            iZzf = 0;
            while (i < size) {
                iZzf += zzci.zzf(list.get(i).longValue());
                i++;
            }
        }
        return iZzf;
    }

    static int zzv(int i, List<?> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return size * zzci.zzj(i, 0);
    }

    static int zzv(List<Integer> list) {
        int iZzag;
        int size = list.size();
        int i = 0;
        if (size == 0) {
            return 0;
        }
        if (list instanceof zzdc) {
            zzdc zzdcVar = (zzdc) list;
            iZzag = 0;
            while (i < size) {
                iZzag += zzci.zzag(zzdcVar.getInt(i));
                i++;
            }
        } else {
            iZzag = 0;
            while (i < size) {
                iZzag += zzci.zzag(list.get(i).intValue());
                i++;
            }
        }
        return iZzag;
    }

    static int zzw(int i, List<?> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return size * zzci.zzg(i, 0L);
    }

    static int zzw(List<Integer> list) {
        int iZzab;
        int size = list.size();
        int i = 0;
        if (size == 0) {
            return 0;
        }
        if (list instanceof zzdc) {
            zzdc zzdcVar = (zzdc) list;
            iZzab = 0;
            while (i < size) {
                iZzab += zzci.zzab(zzdcVar.getInt(i));
                i++;
            }
        } else {
            iZzab = 0;
            while (i < size) {
                iZzab += zzci.zzab(list.get(i).intValue());
                i++;
            }
        }
        return iZzab;
    }

    static int zzx(int i, List<?> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return size * zzci.zzc(i, true);
    }

    static int zzx(List<Integer> list) {
        int iZzac;
        int size = list.size();
        int i = 0;
        if (size == 0) {
            return 0;
        }
        if (list instanceof zzdc) {
            zzdc zzdcVar = (zzdc) list;
            iZzac = 0;
            while (i < size) {
                iZzac += zzci.zzac(zzdcVar.getInt(i));
                i++;
            }
        } else {
            iZzac = 0;
            while (i < size) {
                iZzac += zzci.zzac(list.get(i).intValue());
                i++;
            }
        }
        return iZzac;
    }

    static int zzy(List<Integer> list) {
        int iZzad;
        int size = list.size();
        int i = 0;
        if (size == 0) {
            return 0;
        }
        if (list instanceof zzdc) {
            zzdc zzdcVar = (zzdc) list;
            iZzad = 0;
            while (i < size) {
                iZzad += zzci.zzad(zzdcVar.getInt(i));
                i++;
            }
        } else {
            iZzad = 0;
            while (i < size) {
                iZzad += zzci.zzad(list.get(i).intValue());
                i++;
            }
        }
        return iZzad;
    }

    static int zzz(List<?> list) {
        return list.size() << 2;
    }
}
