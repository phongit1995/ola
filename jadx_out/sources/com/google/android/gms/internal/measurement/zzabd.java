package com.google.android.gms.internal.measurement;

import java.lang.Comparable;
import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;

/* JADX INFO: loaded from: classes2.dex */
class zzabd<K extends Comparable<K>, V> extends AbstractMap<K, V> {
    private boolean zzbnw;
    private final int zzbwe;
    private List<zzabi> zzbwf;
    private Map<K, V> zzbwg;
    private volatile zzabk zzbwh;
    private Map<K, V> zzbwi;

    private zzabd(int i) {
        this.zzbwe = i;
        this.zzbwf = Collections.emptyList();
        this.zzbwg = Collections.emptyMap();
        this.zzbwi = Collections.emptyMap();
    }

    /* synthetic */ zzabd(int i, zzabe zzabeVar) {
        this(i);
    }

    private final int zza(K k) {
        int size = this.zzbwf.size() - 1;
        if (size >= 0) {
            int iCompareTo = k.compareTo((Comparable) this.zzbwf.get(size).getKey());
            if (iCompareTo > 0) {
                return -(size + 2);
            }
            if (iCompareTo == 0) {
                return size;
            }
        }
        int i = 0;
        while (i <= size) {
            int i2 = (i + size) / 2;
            int iCompareTo2 = k.compareTo((Comparable) this.zzbwf.get(i2).getKey());
            if (iCompareTo2 < 0) {
                size = i2 - 1;
            } else {
                if (iCompareTo2 <= 0) {
                    return i2;
                }
                i = i2 + 1;
            }
        }
        return -(i + 1);
    }

    static <FieldDescriptorType extends zzzt<FieldDescriptorType>> zzabd<FieldDescriptorType, Object> zzag(int i) {
        return new zzabe(i);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final V zzai(int i) {
        zzva();
        V v = (V) this.zzbwf.remove(i).getValue();
        if (!this.zzbwg.isEmpty()) {
            Iterator<Map.Entry<K, V>> it2 = zzvb().entrySet().iterator();
            this.zzbwf.add(new zzabi(this, it2.next()));
            it2.remove();
        }
        return v;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zzva() {
        if (this.zzbnw) {
            throw new UnsupportedOperationException();
        }
    }

    private final SortedMap<K, V> zzvb() {
        zzva();
        if (this.zzbwg.isEmpty() && !(this.zzbwg instanceof TreeMap)) {
            this.zzbwg = new TreeMap();
            this.zzbwi = ((TreeMap) this.zzbwg).descendingMap();
        }
        return (SortedMap) this.zzbwg;
    }

    @Override // java.util.AbstractMap, java.util.Map
    public void clear() {
        zzva();
        if (!this.zzbwf.isEmpty()) {
            this.zzbwf.clear();
        }
        if (this.zzbwg.isEmpty()) {
            return;
        }
        this.zzbwg.clear();
    }

    @Override // java.util.AbstractMap, java.util.Map
    public boolean containsKey(Object obj) {
        Comparable comparable = (Comparable) obj;
        return zza(comparable) >= 0 || this.zzbwg.containsKey(comparable);
    }

    @Override // java.util.AbstractMap, java.util.Map
    public Set<Map.Entry<K, V>> entrySet() {
        if (this.zzbwh == null) {
            this.zzbwh = new zzabk(this, null);
        }
        return this.zzbwh;
    }

    @Override // java.util.AbstractMap, java.util.Map
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof zzabd)) {
            return super.equals(obj);
        }
        zzabd zzabdVar = (zzabd) obj;
        int size = size();
        if (size != zzabdVar.size()) {
            return false;
        }
        int iZzuy = zzuy();
        if (iZzuy != zzabdVar.zzuy()) {
            return entrySet().equals(zzabdVar.entrySet());
        }
        for (int i = 0; i < iZzuy; i++) {
            if (!zzah(i).equals(zzabdVar.zzah(i))) {
                return false;
            }
        }
        if (iZzuy != size) {
            return this.zzbwg.equals(zzabdVar.zzbwg);
        }
        return true;
    }

    @Override // java.util.AbstractMap, java.util.Map
    public V get(Object obj) {
        Comparable comparable = (Comparable) obj;
        int iZza = zza(comparable);
        return iZza >= 0 ? (V) this.zzbwf.get(iZza).getValue() : this.zzbwg.get(comparable);
    }

    @Override // java.util.AbstractMap, java.util.Map
    public int hashCode() {
        int iZzuy = zzuy();
        int iHashCode = 0;
        for (int i = 0; i < iZzuy; i++) {
            iHashCode += this.zzbwf.get(i).hashCode();
        }
        return this.zzbwg.size() > 0 ? iHashCode + this.zzbwg.hashCode() : iHashCode;
    }

    public final boolean isImmutable() {
        return this.zzbnw;
    }

    @Override // java.util.AbstractMap, java.util.Map
    public V remove(Object obj) {
        zzva();
        Comparable comparable = (Comparable) obj;
        int iZza = zza(comparable);
        if (iZza >= 0) {
            return zzai(iZza);
        }
        if (this.zzbwg.isEmpty()) {
            return null;
        }
        return this.zzbwg.remove(comparable);
    }

    @Override // java.util.AbstractMap, java.util.Map
    public int size() {
        return this.zzbwf.size() + this.zzbwg.size();
    }

    /* JADX WARN: Multi-variable type inference failed */
    @Override // java.util.AbstractMap, java.util.Map
    /* JADX INFO: renamed from: zza, reason: merged with bridge method [inline-methods] */
    public final V put(K k, V v) {
        zzva();
        int iZza = zza(k);
        if (iZza >= 0) {
            return (V) this.zzbwf.get(iZza).setValue(v);
        }
        zzva();
        if (this.zzbwf.isEmpty() && !(this.zzbwf instanceof ArrayList)) {
            this.zzbwf = new ArrayList(this.zzbwe);
        }
        int i = -(iZza + 1);
        if (i >= this.zzbwe) {
            return zzvb().put(k, v);
        }
        if (this.zzbwf.size() == this.zzbwe) {
            zzabi zzabiVarRemove = this.zzbwf.remove(this.zzbwe - 1);
            zzvb().put((Comparable) zzabiVarRemove.getKey(), zzabiVarRemove.getValue());
        }
        this.zzbwf.add(i, new zzabi(this, k, v));
        return null;
    }

    public final Map.Entry<K, V> zzah(int i) {
        return this.zzbwf.get(i);
    }

    public void zzru() {
        if (this.zzbnw) {
            return;
        }
        this.zzbwg = this.zzbwg.isEmpty() ? Collections.emptyMap() : Collections.unmodifiableMap(this.zzbwg);
        this.zzbwi = this.zzbwi.isEmpty() ? Collections.emptyMap() : Collections.unmodifiableMap(this.zzbwi);
        this.zzbnw = true;
    }

    public final int zzuy() {
        return this.zzbwf.size();
    }

    public final Iterable<Map.Entry<K, V>> zzuz() {
        return this.zzbwg.isEmpty() ? zzabf.zzvc() : this.zzbwg.entrySet();
    }
}
