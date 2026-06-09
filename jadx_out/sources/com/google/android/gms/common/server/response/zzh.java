package com.google.android.gms.common.server.response;

import com.google.android.gms.common.server.response.FastParser;
import java.io.BufferedReader;
import java.math.BigDecimal;

/* JADX INFO: loaded from: classes.dex */
final class zzh implements FastParser.zza<BigDecimal> {
    zzh() {
    }

    @Override // com.google.android.gms.common.server.response.FastParser.zza
    public final /* synthetic */ BigDecimal zzh(FastParser fastParser, BufferedReader bufferedReader) {
        return fastParser.zzi(bufferedReader);
    }
}
