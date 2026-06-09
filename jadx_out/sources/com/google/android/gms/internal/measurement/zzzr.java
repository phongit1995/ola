package com.google.android.gms.internal.measurement;

import com.google.android.gms.internal.measurement.zzzt;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
final class zzzr<FieldDescriptorType extends zzzt<FieldDescriptorType>> {
    private static final zzzr zzbub = new zzzr(true);
    private boolean zzbnw;
    private boolean zzbua = false;
    private final zzabd<FieldDescriptorType, Object> zzbtz = zzabd.zzag(16);

    private zzzr() {
    }

    private zzzr(boolean z) {
        if (this.zzbnw) {
            return;
        }
        this.zzbtz.zzru();
        this.zzbnw = true;
    }

    /* JADX WARN: Removed duplicated region for block: B:14:0x0026  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static void zza(com.google.android.gms.internal.measurement.zzabu r2, java.lang.Object r3) {
        /*
            com.google.android.gms.internal.measurement.zzzw.checkNotNull(r3)
            int[] r0 = com.google.android.gms.internal.measurement.zzzs.zzbuc
            com.google.android.gms.internal.measurement.zzabz r2 = r2.zzvk()
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
            boolean r2 = r3 instanceof com.google.android.gms.internal.measurement.zzaaq
            if (r2 != 0) goto L26
            boolean r2 = r3 instanceof com.google.android.gms.internal.measurement.zzzz
            if (r2 == 0) goto L43
            goto L26
        L1e:
            boolean r2 = r3 instanceof java.lang.Integer
            if (r2 != 0) goto L26
            boolean r2 = r3 instanceof com.google.android.gms.internal.measurement.zzzx
            if (r2 == 0) goto L43
        L26:
            r1 = 1
            goto L43
        L28:
            boolean r2 = r3 instanceof com.google.android.gms.internal.measurement.zzzb
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
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzzr.zza(com.google.android.gms.internal.measurement.zzabu, java.lang.Object):void");
    }

    private final void zza(FieldDescriptorType fielddescriptortype, Object obj) {
        if (!fielddescriptortype.zztz()) {
            zza(fielddescriptortype.zzty(), obj);
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
                zza(fielddescriptortype.zzty(), obj2);
            }
            obj = arrayList;
        }
        if (obj instanceof zzzz) {
            this.zzbua = true;
        }
        this.zzbtz.put(fielddescriptortype, obj);
    }

    public static <T extends zzzt<T>> zzzr<T> zztx() {
        return zzbub;
    }

    /* JADX WARN: Multi-variable type inference failed */
    public final /* synthetic */ Object clone() {
        zzzr zzzrVar = new zzzr();
        for (int i = 0; i < this.zzbtz.zzuy(); i++) {
            Map.Entry<K, Object> entryZzah = this.zzbtz.zzah(i);
            zzzrVar.zza((zzzt) entryZzah.getKey(), entryZzah.getValue());
        }
        Iterator it2 = this.zzbtz.zzuz().iterator();
        while (it2.hasNext()) {
            Map.Entry entry = (Map.Entry) it2.next();
            zzzrVar.zza((zzzt) entry.getKey(), entry.getValue());
        }
        zzzrVar.zzbua = this.zzbua;
        return zzzrVar;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzzr) {
            return this.zzbtz.equals(((zzzr) obj).zzbtz);
        }
        return false;
    }

    public final int hashCode() {
        return this.zzbtz.hashCode();
    }

    public final Iterator<Map.Entry<FieldDescriptorType, Object>> iterator() {
        return this.zzbua ? new zzaac(this.zzbtz.entrySet().iterator()) : this.zzbtz.entrySet().iterator();
    }
}
