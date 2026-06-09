package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzzu implements zzaap {
    private static final zzzu zzbue = new zzzu();

    private zzzu() {
    }

    public static zzzu zzua() {
        return zzbue;
    }

    @Override // com.google.android.gms.internal.measurement.zzaap
    public final boolean zzd(Class<?> cls) {
        return zzzv.class.isAssignableFrom(cls);
    }

    @Override // com.google.android.gms.internal.measurement.zzaap
    public final zzaao zze(Class<?> cls) {
        if (!zzzv.class.isAssignableFrom(cls)) {
            String strValueOf = String.valueOf(cls.getName());
            throw new IllegalArgumentException(strValueOf.length() != 0 ? "Unsupported message type: ".concat(strValueOf) : new String("Unsupported message type: "));
        }
        try {
            return (zzaao) zzzv.zzf(cls.asSubclass(zzzv.class)).zza(3, (Object) null, (Object) null);
        } catch (Exception e) {
            String strValueOf2 = String.valueOf(cls.getName());
            throw new RuntimeException(strValueOf2.length() != 0 ? "Unable to get message info for ".concat(strValueOf2) : new String("Unable to get message info for "), e);
        }
    }
}
