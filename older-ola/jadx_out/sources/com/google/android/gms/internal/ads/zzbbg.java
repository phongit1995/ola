package com.google.android.gms.internal.ads;

import com.google.android.gms.internal.ads.zzbbi;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
final class zzbbg<FieldDescriptorType extends zzbbi<FieldDescriptorType>> {
    private static final zzbbg zzdra = new zzbbg(true);
    private boolean zzdqy;
    private boolean zzdqz = false;
    private final zzbdp<FieldDescriptorType, Object> zzdqx = zzbdp.zzcx(16);

    private zzbbg() {
    }

    private zzbbg(boolean z) {
        zzaaz();
    }

    static int zza(zzbes zzbesVar, int i, Object obj) {
        int iZzcd = zzbav.zzcd(i);
        if (zzbesVar == zzbes.zzeaj) {
            zzbbq.zzi((zzbcu) obj);
            iZzcd <<= 1;
        }
        return iZzcd + zzb(zzbesVar, obj);
    }

    private final Object zza(FieldDescriptorType fielddescriptortype) {
        Object obj = this.zzdqx.get(fielddescriptortype);
        return obj instanceof zzbbx ? zzbbx.zzadu() : obj;
    }

    static void zza(zzbav zzbavVar, zzbes zzbesVar, int i, Object obj) {
        if (zzbesVar == zzbes.zzeaj) {
            zzbcu zzbcuVar = (zzbcu) obj;
            zzbbq.zzi(zzbcuVar);
            zzbavVar.zzl(i, 3);
            zzbcuVar.zzb(zzbavVar);
            zzbavVar.zzl(i, 4);
        }
        zzbavVar.zzl(i, zzbesVar.zzagm());
        switch (zzbbh.zzdql[zzbesVar.ordinal()]) {
            case 1:
                zzbavVar.zzb(((Double) obj).doubleValue());
                break;
            case 2:
                zzbavVar.zzb(((Float) obj).floatValue());
                break;
            case 3:
                zzbavVar.zzm(((Long) obj).longValue());
                break;
            case 4:
                zzbavVar.zzm(((Long) obj).longValue());
                break;
            case 5:
                zzbavVar.zzbz(((Integer) obj).intValue());
                break;
            case 6:
                zzbavVar.zzo(((Long) obj).longValue());
                break;
            case 7:
                zzbavVar.zzcc(((Integer) obj).intValue());
                break;
            case 8:
                zzbavVar.zzap(((Boolean) obj).booleanValue());
                break;
            case 9:
                ((zzbcu) obj).zzb(zzbavVar);
                break;
            case 10:
                zzbavVar.zze((zzbcu) obj);
                break;
            case 11:
                if (!(obj instanceof zzbah)) {
                    zzbavVar.zzen((String) obj);
                } else {
                    zzbavVar.zzan((zzbah) obj);
                }
                break;
            case 12:
                if (!(obj instanceof zzbah)) {
                    byte[] bArr = (byte[]) obj;
                    zzbavVar.zze(bArr, 0, bArr.length);
                } else {
                    zzbavVar.zzan((zzbah) obj);
                }
                break;
            case 13:
                zzbavVar.zzca(((Integer) obj).intValue());
                break;
            case 14:
                zzbavVar.zzcc(((Integer) obj).intValue());
                break;
            case 15:
                zzbavVar.zzo(((Long) obj).longValue());
                break;
            case 16:
                zzbavVar.zzcb(((Integer) obj).intValue());
                break;
            case 17:
                zzbavVar.zzn(((Long) obj).longValue());
                break;
            case 18:
                if (!(obj instanceof zzbbr)) {
                    zzbavVar.zzbz(((Integer) obj).intValue());
                } else {
                    zzbavVar.zzbz(((zzbbr) obj).zzhq());
                }
                break;
        }
    }

    private final void zza(FieldDescriptorType fielddescriptortype, Object obj) {
        if (!fielddescriptortype.zzada()) {
            zza(fielddescriptortype.zzacy(), obj);
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
                zza(fielddescriptortype.zzacy(), obj2);
            }
            obj = arrayList;
        }
        if (obj instanceof zzbbx) {
            this.zzdqz = true;
        }
        this.zzdqx.put(fielddescriptortype, obj);
    }

    /* JADX WARN: Removed duplicated region for block: B:14:0x0026  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static void zza(com.google.android.gms.internal.ads.zzbes r2, java.lang.Object r3) {
        /*
            com.google.android.gms.internal.ads.zzbbq.checkNotNull(r3)
            int[] r0 = com.google.android.gms.internal.ads.zzbbh.zzdrb
            com.google.android.gms.internal.ads.zzbex r2 = r2.zzagl()
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
            boolean r2 = r3 instanceof com.google.android.gms.internal.ads.zzbcu
            if (r2 != 0) goto L26
            boolean r2 = r3 instanceof com.google.android.gms.internal.ads.zzbbx
            if (r2 == 0) goto L43
            goto L26
        L1e:
            boolean r2 = r3 instanceof java.lang.Integer
            if (r2 != 0) goto L26
            boolean r2 = r3 instanceof com.google.android.gms.internal.ads.zzbbr
            if (r2 == 0) goto L43
        L26:
            r1 = 1
            goto L43
        L28:
            boolean r2 = r3 instanceof com.google.android.gms.internal.ads.zzbah
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
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbbg.zza(com.google.android.gms.internal.ads.zzbes, java.lang.Object):void");
    }

    public static <T extends zzbbi<T>> zzbbg<T> zzacv() {
        return zzdra;
    }

    private static int zzb(zzbbi<?> zzbbiVar, Object obj) {
        zzbes zzbesVarZzacy = zzbbiVar.zzacy();
        int iZzhq = zzbbiVar.zzhq();
        if (!zzbbiVar.zzada()) {
            return zza(zzbesVarZzacy, iZzhq, obj);
        }
        int iZza = 0;
        if (zzbbiVar.zzadb()) {
            Iterator it2 = ((List) obj).iterator();
            while (it2.hasNext()) {
                iZza += zzb(zzbesVarZzacy, it2.next());
            }
            return zzbav.zzcd(iZzhq) + iZza + zzbav.zzcl(iZza);
        }
        Iterator it3 = ((List) obj).iterator();
        while (it3.hasNext()) {
            iZza += zza(zzbesVarZzacy, iZzhq, it3.next());
        }
        return iZza;
    }

    private static int zzb(zzbes zzbesVar, Object obj) {
        switch (zzbbh.zzdql[zzbesVar.ordinal()]) {
            case 1:
                return zzbav.zzc(((Double) obj).doubleValue());
            case 2:
                return zzbav.zzc(((Float) obj).floatValue());
            case 3:
                return zzbav.zzp(((Long) obj).longValue());
            case 4:
                return zzbav.zzq(((Long) obj).longValue());
            case 5:
                return zzbav.zzce(((Integer) obj).intValue());
            case 6:
                return zzbav.zzs(((Long) obj).longValue());
            case 7:
                return zzbav.zzch(((Integer) obj).intValue());
            case 8:
                return zzbav.zzaq(((Boolean) obj).booleanValue());
            case 9:
                return zzbav.zzg((zzbcu) obj);
            case 10:
                return obj instanceof zzbbx ? zzbav.zza((zzbbx) obj) : zzbav.zzf((zzbcu) obj);
            case 11:
                return obj instanceof zzbah ? zzbav.zzao((zzbah) obj) : zzbav.zzeo((String) obj);
            case 12:
                return obj instanceof zzbah ? zzbav.zzao((zzbah) obj) : zzbav.zzr((byte[]) obj);
            case 13:
                return zzbav.zzcf(((Integer) obj).intValue());
            case 14:
                return zzbav.zzci(((Integer) obj).intValue());
            case 15:
                return zzbav.zzt(((Long) obj).longValue());
            case 16:
                return zzbav.zzcg(((Integer) obj).intValue());
            case 17:
                return zzbav.zzr(((Long) obj).longValue());
            case 18:
                return obj instanceof zzbbr ? zzbav.zzcj(((zzbbr) obj).zzhq()) : zzbav.zzcj(((Integer) obj).intValue());
            default:
                throw new RuntimeException("There is no way to get here, but the compiler thinks otherwise.");
        }
    }

    private static boolean zzb(Map.Entry<FieldDescriptorType, Object> entry) {
        FieldDescriptorType key = entry.getKey();
        if (key.zzacz() == zzbex.MESSAGE) {
            if (key.zzada()) {
                Iterator it2 = ((List) entry.getValue()).iterator();
                while (it2.hasNext()) {
                    if (!((zzbcu) it2.next()).isInitialized()) {
                        return false;
                    }
                }
            } else {
                Object value = entry.getValue();
                if (!(value instanceof zzbcu)) {
                    if (value instanceof zzbbx) {
                        return true;
                    }
                    throw new IllegalArgumentException("Wrong object type used with protocol message reflection.");
                }
                if (!((zzbcu) value).isInitialized()) {
                    return false;
                }
            }
        }
        return true;
    }

    private final void zzc(Map.Entry<FieldDescriptorType, Object> entry) {
        FieldDescriptorType key = entry.getKey();
        Object value = entry.getValue();
        if (value instanceof zzbbx) {
            value = zzbbx.zzadu();
        }
        if (key.zzada()) {
            Object objZza = zza(key);
            if (objZza == null) {
                objZza = new ArrayList();
            }
            Iterator it2 = ((List) value).iterator();
            while (it2.hasNext()) {
                ((List) objZza).add(zzp(it2.next()));
            }
            this.zzdqx.put(key, objZza);
            return;
        }
        if (key.zzacz() != zzbex.MESSAGE) {
            this.zzdqx.put(key, zzp(value));
            return;
        }
        Object objZza2 = zza(key);
        if (objZza2 == null) {
            this.zzdqx.put(key, zzp(value));
        } else {
            this.zzdqx.put(key, objZza2 instanceof zzbdb ? key.zza((zzbdb) objZza2, (zzbdb) value) : key.zza(((zzbcu) objZza2).zzade(), (zzbcu) value).zzadk());
        }
    }

    private static int zzd(Map.Entry<FieldDescriptorType, Object> entry) {
        FieldDescriptorType key = entry.getKey();
        Object value = entry.getValue();
        return (key.zzacz() != zzbex.MESSAGE || key.zzada() || key.zzadb()) ? zzb((zzbbi<?>) key, value) : value instanceof zzbbx ? zzbav.zzb(entry.getKey().zzhq(), (zzbbx) value) : zzbav.zzb(entry.getKey().zzhq(), (zzbcu) value);
    }

    private static Object zzp(Object obj) {
        if (obj instanceof zzbdb) {
            return ((zzbdb) obj).zzaek();
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
        zzbbg zzbbgVar = new zzbbg();
        for (int i = 0; i < this.zzdqx.zzafs(); i++) {
            Map.Entry<K, Object> entryZzcy = this.zzdqx.zzcy(i);
            zzbbgVar.zza((zzbbi) entryZzcy.getKey(), entryZzcy.getValue());
        }
        Iterator it2 = this.zzdqx.zzaft().iterator();
        while (it2.hasNext()) {
            Map.Entry entry = (Map.Entry) it2.next();
            zzbbgVar.zza((zzbbi) entry.getKey(), entry.getValue());
        }
        zzbbgVar.zzdqz = this.zzdqz;
        return zzbbgVar;
    }

    final Iterator<Map.Entry<FieldDescriptorType, Object>> descendingIterator() {
        return this.zzdqz ? new zzbca(this.zzdqx.zzafu().iterator()) : this.zzdqx.zzafu().iterator();
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzbbg) {
            return this.zzdqx.equals(((zzbbg) obj).zzdqx);
        }
        return false;
    }

    public final int hashCode() {
        return this.zzdqx.hashCode();
    }

    final boolean isEmpty() {
        return this.zzdqx.isEmpty();
    }

    public final boolean isImmutable() {
        return this.zzdqy;
    }

    public final boolean isInitialized() {
        for (int i = 0; i < this.zzdqx.zzafs(); i++) {
            if (!zzb(this.zzdqx.zzcy(i))) {
                return false;
            }
        }
        Iterator it2 = this.zzdqx.zzaft().iterator();
        while (it2.hasNext()) {
            if (!zzb((Map.Entry) it2.next())) {
                return false;
            }
        }
        return true;
    }

    public final Iterator<Map.Entry<FieldDescriptorType, Object>> iterator() {
        return this.zzdqz ? new zzbca(this.zzdqx.entrySet().iterator()) : this.zzdqx.entrySet().iterator();
    }

    public final void zza(zzbbg<FieldDescriptorType> zzbbgVar) {
        for (int i = 0; i < zzbbgVar.zzdqx.zzafs(); i++) {
            zzc(zzbbgVar.zzdqx.zzcy(i));
        }
        Iterator it2 = zzbbgVar.zzdqx.zzaft().iterator();
        while (it2.hasNext()) {
            zzc((Map.Entry) it2.next());
        }
    }

    public final void zzaaz() {
        if (this.zzdqy) {
            return;
        }
        this.zzdqx.zzaaz();
        this.zzdqy = true;
    }

    public final int zzacw() {
        int iZzb = 0;
        for (int i = 0; i < this.zzdqx.zzafs(); i++) {
            Map.Entry<K, Object> entryZzcy = this.zzdqx.zzcy(i);
            iZzb += zzb((zzbbi<?>) entryZzcy.getKey(), entryZzcy.getValue());
        }
        Iterator it2 = this.zzdqx.zzaft().iterator();
        while (it2.hasNext()) {
            Map.Entry entry = (Map.Entry) it2.next();
            iZzb += zzb((zzbbi<?>) entry.getKey(), entry.getValue());
        }
        return iZzb;
    }

    public final int zzacx() {
        int iZzd = 0;
        for (int i = 0; i < this.zzdqx.zzafs(); i++) {
            iZzd += zzd(this.zzdqx.zzcy(i));
        }
        Iterator it2 = this.zzdqx.zzaft().iterator();
        while (it2.hasNext()) {
            iZzd += zzd((Map.Entry) it2.next());
        }
        return iZzd;
    }
}
