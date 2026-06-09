package com.google.android.gms.common.server.response;

import com.google.android.gms.common.server.response.FastParser;
import java.io.BufferedReader;
import java.math.BigInteger;

/* JADX INFO: loaded from: classes.dex */
final class zzg implements FastParser.zza<BigInteger> {
    zzg() {
    }

    @Override // com.google.android.gms.common.server.response.FastParser.zza
    public final /* synthetic */ BigInteger zzh(FastParser fastParser, BufferedReader bufferedReader) {
        return fastParser.zzf(bufferedReader);
    }
}
