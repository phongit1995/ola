package com.google.android.gms.common.server.response;

import com.google.android.gms.common.server.response.FastParser;
import java.io.BufferedReader;

/* JADX INFO: loaded from: classes.dex */
final class zze implements FastParser.zza<Boolean> {
    zze() {
    }

    @Override // com.google.android.gms.common.server.response.FastParser.zza
    public final /* synthetic */ Boolean zzh(FastParser fastParser, BufferedReader bufferedReader) {
        return Boolean.valueOf(fastParser.zza(bufferedReader, false));
    }
}
