package com.google.android.gms.common.server.response;

import com.google.android.gms.common.server.response.FastParser;
import java.io.BufferedReader;

/* JADX INFO: loaded from: classes.dex */
final class zzb implements FastParser.zza<Long> {
    zzb() {
    }

    @Override // com.google.android.gms.common.server.response.FastParser.zza
    public final /* synthetic */ Long zzh(FastParser fastParser, BufferedReader bufferedReader) {
        return Long.valueOf(fastParser.zze(bufferedReader));
    }
}
