package com.google.android.gms.internal.firebase_auth;

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
class zzey<K extends Comparable<K>, V> extends AbstractMap<K, V> {
    private boolean zzob;
    private final int zzuk;
    private List<zzff> zzul;
    private Map<K, V> zzum;
    private volatile zzfh zzun;
    private Map<K, V> zzuo;
    private volatile zzfb zzup;

    private zzey(int i) {
        this.zzuk = i;
        this.zzul = Collections.emptyList();
        this.zzum = Collections.emptyMap();
        this.zzuo = Collections.emptyMap();
    }

    /* synthetic */ zzey(int i, zzez zzezVar) {
        this(i);
    }

    private final int zza(K k) {
        int size = this.zzul.size() - 1;
        if (size >= 0) {
            int iCompareTo = k.compareTo((Comparable) this.zzul.get(size).getKey());
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
            int iCompareTo2 = k.compareTo((Comparable) this.zzul.get(i2).getKey());
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

    static <FieldDescriptorType extends zzcu<FieldDescriptorType>> zzey<FieldDescriptorType, Object> zzat(int i) {
        return new zzez(i);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final V zzav(int i) {
        zzfr();
        V v = (V) this.zzul.remove(i).getValue();
        if (!this.zzum.isEmpty()) {
            Iterator<Map.Entry<K, V>> it2 = zzfs().entrySet().iterator();
            this.zzul.add(new zzff(this, it2.next()));
            it2.remove();
        }
        return v;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zzfr() {
        if (this.zzob) {
            throw new UnsupportedOperationException();
        }
    }

    private final SortedMap<K, V> zzfs() {
        zzfr();
        if (this.zzum.isEmpty() && !(this.zzum instanceof TreeMap)) {
            this.zzum = new TreeMap();
            this.zzuo = ((TreeMap) this.zzum).descendingMap();
        }
        return (SortedMap) this.zzum;
    }

    @Override // java.util.AbstractMap, java.util.Map
    public void clear() {
        zzfr();
        if (!this.zzul.isEmpty()) {
            this.zzul.clear();
        }
        if (this.zzum.isEmpty()) {
            return;
        }
        this.zzum.clear();
    }

    @Override // java.util.AbstractMap, java.util.Map
    public boolean containsKey(Object obj) {
        Comparable comparable = (Comparable) obj;
        return zza(comparable) >= 0 || this.zzum.containsKey(comparable);
    }

    @Override // java.util.AbstractMap, java.util.Map
    public Set<Map.Entry<K, V>> entrySet() {
        if (this.zzun == null) {
            this.zzun = new zzfh(this, null);
        }
        return this.zzun;
    }

    @Override // java.util.AbstractMap, java.util.Map
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof zzey)) {
            return super.equals(obj);
        }
        zzey zzeyVar = (zzey) obj;
        int size = size();
        if (size != zzeyVar.size()) {
            return false;
        }
        int iZzfo = zzfo();
        if (iZzfo != zzeyVar.zzfo()) {
            return entrySet().equals(zzeyVar.entrySet());
        }
        for (int i = 0; i < iZzfo; i++) {
            if (!zzau(i).equals(zzeyVar.zzau(i))) {
                return false;
            }
        }
        if (iZzfo != size) {
            return this.zzum.equals(zzeyVar.zzum);
        }
        return true;
    }

    @Override // java.util.AbstractMap, java.util.Map
    public V get(Object obj) {
        Comparable comparable = (Comparable) obj;
        int iZza = zza(comparable);
        return iZza >= 0 ? (V) this.zzul.get(iZza).getValue() : this.zzum.get(comparable);
    }

    @Override // java.util.AbstractMap, java.util.Map
    public int hashCode() {
        int iZzfo = zzfo();
        int iHashCode = 0;
        for (int i = 0; i < iZzfo; i++) {
            iHashCode += this.zzul.get(i).hashCode();
        }
        return this.zzum.size() > 0 ? iHashCode + this.zzum.hashCode() : iHashCode;
    }

    public final boolean isImmutable() {
        return this.zzob;
    }

    @Override // java.util.AbstractMap, java.util.Map
    public V remove(Object obj) {
        zzfr();
        Comparable comparable = (Comparable) obj;
        int iZza = zza(comparable);
        if (iZza >= 0) {
            return zzav(iZza);
        }
        if (this.zzum.isEmpty()) {
            return null;
        }
        return this.zzum.remove(comparable);
    }

    @Override // java.util.AbstractMap, java.util.Map
    public int size() {
        return this.zzul.size() + this.zzum.size();
    }

    /* JADX WARN: Multi-variable type inference failed */
    @Override // java.util.AbstractMap, java.util.Map
    /* JADX INFO: renamed from: zza, reason: merged with bridge method [inline-methods] */
    public final V put(K k, V v) {
        zzfr();
        int iZza = zza(k);
        if (iZza >= 0) {
            return (V) this.zzul.get(iZza).setValue(v);
        }
        zzfr();
        if (this.zzul.isEmpty() && !(this.zzul instanceof ArrayList)) {
            this.zzul = new ArrayList(this.zzuk);
        }
        int i = -(iZza + 1);
        if (i >= this.zzuk) {
            return zzfs().put(k, v);
        }
        if (this.zzul.size() == this.zzuk) {
            zzff zzffVarRemove = this.zzul.remove(this.zzuk - 1);
            zzfs().put((Comparable) zzffVarRemove.getKey(), zzffVarRemove.getValue());
        }
        this.zzul.add(i, new zzff(this, k, v));
        return null;
    }

    public final Map.Entry<K, V> zzau(int i) {
        return this.zzul.get(i);
    }

    public void zzbs() {
        if (this.zzob) {
            return;
        }
        this.zzum = this.zzum.isEmpty() ? Collections.emptyMap() : Collections.unmodifiableMap(this.zzum);
        this.zzuo = this.zzuo.isEmpty() ? Collections.emptyMap() : Collections.unmodifiableMap(this.zzuo);
        this.zzob = true;
    }

    public final int zzfo() {
        return this.zzul.size();
    }

    public final Iterable<Map.Entry<K, V>> zzfp() {
        return this.zzum.isEmpty() ? zzfc.zzfu() : this.zzum.entrySet();
    }

    final Set<Map.Entry<K, V>> zzfq() {
        if (this.zzup == null) {
            this.zzup = new zzfb(this, null);
        }
        return this.zzup;
    }
}
