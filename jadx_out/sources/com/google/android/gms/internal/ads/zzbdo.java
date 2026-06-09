package com.google.android.gms.internal.ads;

import java.util.Iterator;
import java.util.List;
import java.util.RandomAccess;

/* JADX INFO: loaded from: classes.dex */
final class zzbdo {
    private static final Class<?> zzdyf = zzafq();
    private static final zzbee<?, ?> zzdyg = zzas(false);
    private static final zzbee<?, ?> zzdyh = zzas(true);
    private static final zzbee<?, ?> zzdyi = new zzbeg();

    static <UT, UB> UB zza(int i, int i2, UB ub, zzbee<UT, UB> zzbeeVar) {
        if (ub == null) {
            ub = zzbeeVar.zzagb();
        }
        zzbeeVar.zza(ub, i, i2);
        return ub;
    }

    static <UT, UB> UB zza(int i, List<Integer> list, zzbbs<?> zzbbsVar, UB ub, zzbee<UT, UB> zzbeeVar) {
        UB ub2;
        int iIntValue;
        if (zzbbsVar == null) {
            return ub;
        }
        if (list instanceof RandomAccess) {
            int size = list.size();
            ub2 = ub;
            int i2 = 0;
            for (int i3 = 0; i3 < size; i3++) {
                int iIntValue2 = list.get(i3).intValue();
                if (zzbbsVar.zzq(iIntValue2) != null) {
                    if (i3 != i2) {
                        list.set(i2, Integer.valueOf(iIntValue2));
                    }
                    i2++;
                } else {
                    ub2 = (UB) zza(i, iIntValue2, ub2, zzbeeVar);
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
                    if (zzbbsVar.zzq(iIntValue) == null) {
                        break;
                    }
                }
                ub = (UB) zza(i, iIntValue, ub2, zzbeeVar);
                it2.remove();
            }
        }
        return ub2;
    }

    public static void zza(int i, List<String> list, zzbey zzbeyVar) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zza(i, list);
    }

    public static void zza(int i, List<?> list, zzbey zzbeyVar, zzbdm zzbdmVar) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zza(i, list, zzbdmVar);
    }

    public static void zza(int i, List<Double> list, zzbey zzbeyVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zzg(i, list, z);
    }

    /* JADX WARN: Multi-variable type inference failed */
    static <T, FT extends zzbbi<FT>> void zza(zzbbd<FT> zzbbdVar, T t, T t2) {
        zzbbg<T> zzbbgVarZzm = zzbbdVar.zzm(t2);
        if (zzbbgVarZzm.isEmpty()) {
            return;
        }
        zzbbdVar.zzn(t).zza(zzbbgVarZzm);
    }

    static <T> void zza(zzbcp zzbcpVar, T t, T t2, long j) {
        zzbek.zza(t, j, zzbcpVar.zzb(zzbek.zzp(t, j), zzbek.zzp(t2, j)));
    }

    static <T, UT, UB> void zza(zzbee<UT, UB> zzbeeVar, T t, T t2) {
        zzbeeVar.zze(t, zzbeeVar.zzg(zzbeeVar.zzac(t), zzbeeVar.zzac(t2)));
    }

    static int zzaf(List<Long> list) {
        int iZzp;
        int size = list.size();
        int i = 0;
        if (size == 0) {
            return 0;
        }
        if (list instanceof zzbci) {
            zzbci zzbciVar = (zzbci) list;
            iZzp = 0;
            while (i < size) {
                iZzp += zzbav.zzp(zzbciVar.getLong(i));
                i++;
            }
        } else {
            iZzp = 0;
            while (i < size) {
                iZzp += zzbav.zzp(list.get(i).longValue());
                i++;
            }
        }
        return iZzp;
    }

    public static zzbee<?, ?> zzafn() {
        return zzdyg;
    }

    public static zzbee<?, ?> zzafo() {
        return zzdyh;
    }

    public static zzbee<?, ?> zzafp() {
        return zzdyi;
    }

    private static Class<?> zzafq() {
        try {
            return Class.forName("com.google.protobuf.GeneratedMessage");
        } catch (Throwable unused) {
            return null;
        }
    }

    private static Class<?> zzafr() {
        try {
            return Class.forName("com.google.protobuf.UnknownFieldSetSchema");
        } catch (Throwable unused) {
            return null;
        }
    }

    static int zzag(List<Long> list) {
        int iZzq;
        int size = list.size();
        int i = 0;
        if (size == 0) {
            return 0;
        }
        if (list instanceof zzbci) {
            zzbci zzbciVar = (zzbci) list;
            iZzq = 0;
            while (i < size) {
                iZzq += zzbav.zzq(zzbciVar.getLong(i));
                i++;
            }
        } else {
            iZzq = 0;
            while (i < size) {
                iZzq += zzbav.zzq(list.get(i).longValue());
                i++;
            }
        }
        return iZzq;
    }

    static int zzah(List<Long> list) {
        int iZzr;
        int size = list.size();
        int i = 0;
        if (size == 0) {
            return 0;
        }
        if (list instanceof zzbci) {
            zzbci zzbciVar = (zzbci) list;
            iZzr = 0;
            while (i < size) {
                iZzr += zzbav.zzr(zzbciVar.getLong(i));
                i++;
            }
        } else {
            iZzr = 0;
            while (i < size) {
                iZzr += zzbav.zzr(list.get(i).longValue());
                i++;
            }
        }
        return iZzr;
    }

    static int zzai(List<Integer> list) {
        int iZzcj;
        int size = list.size();
        int i = 0;
        if (size == 0) {
            return 0;
        }
        if (list instanceof zzbbp) {
            zzbbp zzbbpVar = (zzbbp) list;
            iZzcj = 0;
            while (i < size) {
                iZzcj += zzbav.zzcj(zzbbpVar.getInt(i));
                i++;
            }
        } else {
            iZzcj = 0;
            while (i < size) {
                iZzcj += zzbav.zzcj(list.get(i).intValue());
                i++;
            }
        }
        return iZzcj;
    }

    static int zzaj(List<Integer> list) {
        int iZzce;
        int size = list.size();
        int i = 0;
        if (size == 0) {
            return 0;
        }
        if (list instanceof zzbbp) {
            zzbbp zzbbpVar = (zzbbp) list;
            iZzce = 0;
            while (i < size) {
                iZzce += zzbav.zzce(zzbbpVar.getInt(i));
                i++;
            }
        } else {
            iZzce = 0;
            while (i < size) {
                iZzce += zzbav.zzce(list.get(i).intValue());
                i++;
            }
        }
        return iZzce;
    }

    static int zzak(List<Integer> list) {
        int iZzcf;
        int size = list.size();
        int i = 0;
        if (size == 0) {
            return 0;
        }
        if (list instanceof zzbbp) {
            zzbbp zzbbpVar = (zzbbp) list;
            iZzcf = 0;
            while (i < size) {
                iZzcf += zzbav.zzcf(zzbbpVar.getInt(i));
                i++;
            }
        } else {
            iZzcf = 0;
            while (i < size) {
                iZzcf += zzbav.zzcf(list.get(i).intValue());
                i++;
            }
        }
        return iZzcf;
    }

    static int zzal(List<Integer> list) {
        int iZzcg;
        int size = list.size();
        int i = 0;
        if (size == 0) {
            return 0;
        }
        if (list instanceof zzbbp) {
            zzbbp zzbbpVar = (zzbbp) list;
            iZzcg = 0;
            while (i < size) {
                iZzcg += zzbav.zzcg(zzbbpVar.getInt(i));
                i++;
            }
        } else {
            iZzcg = 0;
            while (i < size) {
                iZzcg += zzbav.zzcg(list.get(i).intValue());
                i++;
            }
        }
        return iZzcg;
    }

    static int zzam(List<?> list) {
        return list.size() << 2;
    }

    static int zzan(List<?> list) {
        return list.size() << 3;
    }

    static int zzao(List<?> list) {
        return list.size();
    }

    private static zzbee<?, ?> zzas(boolean z) {
        try {
            Class<?> clsZzafr = zzafr();
            if (clsZzafr == null) {
                return null;
            }
            return (zzbee) clsZzafr.getConstructor(Boolean.TYPE).newInstance(Boolean.valueOf(z));
        } catch (Throwable unused) {
            return null;
        }
    }

    public static void zzb(int i, List<zzbah> list, zzbey zzbeyVar) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zzb(i, list);
    }

    public static void zzb(int i, List<?> list, zzbey zzbeyVar, zzbdm zzbdmVar) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zzb(i, list, zzbdmVar);
    }

    public static void zzb(int i, List<Float> list, zzbey zzbeyVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zzf(i, list, z);
    }

    static int zzc(int i, Object obj, zzbdm zzbdmVar) {
        return obj instanceof zzbcb ? zzbav.zza(i, (zzbcb) obj) : zzbav.zzb(i, (zzbcu) obj, zzbdmVar);
    }

    static int zzc(int i, List<?> list) {
        int size = list.size();
        int i2 = 0;
        if (size == 0) {
            return 0;
        }
        int iZzcd = zzbav.zzcd(i) * size;
        if (list instanceof zzbcd) {
            zzbcd zzbcdVar = (zzbcd) list;
            while (i2 < size) {
                Object objZzcp = zzbcdVar.zzcp(i2);
                iZzcd += objZzcp instanceof zzbah ? zzbav.zzao((zzbah) objZzcp) : zzbav.zzeo((String) objZzcp);
                i2++;
            }
        } else {
            while (i2 < size) {
                Object obj = list.get(i2);
                iZzcd += obj instanceof zzbah ? zzbav.zzao((zzbah) obj) : zzbav.zzeo((String) obj);
                i2++;
            }
        }
        return iZzcd;
    }

    static int zzc(int i, List<?> list, zzbdm zzbdmVar) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        int iZzcd = zzbav.zzcd(i) * size;
        for (int i2 = 0; i2 < size; i2++) {
            Object obj = list.get(i2);
            iZzcd += obj instanceof zzbcb ? zzbav.zza((zzbcb) obj) : zzbav.zza((zzbcu) obj, zzbdmVar);
        }
        return iZzcd;
    }

    public static void zzc(int i, List<Long> list, zzbey zzbeyVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zzc(i, list, z);
    }

    static int zzd(int i, List<zzbah> list) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        int iZzcd = size * zzbav.zzcd(i);
        for (int i2 = 0; i2 < list.size(); i2++) {
            iZzcd += zzbav.zzao(list.get(i2));
        }
        return iZzcd;
    }

    static int zzd(int i, List<zzbcu> list, zzbdm zzbdmVar) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        int iZzc = 0;
        for (int i2 = 0; i2 < size; i2++) {
            iZzc += zzbav.zzc(i, list.get(i2), zzbdmVar);
        }
        return iZzc;
    }

    public static void zzd(int i, List<Long> list, zzbey zzbeyVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zzd(i, list, z);
    }

    static boolean zzd(Object obj, Object obj2) {
        if (obj != obj2) {
            return obj != null && obj.equals(obj2);
        }
        return true;
    }

    public static void zze(int i, List<Long> list, zzbey zzbeyVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zzn(i, list, z);
    }

    public static boolean zze(int i, int i2, int i3) {
        if (i2 < 40) {
            return true;
        }
        long j = i3;
        return ((((long) i2) - ((long) i)) + 1) + 9 <= ((2 * j) + 3) + ((j + 3) * 3);
    }

    public static void zzf(int i, List<Long> list, zzbey zzbeyVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zze(i, list, z);
    }

    public static void zzf(Class<?> cls) {
        if (!zzbbo.class.isAssignableFrom(cls) && zzdyf != null && !zzdyf.isAssignableFrom(cls)) {
            throw new IllegalArgumentException("Message classes must extend GeneratedMessage or GeneratedMessageLite");
        }
    }

    public static void zzg(int i, List<Long> list, zzbey zzbeyVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zzl(i, list, z);
    }

    public static void zzh(int i, List<Integer> list, zzbey zzbeyVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zza(i, list, z);
    }

    public static void zzi(int i, List<Integer> list, zzbey zzbeyVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zzj(i, list, z);
    }

    public static void zzj(int i, List<Integer> list, zzbey zzbeyVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zzm(i, list, z);
    }

    public static void zzk(int i, List<Integer> list, zzbey zzbeyVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zzb(i, list, z);
    }

    public static void zzl(int i, List<Integer> list, zzbey zzbeyVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zzk(i, list, z);
    }

    public static void zzm(int i, List<Integer> list, zzbey zzbeyVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zzh(i, list, z);
    }

    public static void zzn(int i, List<Boolean> list, zzbey zzbeyVar, boolean z) {
        if (list == null || list.isEmpty()) {
            return;
        }
        zzbeyVar.zzi(i, list, z);
    }

    static int zzo(int i, List<Long> list, boolean z) {
        if (list.size() == 0) {
            return 0;
        }
        return zzaf(list) + (list.size() * zzbav.zzcd(i));
    }

    static int zzp(int i, List<Long> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return zzag(list) + (size * zzbav.zzcd(i));
    }

    static int zzq(int i, List<Long> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return zzah(list) + (size * zzbav.zzcd(i));
    }

    static int zzr(int i, List<Integer> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return zzai(list) + (size * zzbav.zzcd(i));
    }

    static int zzs(int i, List<Integer> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return zzaj(list) + (size * zzbav.zzcd(i));
    }

    static int zzt(int i, List<Integer> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return zzak(list) + (size * zzbav.zzcd(i));
    }

    static int zzu(int i, List<Integer> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return zzal(list) + (size * zzbav.zzcd(i));
    }

    static int zzv(int i, List<?> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return size * zzbav.zzt(i, 0);
    }

    static int zzw(int i, List<?> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return size * zzbav.zzg(i, 0L);
    }

    static int zzx(int i, List<?> list, boolean z) {
        int size = list.size();
        if (size == 0) {
            return 0;
        }
        return size * zzbav.zzg(i, true);
    }
}
