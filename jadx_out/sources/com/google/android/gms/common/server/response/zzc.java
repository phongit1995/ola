package com.google.android.gms.common.server.response;

import com.google.android.gms.common.server.response.FastParser;
import java.io.BufferedReader;

/* JADX INFO: loaded from: classes.dex */
final class zzc implements FastParser.zza<Float> {
    zzc() {
    }

    @Override // com.google.android.gms.common.server.response.FastParser.zza
    public final /* synthetic */ Float zzh(FastParser fastParser, BufferedReader bufferedReader) {
        return Float.valueOf(fastParser.zzg(bufferedReader));
    }
}
