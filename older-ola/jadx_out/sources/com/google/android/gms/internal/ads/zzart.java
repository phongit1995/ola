package com.google.android.gms.internal.ads;

import android.annotation.TargetApi;
import android.webkit.WebResourceResponse;
import android.webkit.WebView;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
@TargetApi(11)
@zzadh
public final class zzart extends zzaru {
    public zzart(zzaqw zzaqwVar, boolean z) {
        super(zzaqwVar, z);
    }

    @Override // com.google.android.gms.internal.ads.zzaqx, android.webkit.WebViewClient
    public final WebResourceResponse shouldInterceptRequest(WebView webView, String str) {
        return zza(webView, str, (Map<String, String>) null);
    }
}
