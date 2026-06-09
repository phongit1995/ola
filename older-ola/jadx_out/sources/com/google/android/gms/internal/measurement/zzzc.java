package com.google.android.gms.internal.measurement;

import java.util.Iterator;
import java.util.NoSuchElementException;

/* JADX INFO: loaded from: classes2.dex */
final class zzzc implements Iterator {
    private final int limit;
    private int position = 0;
    private final /* synthetic */ zzzb zzbtg;

    zzzc(zzzb zzzbVar) {
        this.zzbtg = zzzbVar;
        this.limit = this.zzbtg.size();
    }

    private final byte nextByte() {
        try {
            zzzb zzzbVar = this.zzbtg;
            int i = this.position;
            this.position = i + 1;
            return zzzbVar.zzae(i);
        } catch (IndexOutOfBoundsException e) {
            throw new NoSuchElementException(e.getMessage());
        }
    }

    @Override // java.util.Iterator
    public final boolean hasNext() {
        return this.position < this.limit;
    }

    @Override // java.util.Iterator
    public final /* synthetic */ Object next() {
        return Byte.valueOf(nextByte());
    }

    @Override // java.util.Iterator
    public final void remove() {
        throw new UnsupportedOperationException();
    }
}
