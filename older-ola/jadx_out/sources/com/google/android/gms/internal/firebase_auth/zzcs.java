package com.google.android.gms.internal.firebase_auth;

import com.google.android.gms.internal.firebase_auth.zzcu;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
final class zzcs<FieldDescriptorType extends zzcu<FieldDescriptorType>> {
    private static final zzcs zzod = new zzcs(true);
    private boolean zzob;
    private boolean zzoc = false;
    private final zzey<FieldDescriptorType, Object> zzoa = zzey.zzat(16);

    private zzcs() {
    }

    private zzcs(boolean z) {
        zzbs();
    }

    static int zza(zzgd zzgdVar, int i, Object obj) {
        int iZzaa = zzci.zzaa(i);
        if (zzgdVar == zzgd.zzwo) {
            zzdd.zzf((zzeh) obj);
            iZzaa <<= 1;
        }
        return iZzaa + zzb(zzgdVar, obj);
    }

    private final Object zza(FieldDescriptorType fielddescriptortype) {
        Object obj = this.zzoa.get(fielddescriptortype);
        return obj instanceof zzdk ? zzdk.zzem() : obj;
    }

    static void zza(zzci zzciVar, zzgd zzgdVar, int i, Object obj) {
        if (zzgdVar == zzgd.zzwo) {
            zzeh zzehVar = (zzeh) obj;
            zzdd.zzf(zzehVar);
            zzciVar.zzb(i, 3);
            zzehVar.zzb(zzciVar);
            zzciVar.zzb(i, 4);
        }
        zzciVar.zzb(i, zzgdVar.zzgk());
        switch (zzct.zzne[zzgdVar.ordinal()]) {
            case 1:
                zzciVar.zza(((Double) obj).doubleValue());
                break;
            case 2:
                zzciVar.zza(((Float) obj).floatValue());
                break;
            case 3:
                zzciVar.zza(((Long) obj).longValue());
                break;
            case 4:
                zzciVar.zza(((Long) obj).longValue());
                break;
            case 5:
                zzciVar.zzw(((Integer) obj).intValue());
                break;
            case 6:
                zzciVar.zzc(((Long) obj).longValue());
                break;
            case 7:
                zzciVar.zzz(((Integer) obj).intValue());
                break;
            case 8:
                zzciVar.zzf(((Boolean) obj).booleanValue());
                break;
            case 9:
                ((zzeh) obj).zzb(zzciVar);
                break;
            case 10:
                zzciVar.zzb((zzeh) obj);
                break;
            case 11:
                if (!(obj instanceof zzbu)) {
                    zzciVar.zzal((String) obj);
                } else {
                    zzciVar.zza((zzbu) obj);
                }
                break;
            case 12:
                if (!(obj instanceof zzbu)) {
                    byte[] bArr = (byte[]) obj;
                    zzciVar.zze(bArr, 0, bArr.length);
                } else {
                    zzciVar.zza((zzbu) obj);
                }
                break;
            case 13:
                zzciVar.zzx(((Integer) obj).intValue());
                break;
            case 14:
                zzciVar.zzz(((Integer) obj).intValue());
                break;
            case 15:
                zzciVar.zzc(((Long) obj).longValue());
                break;
            case 16:
                zzciVar.zzy(((Integer) obj).intValue());
                break;
            case 17:
                zzciVar.zzb(((Long) obj).longValue());
                break;
            case 18:
                if (!(obj instanceof zzde)) {
                    zzciVar.zzw(((Integer) obj).intValue());
                } else {
                    zzciVar.zzw(((zzde) obj).zzds());
                }
                break;
        }
    }

    private final void zza(FieldDescriptorType fielddescriptortype, Object obj) {
        if (!fielddescriptortype.zzdv()) {
            zza(fielddescriptortype.zzdt(), obj);
        } else {
            if (!(obj instanceof List)) {
                throw new IllegalArgumentException("Wrong object type used with protocol message reflection.");
            }
            ArrayList arrayList = new ArrayList();
            arrayList.addAll((List) obj);
            ArrayList arrayList2 = arrayList;
            int size = arrayList2.size();
            int i = 0;
            while (i < size) {
                Object obj2 = arrayList2.get(i);
                i++;
                zza(fielddescriptortype.zzdt(), obj2);
            }
            obj = arrayList;
        }
        if (obj instanceof zzdk) {
            this.zzoc = true;
        }
        this.zzoa.put(fielddescriptortype, obj);
    }

    /* JADX WARN: Removed duplicated region for block: B:14:0x0026  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static void zza(com.google.android.gms.internal.firebase_auth.zzgd r2, java.lang.Object r3) {
        /*
            com.google.android.gms.internal.firebase_auth.zzdd.checkNotNull(r3)
            int[] r0 = com.google.android.gms.internal.firebase_auth.zzct.zzoe
            com.google.android.gms.internal.firebase_auth.zzgi r2 = r2.zzgj()
            int r2 = r2.ordinal()
            r2 = r0[r2]
            r0 = 1
            r1 = 0
            switch(r2) {
                case 1: goto L40;
                case 2: goto L3d;
                case 3: goto L3a;
                case 4: goto L37;
                case 5: goto L34;
                case 6: goto L31;
                case 7: goto L28;
                case 8: goto L1e;
                case 9: goto L15;
                default: goto L14;
            }
        L14:
            goto L43
        L15:
            boolean r2 = r3 instanceof com.google.android.gms.internal.firebase_auth.zzeh
            if (r2 != 0) goto L26
            boolean r2 = r3 instanceof com.google.android.gms.internal.firebase_auth.zzdk
            if (r2 == 0) goto L43
            goto L26
        L1e:
            boolean r2 = r3 instanceof java.lang.Integer
            if (r2 != 0) goto L26
            boolean r2 = r3 instanceof com.google.android.gms.internal.firebase_auth.zzde
            if (r2 == 0) goto L43
        L26:
            r1 = 1
            goto L43
        L28:
            boolean r2 = r3 instanceof com.google.android.gms.internal.firebase_auth.zzbu
            if (r2 != 0) goto L26
            boolean r2 = r3 instanceof byte[]
            if (r2 == 0) goto L43
            goto L26
        L31:
            boolean r0 = r3 instanceof java.lang.String
            goto L42
        L34:
            boolean r0 = r3 instanceof java.lang.Boolean
            goto L42
        L37:
            boolean r0 = r3 instanceof java.lang.Double
            goto L42
        L3a:
            boolean r0 = r3 instanceof java.lang.Float
            goto L42
        L3d:
            boolean r0 = r3 instanceof java.lang.Long
            goto L42
        L40:
            boolean r0 = r3 instanceof java.lang.Integer
        L42:
            r1 = r0
        L43:
            if (r1 != 0) goto L4d
            java.lang.IllegalArgumentException r2 = new java.lang.IllegalArgumentException
            java.lang.String r3 = "Wrong object type used with protocol message reflection."
            r2.<init>(r3)
            throw r2
        L4d:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.firebase_auth.zzcs.zza(com.google.android.gms.internal.firebase_auth.zzgd, java.lang.Object):void");
    }

    private static int zzb(zzcu<?> zzcuVar, Object obj) {
        zzgd zzgdVarZzdt = zzcuVar.zzdt();
        int iZzds = zzcuVar.zzds();
        if (!zzcuVar.zzdv()) {
            return zza(zzgdVarZzdt, iZzds, obj);
        }
        int iZza = 0;
        if (zzcuVar.zzdw()) {
            Iterator it2 = ((List) obj).iterator();
            while (it2.hasNext()) {
                iZza += zzb(zzgdVarZzdt, it2.next());
            }
            return zzci.zzaa(iZzds) + iZza + zzci.zzai(iZza);
        }
        Iterator it3 = ((List) obj).iterator();
        while (it3.hasNext()) {
            iZza += zza(zzgdVarZzdt, iZzds, it3.next());
        }
        return iZza;
    }

    private static int zzb(zzgd zzgdVar, Object obj) {
        switch (zzct.zzne[zzgdVar.ordinal()]) {
            case 1:
                return zzci.zzb(((Double) obj).doubleValue());
            case 2:
                return zzci.zzb(((Float) obj).floatValue());
            case 3:
                return zzci.zzd(((Long) obj).longValue());
            case 4:
                return zzci.zze(((Long) obj).longValue());
            case 5:
                return zzci.zzab(((Integer) obj).intValue());
            case 6:
                return zzci.zzg(((Long) obj).longValue());
            case 7:
                return zzci.zzae(((Integer) obj).intValue());
            case 8:
                return zzci.zzg(((Boolean) obj).booleanValue());
            case 9:
                return zzci.zzd((zzeh) obj);
            case 10:
                return obj instanceof zzdk ? zzci.zza((zzdk) obj) : zzci.zzc((zzeh) obj);
            case 11:
                return obj instanceof zzbu ? zzci.zzb((zzbu) obj) : zzci.zzam((String) obj);
            case 12:
                return obj instanceof zzbu ? zzci.zzb((zzbu) obj) : zzci.zzc((byte[]) obj);
            case 13:
                return zzci.zzac(((Integer) obj).intValue());
            case 14:
                return zzci.zzaf(((Integer) obj).intValue());
            case 15:
                return zzci.zzh(((Long) obj).longValue());
            case 16:
                return zzci.zzad(((Integer) obj).intValue());
            case 17:
                return zzci.zzf(((Long) obj).longValue());
            case 18:
                return obj instanceof zzde ? zzci.zzag(((zzde) obj).zzds()) : zzci.zzag(((Integer) obj).intValue());
            default:
                throw new RuntimeException("There is no way to get here, but the compiler thinks otherwise.");
        }
    }

    private static boolean zzb(Map.Entry<FieldDescriptorType, Object> entry) {
        FieldDescriptorType key = entry.getKey();
        if (key.zzdu() == zzgi.MESSAGE) {
            if (key.zzdv()) {
                Iterator it2 = ((List) entry.getValue()).iterator();
                while (it2.hasNext()) {
                    if (!((zzeh) it2.next()).isInitialized()) {
                        return false;
                    }
                }
            } else {
                Object value = entry.getValue();
                if (!(value instanceof zzeh)) {
                    if (value instanceof zzdk) {
                        return true;
                    }
                    throw new IllegalArgumentException("Wrong object type used with protocol message reflection.");
                }
                if (!((zzeh) value).isInitialized()) {
                    return false;
                }
            }
        }
        return true;
    }

    private final void zzc(Map.Entry<FieldDescriptorType, Object> entry) {
        FieldDescriptorType key = entry.getKey();
        Object value = entry.getValue();
        if (value instanceof zzdk) {
            value = zzdk.zzem();
        }
        if (key.zzdv()) {
            Object objZza = zza(key);
            if (objZza == null) {
                objZza = new ArrayList();
            }
            Iterator it2 = ((List) value).iterator();
            while (it2.hasNext()) {
                ((List) objZza).add(zzf(it2.next()));
            }
            this.zzoa.put(key, objZza);
            return;
        }
        if (key.zzdu() != zzgi.MESSAGE) {
            this.zzoa.put(key, zzf(value));
            return;
        }
        Object objZza2 = zza(key);
        if (objZza2 == null) {
            this.zzoa.put(key, zzf(value));
        } else {
            this.zzoa.put(key, objZza2 instanceof zzen ? key.zza((zzen) objZza2, (zzen) value) : key.zza(((zzeh) objZza2).zzdz(), (zzeh) value).zzed());
        }
    }

    private static int zzd(Map.Entry<FieldDescriptorType, Object> entry) {
        FieldDescriptorType key = entry.getKey();
        Object value = entry.getValue();
        return (key.zzdu() != zzgi.MESSAGE || key.zzdv() || key.zzdw()) ? zzb((zzcu<?>) key, value) : value instanceof zzdk ? zzci.zzb(entry.getKey().zzds(), (zzdk) value) : zzci.zzd(entry.getKey().zzds(), (zzeh) value);
    }

    public static <T extends zzcu<T>> zzcs<T> zzdp() {
        return zzod;
    }

    private static Object zzf(Object obj) {
        if (obj instanceof zzen) {
            return ((zzen) obj).zzfc();
        }
        if (!(obj instanceof byte[])) {
            return obj;
        }
        byte[] bArr = (byte[]) obj;
        byte[] bArr2 = new byte[bArr.length];
        System.arraycopy(bArr, 0, bArr2, 0, bArr.length);
        return bArr2;
    }

    /* JADX WARN: Multi-variable type inference failed */
    public final /* synthetic */ Object clone() {
        zzcs zzcsVar = new zzcs();
        for (int i = 0; i < this.zzoa.zzfo(); i++) {
            Map.Entry<K, Object> entryZzau = this.zzoa.zzau(i);
            zzcsVar.zza((zzcu) entryZzau.getKey(), entryZzau.getValue());
        }
        Iterator it2 = this.zzoa.zzfp().iterator();
        while (it2.hasNext()) {
            Map.Entry entry = (Map.Entry) it2.next();
            zzcsVar.zza((zzcu) entry.getKey(), entry.getValue());
        }
        zzcsVar.zzoc = this.zzoc;
        return zzcsVar;
    }

    final Iterator<Map.Entry<FieldDescriptorType, Object>> descendingIterator() {
        return this.zzoc ? new zzdn(this.zzoa.zzfq().iterator()) : this.zzoa.zzfq().iterator();
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzcs) {
            return this.zzoa.equals(((zzcs) obj).zzoa);
        }
        return false;
    }

    public final int hashCode() {
        return this.zzoa.hashCode();
    }

    final boolean isEmpty() {
        return this.zzoa.isEmpty();
    }

    public final boolean isImmutable() {
        return this.zzob;
    }

    public final boolean isInitialized() {
        for (int i = 0; i < this.zzoa.zzfo(); i++) {
            if (!zzb(this.zzoa.zzau(i))) {
                return false;
            }
        }
        Iterator it2 = this.zzoa.zzfp().iterator();
        while (it2.hasNext()) {
            if (!zzb((Map.Entry) it2.next())) {
                return false;
            }
        }
        return true;
    }

    public final Iterator<Map.Entry<FieldDescriptorType, Object>> iterator() {
        return this.zzoc ? new zzdn(this.zzoa.entrySet().iterator()) : this.zzoa.entrySet().iterator();
    }

    public final void zza(zzcs<FieldDescriptorType> zzcsVar) {
        for (int i = 0; i < zzcsVar.zzoa.zzfo(); i++) {
            zzc(zzcsVar.zzoa.zzau(i));
        }
        Iterator it2 = zzcsVar.zzoa.zzfp().iterator();
        while (it2.hasNext()) {
            zzc((Map.Entry) it2.next());
        }
    }

    public final void zzbs() {
        if (this.zzob) {
            return;
        }
        this.zzoa.zzbs();
        this.zzob = true;
    }

    public final int zzdq() {
        int iZzb = 0;
        for (int i = 0; i < this.zzoa.zzfo(); i++) {
            Map.Entry<K, Object> entryZzau = this.zzoa.zzau(i);
            iZzb += zzb((zzcu<?>) entryZzau.getKey(), entryZzau.getValue());
        }
        Iterator it2 = this.zzoa.zzfp().iterator();
        while (it2.hasNext()) {
            Map.Entry entry = (Map.Entry) it2.next();
            iZzb += zzb((zzcu<?>) entry.getKey(), entry.getValue());
        }
        return iZzb;
    }

    public final int zzdr() {
        int iZzd = 0;
        for (int i = 0; i < this.zzoa.zzfo(); i++) {
            iZzd += zzd(this.zzoa.zzau(i));
        }
        Iterator it2 = this.zzoa.zzfp().iterator();
        while (it2.hasNext()) {
            iZzd += zzd((Map.Entry) it2.next());
        }
        return iZzd;
    }
}
