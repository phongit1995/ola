package com.google.android.gms.internal.measurement;

import android.content.SharedPreferences;
import android.support.annotation.WorkerThread;
import android.util.Pair;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;

/* JADX INFO: loaded from: classes2.dex */
public final class zzfx {
    private final long zzabi;
    private final /* synthetic */ zzft zzamp;

    @VisibleForTesting
    private final String zzamr;
    private final String zzams;
    private final String zzamt;

    private zzfx(zzft zzftVar, String str, long j) {
        this.zzamp = zzftVar;
        Preconditions.checkNotEmpty(str);
        Preconditions.checkArgument(j > 0);
        this.zzamr = String.valueOf(str).concat(":start");
        this.zzams = String.valueOf(str).concat(":count");
        this.zzamt = String.valueOf(str).concat(":value");
        this.zzabi = j;
    }

    @WorkerThread
    private final void zzfh() {
        this.zzamp.zzab();
        long jCurrentTimeMillis = this.zzamp.zzbt().currentTimeMillis();
        SharedPreferences.Editor editorEdit = this.zzamp.zzji().edit();
        editorEdit.remove(this.zzams);
        editorEdit.remove(this.zzamt);
        editorEdit.putLong(this.zzamr, jCurrentTimeMillis);
        editorEdit.apply();
    }

    @WorkerThread
    private final long zzfj() {
        return this.zzamp.zzji().getLong(this.zzamr, 0L);
    }

    @WorkerThread
    public final void zzc(String str, long j) {
        this.zzamp.zzab();
        if (zzfj() == 0) {
            zzfh();
        }
        if (str == null) {
            str = "";
        }
        long j2 = this.zzamp.zzji().getLong(this.zzams, 0L);
        if (j2 <= 0) {
            SharedPreferences.Editor editorEdit = this.zzamp.zzji().edit();
            editorEdit.putString(this.zzamt, str);
            editorEdit.putLong(this.zzams, 1L);
            editorEdit.apply();
            return;
        }
        long j3 = j2 + 1;
        boolean z = (this.zzamp.zzgg().zzlo().nextLong() & Long.MAX_VALUE) < Long.MAX_VALUE / j3;
        SharedPreferences.Editor editorEdit2 = this.zzamp.zzji().edit();
        if (z) {
            editorEdit2.putString(this.zzamt, str);
        }
        editorEdit2.putLong(this.zzams, j3);
        editorEdit2.apply();
    }

    @WorkerThread
    public final Pair<String, Long> zzfi() {
        long jAbs;
        this.zzamp.zzab();
        this.zzamp.zzab();
        long jZzfj = zzfj();
        if (jZzfj == 0) {
            zzfh();
            jAbs = 0;
        } else {
            jAbs = Math.abs(jZzfj - this.zzamp.zzbt().currentTimeMillis());
        }
        if (jAbs < this.zzabi) {
            return null;
        }
        if (jAbs > (this.zzabi << 1)) {
            zzfh();
            return null;
        }
        String string = this.zzamp.zzji().getString(this.zzamt, null);
        long j = this.zzamp.zzji().getLong(this.zzams, 0L);
        zzfh();
        return (string == null || j <= 0) ? zzft.zzalr : new Pair<>(string, Long.valueOf(j));
    }
}
