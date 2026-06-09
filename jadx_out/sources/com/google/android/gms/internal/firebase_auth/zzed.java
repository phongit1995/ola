package com.google.android.gms.internal.firebase_auth;

import java.util.Iterator;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
final class zzed implements zzec {
    zzed() {
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzec
    public final int zzb(int i, Object obj, Object obj2) {
        zzeb zzebVar = (zzeb) obj;
        if (zzebVar.isEmpty()) {
            return 0;
        }
        Iterator it2 = zzebVar.entrySet().iterator();
        if (!it2.hasNext()) {
            return 0;
        }
        Map.Entry entry = (Map.Entry) it2.next();
        entry.getKey();
        entry.getValue();
        throw new NoSuchMethodError();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzec
    public final Object zzb(Object obj, Object obj2) {
        zzeb zzebVarZzeu = (zzeb) obj;
        zzeb zzebVar = (zzeb) obj2;
        if (!zzebVar.isEmpty()) {
            if (!zzebVarZzeu.isMutable()) {
                zzebVarZzeu = zzebVarZzeu.zzeu();
            }
            zzebVarZzeu.zza(zzebVar);
        }
        return zzebVarZzeu;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzec
    public final Map<?, ?> zzi(Object obj) {
        return (zzeb) obj;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzec
    public final Map<?, ?> zzj(Object obj) {
        return (zzeb) obj;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzec
    public final boolean zzk(Object obj) {
        return !((zzeb) obj).isMutable();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzec
    public final Object zzl(Object obj) {
        ((zzeb) obj).zzbs();
        return obj;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzec
    public final Object zzm(Object obj) {
        return zzeb.zzet().zzeu();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzec
    public final zzea<?, ?> zzn(Object obj) {
        throw new NoSuchMethodError();
    }
}
