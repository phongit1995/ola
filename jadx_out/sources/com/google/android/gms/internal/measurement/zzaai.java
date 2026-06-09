package com.google.android.gms.internal.measurement;

import com.google.android.gms.internal.measurement.zzzv;

/* JADX INFO: loaded from: classes2.dex */
final class zzaai implements zzabb {
    private static final zzaap zzbvl = new zzaaj();
    private final zzaap zzbvk;

    public zzaai() {
        this(new zzaak(zzzu.zzua(), zzuh()));
    }

    private zzaai(zzaap zzaapVar) {
        this.zzbvk = (zzaap) zzzw.zza(zzaapVar, "messageInfoFactory");
    }

    private static boolean zza(zzaao zzaaoVar) {
        return zzaaoVar.zzul() == zzzv.zzb.zzbur;
    }

    private static zzaap zzuh() {
        try {
            return (zzaap) Class.forName("com.google.protobuf.DescriptorMessageInfoFactory").getDeclaredMethod("getInstance", new Class[0]).invoke(null, new Object[0]);
        } catch (Exception unused) {
            return zzbvl;
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzabb
    public final <T> zzaba<T> zzg(Class<T> cls) {
        zzabc.zzh(cls);
        zzaao zzaaoVarZze = this.zzbvk.zze(cls);
        return zzaaoVarZze.zzum() ? zzzv.class.isAssignableFrom(cls) ? zzaau.zza(zzabc.zzuv(), zzzq.zztv(), zzaaoVarZze.zzun()) : zzaau.zza(zzabc.zzut(), zzzq.zztw(), zzaaoVarZze.zzun()) : zzzv.class.isAssignableFrom(cls) ? zza(zzaaoVarZze) ? zzaat.zza(cls, zzaaoVarZze, zzaax.zzuq(), zzaae.zzug(), zzabc.zzuv(), zzzq.zztv(), zzaan.zzuj()) : zzaat.zza(cls, zzaaoVarZze, zzaax.zzuq(), zzaae.zzug(), zzabc.zzuv(), null, zzaan.zzuj()) : zza(zzaaoVarZze) ? zzaat.zza(cls, zzaaoVarZze, zzaax.zzup(), zzaae.zzuf(), zzabc.zzut(), zzzq.zztw(), zzaan.zzui()) : zzaat.zza(cls, zzaaoVarZze, zzaax.zzup(), zzaae.zzuf(), zzabc.zzuu(), null, zzaan.zzui());
    }
}
