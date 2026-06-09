package com.google.android.gms.internal.measurement;

import android.content.SharedPreferences;
import android.support.annotation.WorkerThread;
import com.google.android.gms.common.internal.Preconditions;

/* JADX INFO: loaded from: classes2.dex */
public final class zzfw {
    private long value;
    private boolean zzamo;
    private final /* synthetic */ zzft zzamp;
    private final long zzamq;
    private final String zzny;

    public zzfw(zzft zzftVar, String str, long j) {
        this.zzamp = zzftVar;
        Preconditions.checkNotEmpty(str);
        this.zzny = str;
        this.zzamq = j;
    }

    @WorkerThread
    public final long get() {
        if (!this.zzamo) {
            this.zzamo = true;
            this.value = this.zzamp.zzji().getLong(this.zzny, this.zzamq);
        }
        return this.value;
    }

    @WorkerThread
    public final void set(long j) {
        SharedPreferences.Editor editorEdit = this.zzamp.zzji().edit();
        editorEdit.putLong(this.zzny, j);
        editorEdit.apply();
        this.value = j;
    }
}
