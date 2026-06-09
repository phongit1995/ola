package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
abstract class zzfp<T, B> {
    zzfp() {
    }

    abstract void zza(B b, int i, long j);

    abstract void zza(B b, int i, zzbu zzbuVar);

    abstract void zza(B b, int i, T t);

    abstract void zza(T t, zzgj zzgjVar);

    abstract boolean zza(zzeu zzeuVar);

    final boolean zza(B b, zzeu zzeuVar) throws zzdh {
        int tag = zzeuVar.getTag();
        int i = tag >>> 3;
        switch (tag & 7) {
            case 0:
                zza(b, i, zzeuVar.zzce());
                return true;
            case 1:
                zzb(b, i, zzeuVar.zzcg());
                return true;
            case 2:
                zza((Object) b, i, zzeuVar.zzck());
                return true;
            case 3:
                B bZzfy = zzfy();
                int i2 = (i << 3) | 4;
                while (zzeuVar.zzda() != Integer.MAX_VALUE && zza(bZzfy, zzeuVar)) {
                }
                if (i2 != zzeuVar.getTag()) {
                    throw zzdh.zzeh();
                }
                zza(b, i, zzl(bZzfy));
                return true;
            case 4:
                return false;
            case 5:
                zzc(b, i, zzeuVar.zzch());
                return true;
            default:
                throw zzdh.zzei();
        }
    }

    abstract void zzb(B b, int i, long j);

    abstract void zzc(B b, int i, int i2);

    abstract void zzc(T t, zzgj zzgjVar);

    abstract void zze(Object obj);

    abstract void zze(Object obj, T t);

    abstract void zzf(Object obj, B b);

    abstract B zzfy();

    abstract T zzg(T t, T t2);

    abstract T zzl(B b);

    abstract int zzo(T t);

    abstract T zzr(Object obj);

    abstract B zzs(Object obj);

    abstract int zzt(T t);
}
