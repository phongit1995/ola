package com.google.android.gms.common.server.response;

import com.google.android.gms.common.server.response.FastParser;
import java.io.BufferedReader;

/* JADX INFO: loaded from: classes.dex */
final class zzf implements FastParser.zza<String> {
    zzf() {
    }

    @Override // com.google.android.gms.common.server.response.FastParser.zza
    public final /* synthetic */ String zzh(FastParser fastParser, BufferedReader bufferedReader) {
        return fastParser.zzc(bufferedReader);
    }
}
