package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
final class zzdy implements zzeg {
    private zzeg[] zzta;

    zzdy(zzeg... zzegVarArr) {
        this.zzta = zzegVarArr;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeg
    public final boolean zzb(Class<?> cls) {
        for (zzeg zzegVar : this.zzta) {
            if (zzegVar.zzb(cls)) {
                return true;
            }
        }
        return false;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeg
    public final zzef zzc(Class<?> cls) {
        for (zzeg zzegVar : this.zzta) {
            if (zzegVar.zzb(cls)) {
                return zzegVar.zzc(cls);
            }
        }
        String strValueOf = String.valueOf(cls.getName());
        throw new UnsupportedOperationException(strValueOf.length() != 0 ? "No factory is available for message type: ".concat(strValueOf) : new String("No factory is available for message type: "));
    }
}
