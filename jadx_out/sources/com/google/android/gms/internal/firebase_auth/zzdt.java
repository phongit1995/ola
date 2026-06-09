package com.google.android.gms.internal.firebase_auth;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
final class zzdt extends zzdr {
    private static final Class<?> zzsv = Collections.unmodifiableList(Collections.emptyList()).getClass();

    private zzdt() {
        super();
    }

    private static <L> List<L> zza(Object obj, long j, int i) {
        Object obj2;
        List<L> listZzc = zzc(obj, j);
        if (listZzc.isEmpty()) {
            List<L> zzdpVar = listZzc instanceof zzdq ? new zzdp(i) : new ArrayList<>(i);
            zzfv.zza(obj, j, zzdpVar);
            return zzdpVar;
        }
        if (zzsv.isAssignableFrom(listZzc.getClass())) {
            ArrayList arrayList = new ArrayList(listZzc.size() + i);
            arrayList.addAll(listZzc);
            obj2 = arrayList;
        } else {
            if (!(listZzc instanceof zzfs)) {
                return listZzc;
            }
            zzdp zzdpVar2 = new zzdp(listZzc.size() + i);
            zzdpVar2.addAll((zzfs) listZzc);
            obj2 = zzdpVar2;
        }
        zzfv.zza(obj, j, obj2);
        return (List<L>) obj2;
    }

    private static <E> List<E> zzc(Object obj, long j) {
        return (List) zzfv.zzp(obj, j);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdr
    final <L> List<L> zza(Object obj, long j) {
        return zza(obj, j, 10);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdr
    final <E> void zza(Object obj, Object obj2, long j) {
        List listZzc = zzc(obj2, j);
        List listZza = zza(obj, j, listZzc.size());
        int size = listZza.size();
        int size2 = listZzc.size();
        if (size > 0 && size2 > 0) {
            listZza.addAll(listZzc);
        }
        if (size > 0) {
            listZzc = listZza;
        }
        zzfv.zza(obj, j, listZzc);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdr
    final void zzb(Object obj, long j) {
        Object objUnmodifiableList;
        List list = (List) zzfv.zzp(obj, j);
        if (list instanceof zzdq) {
            objUnmodifiableList = ((zzdq) list).zzep();
        } else if (zzsv.isAssignableFrom(list.getClass())) {
            return;
        } else {
            objUnmodifiableList = Collections.unmodifiableList(list);
        }
        zzfv.zza(obj, j, objUnmodifiableList);
    }
}
