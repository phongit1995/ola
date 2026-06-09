package com.google.android.gms.internal.firebase_auth;

import java.util.Iterator;
import java.util.NoSuchElementException;

/* JADX INFO: loaded from: classes2.dex */
final class zzbv implements Iterator {
    private final int limit;
    private int position = 0;
    private final /* synthetic */ zzbu zzml;

    zzbv(zzbu zzbuVar) {
        this.zzml = zzbuVar;
        this.limit = this.zzml.size();
    }

    private final byte nextByte() {
        try {
            zzbu zzbuVar = this.zzml;
            int i = this.position;
            this.position = i + 1;
            return zzbuVar.zzk(i);
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
