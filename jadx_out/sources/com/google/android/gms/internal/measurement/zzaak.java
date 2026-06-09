package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzaak implements zzaap {
    private zzaap[] zzbvm;

    zzaak(zzaap... zzaapVarArr) {
        this.zzbvm = zzaapVarArr;
    }

    @Override // com.google.android.gms.internal.measurement.zzaap
    public final boolean zzd(Class<?> cls) {
        for (zzaap zzaapVar : this.zzbvm) {
            if (zzaapVar.zzd(cls)) {
                return true;
            }
        }
        return false;
    }

    @Override // com.google.android.gms.internal.measurement.zzaap
    public final zzaao zze(Class<?> cls) {
        for (zzaap zzaapVar : this.zzbvm) {
            if (zzaapVar.zzd(cls)) {
                return zzaapVar.zze(cls);
            }
        }
        String strValueOf = String.valueOf(cls.getName());
        throw new UnsupportedOperationException(strValueOf.length() != 0 ? "No factory is available for message type: ".concat(strValueOf) : new String("No factory is available for message type: "));
    }
}
