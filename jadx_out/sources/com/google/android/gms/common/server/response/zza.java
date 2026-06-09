package com.google.android.gms.common.server.response;

import com.google.android.gms.common.server.response.FastParser;
import java.io.BufferedReader;

/* JADX INFO: loaded from: classes.dex */
final class zza implements FastParser.zza<Integer> {
    zza() {
    }

    @Override // com.google.android.gms.common.server.response.FastParser.zza
    public final /* synthetic */ Integer zzh(FastParser fastParser, BufferedReader bufferedReader) {
        return Integer.valueOf(fastParser.zzd(bufferedReader));
    }
}
