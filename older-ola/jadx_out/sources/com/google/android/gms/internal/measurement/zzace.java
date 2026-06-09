package com.google.android.gms.internal.measurement;

import com.google.android.gms.internal.measurement.zzacd;
import java.io.IOException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
public final class zzace<M extends zzacd<M>, T> {
    public final int tag;
    private final int type;
    protected final Class<T> zzbze;
    protected final boolean zzbzf;
    private final zzzv<?, ?> zzbzg;

    private zzace(int i, Class<T> cls, int i2, boolean z) {
        this(11, cls, null, 810, false);
    }

    private zzace(int i, Class<T> cls, zzzv<?, ?> zzzvVar, int i2, boolean z) {
        this.type = i;
        this.zzbze = cls;
        this.tag = i2;
        this.zzbzf = false;
        this.zzbzg = null;
    }

    public static <M extends zzacd<M>, T extends zzacj> zzace<M, T> zza(int i, Class<T> cls, long j) {
        return new zzace<>(11, cls, 810, false);
    }

    private final Object zzf(zzaca zzacaVar) {
        Class componentType = this.zzbzf ? this.zzbze.getComponentType() : this.zzbze;
        try {
            switch (this.type) {
                case 10:
                    zzacj zzacjVar = (zzacj) componentType.newInstance();
                    zzacaVar.zza(zzacjVar, this.tag >>> 3);
                    return zzacjVar;
                case 11:
                    zzacj zzacjVar2 = (zzacj) componentType.newInstance();
                    zzacaVar.zza(zzacjVar2);
                    return zzacjVar2;
                default:
                    int i = this.type;
                    StringBuilder sb = new StringBuilder(24);
                    sb.append("Unknown type ");
                    sb.append(i);
                    throw new IllegalArgumentException(sb.toString());
            }
        } catch (IOException e) {
            throw new IllegalArgumentException("Error reading extension field", e);
        } catch (IllegalAccessException e2) {
            String strValueOf = String.valueOf(componentType);
            StringBuilder sb2 = new StringBuilder(String.valueOf(strValueOf).length() + 33);
            sb2.append("Error creating instance of class ");
            sb2.append(strValueOf);
            throw new IllegalArgumentException(sb2.toString(), e2);
        } catch (InstantiationException e3) {
            String strValueOf2 = String.valueOf(componentType);
            StringBuilder sb3 = new StringBuilder(String.valueOf(strValueOf2).length() + 33);
            sb3.append("Error creating instance of class ");
            sb3.append(strValueOf2);
            throw new IllegalArgumentException(sb3.toString(), e3);
        }
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof zzace)) {
            return false;
        }
        zzace zzaceVar = (zzace) obj;
        return this.type == zzaceVar.type && this.zzbze == zzaceVar.zzbze && this.tag == zzaceVar.tag && this.zzbzf == zzaceVar.zzbzf;
    }

    public final int hashCode() {
        return ((((((this.type + 1147) * 31) + this.zzbze.hashCode()) * 31) + this.tag) * 31) + (this.zzbzf ? 1 : 0);
    }

    protected final void zza(Object obj, zzacb zzacbVar) {
        try {
            zzacbVar.zzar(this.tag);
            switch (this.type) {
                case 10:
                    int i = this.tag >>> 3;
                    ((zzacj) obj).zza(zzacbVar);
                    zzacbVar.zzg(i, 4);
                    return;
                case 11:
                    zzacbVar.zzb((zzacj) obj);
                    return;
                default:
                    int i2 = this.type;
                    StringBuilder sb = new StringBuilder(24);
                    sb.append("Unknown type ");
                    sb.append(i2);
                    throw new IllegalArgumentException(sb.toString());
            }
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    final T zzi(List<zzacl> list) {
        if (list == null) {
            return null;
        }
        if (!this.zzbzf) {
            if (list.isEmpty()) {
                return null;
            }
            return this.zzbze.cast(zzf(zzaca.zzi(list.get(list.size() - 1).zzbtj)));
        }
        ArrayList arrayList = new ArrayList();
        for (int i = 0; i < list.size(); i++) {
            zzacl zzaclVar = list.get(i);
            if (zzaclVar.zzbtj.length != 0) {
                arrayList.add(zzf(zzaca.zzi(zzaclVar.zzbtj)));
            }
        }
        int size = arrayList.size();
        if (size == 0) {
            return null;
        }
        T tCast = this.zzbze.cast(Array.newInstance(this.zzbze.getComponentType(), size));
        for (int i2 = 0; i2 < size; i2++) {
            Array.set(tCast, i2, arrayList.get(i2));
        }
        return tCast;
    }

    protected final int zzv(Object obj) {
        int i = this.tag >>> 3;
        switch (this.type) {
            case 10:
                return (zzacb.zzaq(i) << 1) + ((zzacj) obj).zzwb();
            case 11:
                return zzacb.zzb(i, (zzacj) obj);
            default:
                int i2 = this.type;
                StringBuilder sb = new StringBuilder(24);
                sb.append("Unknown type ");
                sb.append(i2);
                throw new IllegalArgumentException(sb.toString());
        }
    }
}
