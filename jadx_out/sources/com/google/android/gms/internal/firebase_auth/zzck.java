package com.google.android.gms.internal.firebase_auth;

import com.google.android.gms.internal.firebase_auth.zzdb;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
final class zzck implements zzgj {
    private final zzci zzmo;

    private zzck(zzci zzciVar) {
        this.zzmo = (zzci) zzdd.zza(zzciVar, "output");
        this.zzmo.zzng = this;
    }

    public static zzck zza(zzci zzciVar) {
        return zzciVar.zzng != null ? zzciVar.zzng : new zzck(zzciVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zza(int i, double d) {
        this.zzmo.zza(i, d);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zza(int i, float f) {
        this.zzmo.zza(i, f);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zza(int i, long j) {
        this.zzmo.zza(i, j);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zza(int i, zzbu zzbuVar) {
        this.zzmo.zza(i, zzbuVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final <K, V> void zza(int i, zzea<K, V> zzeaVar, Map<K, V> map) {
        for (Map.Entry<K, V> entry : map.entrySet()) {
            this.zzmo.zzb(i, 2);
            this.zzmo.zzx(zzdz.zza(zzeaVar, entry.getKey(), entry.getValue()));
            zzdz.zza(this.zzmo, zzeaVar, entry.getKey(), entry.getValue());
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zza(int i, Object obj) {
        if (obj instanceof zzbu) {
            this.zzmo.zzb(i, (zzbu) obj);
        } else {
            this.zzmo.zzb(i, (zzeh) obj);
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zza(int i, Object obj, zzev zzevVar) {
        this.zzmo.zza(i, (zzeh) obj, zzevVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zza(int i, String str) {
        this.zzmo.zza(i, str);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zza(int i, List<String> list) {
        int i2 = 0;
        if (!(list instanceof zzdq)) {
            while (i2 < list.size()) {
                this.zzmo.zza(i, list.get(i2));
                i2++;
            }
            return;
        }
        zzdq zzdqVar = (zzdq) list;
        while (i2 < list.size()) {
            Object raw = zzdqVar.getRaw(i2);
            if (raw instanceof String) {
                this.zzmo.zza(i, (String) raw);
            } else {
                this.zzmo.zza(i, (zzbu) raw);
            }
            i2++;
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zza(int i, List<?> list, zzev zzevVar) {
        for (int i2 = 0; i2 < list.size(); i2++) {
            zza(i, list.get(i2), zzevVar);
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zza(int i, List<Integer> list, boolean z) {
        int i2 = 0;
        if (!z) {
            while (i2 < list.size()) {
                this.zzmo.zzc(i, list.get(i2).intValue());
                i2++;
            }
            return;
        }
        this.zzmo.zzb(i, 2);
        int iZzab = 0;
        for (int i3 = 0; i3 < list.size(); i3++) {
            iZzab += zzci.zzab(list.get(i3).intValue());
        }
        this.zzmo.zzx(iZzab);
        while (i2 < list.size()) {
            this.zzmo.zzw(list.get(i2).intValue());
            i2++;
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzaj(int i) {
        this.zzmo.zzb(i, 3);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzak(int i) {
        this.zzmo.zzb(i, 4);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzb(int i, long j) {
        this.zzmo.zzb(i, j);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzb(int i, Object obj, zzev zzevVar) {
        zzci zzciVar = this.zzmo;
        zzciVar.zzb(i, 3);
        zzevVar.zza((zzeh) obj, zzciVar.zzng);
        zzciVar.zzb(i, 4);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzb(int i, List<zzbu> list) {
        for (int i2 = 0; i2 < list.size(); i2++) {
            this.zzmo.zza(i, list.get(i2));
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzb(int i, List<?> list, zzev zzevVar) {
        for (int i2 = 0; i2 < list.size(); i2++) {
            zzb(i, list.get(i2), zzevVar);
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzb(int i, List<Integer> list, boolean z) {
        int i2 = 0;
        if (!z) {
            while (i2 < list.size()) {
                this.zzmo.zzf(i, list.get(i2).intValue());
                i2++;
            }
            return;
        }
        this.zzmo.zzb(i, 2);
        int iZzae = 0;
        for (int i3 = 0; i3 < list.size(); i3++) {
            iZzae += zzci.zzae(list.get(i3).intValue());
        }
        this.zzmo.zzx(iZzae);
        while (i2 < list.size()) {
            this.zzmo.zzz(list.get(i2).intValue());
            i2++;
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzb(int i, boolean z) {
        this.zzmo.zzb(i, z);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzc(int i, int i2) {
        this.zzmo.zzc(i, i2);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzc(int i, long j) {
        this.zzmo.zzc(i, j);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzc(int i, List<Long> list, boolean z) {
        int i2 = 0;
        if (!z) {
            while (i2 < list.size()) {
                this.zzmo.zza(i, list.get(i2).longValue());
                i2++;
            }
            return;
        }
        this.zzmo.zzb(i, 2);
        int iZzd = 0;
        for (int i3 = 0; i3 < list.size(); i3++) {
            iZzd += zzci.zzd(list.get(i3).longValue());
        }
        this.zzmo.zzx(iZzd);
        while (i2 < list.size()) {
            this.zzmo.zza(list.get(i2).longValue());
            i2++;
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzd(int i, int i2) {
        this.zzmo.zzd(i, i2);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzd(int i, List<Long> list, boolean z) {
        int i2 = 0;
        if (!z) {
            while (i2 < list.size()) {
                this.zzmo.zza(i, list.get(i2).longValue());
                i2++;
            }
            return;
        }
        this.zzmo.zzb(i, 2);
        int iZze = 0;
        for (int i3 = 0; i3 < list.size(); i3++) {
            iZze += zzci.zze(list.get(i3).longValue());
        }
        this.zzmo.zzx(iZze);
        while (i2 < list.size()) {
            this.zzmo.zza(list.get(i2).longValue());
            i2++;
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final int zzdf() {
        return zzdb.zze.zzrp;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zze(int i, int i2) {
        this.zzmo.zze(i, i2);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zze(int i, List<Long> list, boolean z) {
        int i2 = 0;
        if (!z) {
            while (i2 < list.size()) {
                this.zzmo.zzc(i, list.get(i2).longValue());
                i2++;
            }
            return;
        }
        this.zzmo.zzb(i, 2);
        int iZzg = 0;
        for (int i3 = 0; i3 < list.size(); i3++) {
            iZzg += zzci.zzg(list.get(i3).longValue());
        }
        this.zzmo.zzx(iZzg);
        while (i2 < list.size()) {
            this.zzmo.zzc(list.get(i2).longValue());
            i2++;
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzf(int i, int i2) {
        this.zzmo.zzf(i, i2);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzf(int i, List<Float> list, boolean z) {
        int i2 = 0;
        if (!z) {
            while (i2 < list.size()) {
                this.zzmo.zza(i, list.get(i2).floatValue());
                i2++;
            }
            return;
        }
        this.zzmo.zzb(i, 2);
        int iZzb = 0;
        for (int i3 = 0; i3 < list.size(); i3++) {
            iZzb += zzci.zzb(list.get(i3).floatValue());
        }
        this.zzmo.zzx(iZzb);
        while (i2 < list.size()) {
            this.zzmo.zza(list.get(i2).floatValue());
            i2++;
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzg(int i, List<Double> list, boolean z) {
        int i2 = 0;
        if (!z) {
            while (i2 < list.size()) {
                this.zzmo.zza(i, list.get(i2).doubleValue());
                i2++;
            }
            return;
        }
        this.zzmo.zzb(i, 2);
        int iZzb = 0;
        for (int i3 = 0; i3 < list.size(); i3++) {
            iZzb += zzci.zzb(list.get(i3).doubleValue());
        }
        this.zzmo.zzx(iZzb);
        while (i2 < list.size()) {
            this.zzmo.zza(list.get(i2).doubleValue());
            i2++;
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzh(int i, List<Integer> list, boolean z) {
        int i2 = 0;
        if (!z) {
            while (i2 < list.size()) {
                this.zzmo.zzc(i, list.get(i2).intValue());
                i2++;
            }
            return;
        }
        this.zzmo.zzb(i, 2);
        int iZzag = 0;
        for (int i3 = 0; i3 < list.size(); i3++) {
            iZzag += zzci.zzag(list.get(i3).intValue());
        }
        this.zzmo.zzx(iZzag);
        while (i2 < list.size()) {
            this.zzmo.zzw(list.get(i2).intValue());
            i2++;
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzi(int i, long j) {
        this.zzmo.zza(i, j);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzi(int i, List<Boolean> list, boolean z) {
        int i2 = 0;
        if (!z) {
            while (i2 < list.size()) {
                this.zzmo.zzb(i, list.get(i2).booleanValue());
                i2++;
            }
            return;
        }
        this.zzmo.zzb(i, 2);
        int iZzg = 0;
        for (int i3 = 0; i3 < list.size(); i3++) {
            iZzg += zzci.zzg(list.get(i3).booleanValue());
        }
        this.zzmo.zzx(iZzg);
        while (i2 < list.size()) {
            this.zzmo.zzf(list.get(i2).booleanValue());
            i2++;
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzj(int i, long j) {
        this.zzmo.zzc(i, j);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzj(int i, List<Integer> list, boolean z) {
        int i2 = 0;
        if (!z) {
            while (i2 < list.size()) {
                this.zzmo.zzd(i, list.get(i2).intValue());
                i2++;
            }
            return;
        }
        this.zzmo.zzb(i, 2);
        int iZzac = 0;
        for (int i3 = 0; i3 < list.size(); i3++) {
            iZzac += zzci.zzac(list.get(i3).intValue());
        }
        this.zzmo.zzx(iZzac);
        while (i2 < list.size()) {
            this.zzmo.zzx(list.get(i2).intValue());
            i2++;
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzk(int i, List<Integer> list, boolean z) {
        int i2 = 0;
        if (!z) {
            while (i2 < list.size()) {
                this.zzmo.zzf(i, list.get(i2).intValue());
                i2++;
            }
            return;
        }
        this.zzmo.zzb(i, 2);
        int iZzaf = 0;
        for (int i3 = 0; i3 < list.size(); i3++) {
            iZzaf += zzci.zzaf(list.get(i3).intValue());
        }
        this.zzmo.zzx(iZzaf);
        while (i2 < list.size()) {
            this.zzmo.zzz(list.get(i2).intValue());
            i2++;
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzl(int i, List<Long> list, boolean z) {
        int i2 = 0;
        if (!z) {
            while (i2 < list.size()) {
                this.zzmo.zzc(i, list.get(i2).longValue());
                i2++;
            }
            return;
        }
        this.zzmo.zzb(i, 2);
        int iZzh = 0;
        for (int i3 = 0; i3 < list.size(); i3++) {
            iZzh += zzci.zzh(list.get(i3).longValue());
        }
        this.zzmo.zzx(iZzh);
        while (i2 < list.size()) {
            this.zzmo.zzc(list.get(i2).longValue());
            i2++;
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzm(int i, int i2) {
        this.zzmo.zzf(i, i2);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzm(int i, List<Integer> list, boolean z) {
        int i2 = 0;
        if (!z) {
            while (i2 < list.size()) {
                this.zzmo.zze(i, list.get(i2).intValue());
                i2++;
            }
            return;
        }
        this.zzmo.zzb(i, 2);
        int iZzad = 0;
        for (int i3 = 0; i3 < list.size(); i3++) {
            iZzad += zzci.zzad(list.get(i3).intValue());
        }
        this.zzmo.zzx(iZzad);
        while (i2 < list.size()) {
            this.zzmo.zzy(list.get(i2).intValue());
            i2++;
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzn(int i, int i2) {
        this.zzmo.zzc(i, i2);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgj
    public final void zzn(int i, List<Long> list, boolean z) {
        int i2 = 0;
        if (!z) {
            while (i2 < list.size()) {
                this.zzmo.zzb(i, list.get(i2).longValue());
                i2++;
            }
            return;
        }
        this.zzmo.zzb(i, 2);
        int iZzf = 0;
        for (int i3 = 0; i3 < list.size(); i3++) {
            iZzf += zzci.zzf(list.get(i3).longValue());
        }
        this.zzmo.zzx(iZzf);
        while (i2 < list.size()) {
            this.zzmo.zzb(list.get(i2).longValue());
            i2++;
        }
    }
}
