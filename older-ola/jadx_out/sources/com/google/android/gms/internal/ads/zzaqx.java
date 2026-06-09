package com.google.android.gms.internal.ads;

import android.annotation.TargetApi;
import android.net.Uri;
import android.net.http.SslError;
import android.support.annotation.Nullable;
import android.support.v4.view.ViewCompat;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewTreeObserver;
import android.webkit.SslErrorHandler;
import android.webkit.WebResourceResponse;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import com.google.android.gms.ads.internal.overlay.AdOverlayInfoParcel;
import com.google.android.gms.common.internal.GmsClientSupervisor;
import com.google.android.gms.common.util.Predicate;
import com.google.android.gms.common.util.VisibleForTesting;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;
import javax.annotation.ParametersAreNonnullByDefault;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: loaded from: classes.dex */
@VisibleForTesting
@ParametersAreNonnullByDefault
@zzadh
public class zzaqx extends WebViewClient implements zzasc {
    private static final String[] zzdbo = {"UNKNOWN", "HOST_LOOKUP", "UNSUPPORTED_AUTH_SCHEME", "AUTHENTICATION", "PROXY_AUTHENTICATION", "CONNECT", "IO", "TIMEOUT", "REDIRECT_LOOP", "UNSUPPORTED_SCHEME", "FAILED_SSL_HANDSHAKE", "BAD_URL", "FILE", "FILE_NOT_FOUND", "TOO_MANY_REQUESTS"};
    private static final String[] zzdbp = {"NOT_YET_VALID", "EXPIRED", "ID_MISMATCH", "UNTRUSTED", "DATE_INVALID", "INVALID"};
    private final Object mLock;

    @GuardedBy("mLock")
    private boolean zzaek;
    private zzjd zzapt;
    private com.google.android.gms.ads.internal.gmsg.zzb zzbll;
    private com.google.android.gms.ads.internal.gmsg.zzd zzblm;
    private com.google.android.gms.ads.internal.gmsg.zzz zzbmu;
    private com.google.android.gms.ads.internal.zzx zzbmw;
    private zzaab zzbmx;
    private zzaam zzbmy;
    private com.google.android.gms.ads.internal.overlay.zzt zzbnb;
    private com.google.android.gms.ads.internal.overlay.zzn zzbnc;
    private zzaqw zzbnd;
    private final HashMap<String, List<com.google.android.gms.ads.internal.gmsg.zzv<? super zzaqw>>> zzdbq;
    private zzasd zzdbr;
    private zzase zzdbs;
    private zzasf zzdbt;
    private boolean zzdbu;

    @GuardedBy("mLock")
    private boolean zzdbv;

    @GuardedBy("mLock")
    private ViewTreeObserver.OnGlobalLayoutListener zzdbw;

    @GuardedBy("mLock")
    private ViewTreeObserver.OnScrollChangedListener zzdbx;

    @GuardedBy("mLock")
    private boolean zzdby;
    private final zzaak zzdbz;
    private zzasg zzdca;
    private boolean zzdcb;
    private boolean zzdcc;
    private int zzdcd;
    private View.OnAttachStateChangeListener zzdce;

    @Nullable
    protected zzait zzxd;

    public zzaqx(zzaqw zzaqwVar, boolean z) {
        this(zzaqwVar, z, new zzaak(zzaqwVar, zzaqwVar.zzua(), new zzmw(zzaqwVar.getContext())), null);
    }

    @VisibleForTesting
    private zzaqx(zzaqw zzaqwVar, boolean z, zzaak zzaakVar, zzaab zzaabVar) {
        this.zzdbq = new HashMap<>();
        this.mLock = new Object();
        this.zzdbu = false;
        this.zzbnd = zzaqwVar;
        this.zzaek = z;
        this.zzdbz = zzaakVar;
        this.zzbmx = null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zza(View view, zzait zzaitVar, int i) {
        if (!zzaitVar.zzph() || i <= 0) {
            return;
        }
        zzaitVar.zzr(view);
        if (zzaitVar.zzph()) {
            zzakk.zzcrm.postDelayed(new zzaqz(this, view, zzaitVar, i), 100L);
        }
    }

    private final void zza(AdOverlayInfoParcel adOverlayInfoParcel) {
        boolean zZznf = this.zzbmx != null ? this.zzbmx.zznf() : false;
        com.google.android.gms.ads.internal.zzbv.zzei();
        com.google.android.gms.ads.internal.overlay.zzl.zza(this.zzbnd.getContext(), adOverlayInfoParcel, zZznf ? false : true);
        if (this.zzxd != null) {
            String str = adOverlayInfoParcel.url;
            if (str == null && adOverlayInfoParcel.zzbyl != null) {
                str = adOverlayInfoParcel.zzbyl.url;
            }
            this.zzxd.zzcf(str);
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:10:0x0039  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final void zzd(android.content.Context r8, java.lang.String r9, java.lang.String r10, java.lang.String r11) {
        /*
            r7 = this;
            com.google.android.gms.internal.ads.zzna<java.lang.Boolean> r0 = com.google.android.gms.internal.ads.zznk.zzazy
            com.google.android.gms.internal.ads.zzni r1 = com.google.android.gms.internal.ads.zzkb.zzik()
            java.lang.Object r0 = r1.zzd(r0)
            java.lang.Boolean r0 = (java.lang.Boolean) r0
            boolean r0 = r0.booleanValue()
            if (r0 != 0) goto L13
            return
        L13:
            android.os.Bundle r5 = new android.os.Bundle
            r5.<init>()
            java.lang.String r0 = "err"
            r5.putString(r0, r9)
            java.lang.String r9 = "code"
            r5.putString(r9, r10)
            java.lang.String r9 = "host"
            boolean r10 = android.text.TextUtils.isEmpty(r11)
            if (r10 != 0) goto L39
            android.net.Uri r10 = android.net.Uri.parse(r11)
            java.lang.String r11 = r10.getHost()
            if (r11 == 0) goto L39
            java.lang.String r10 = r10.getHost()
            goto L3b
        L39:
            java.lang.String r10 = ""
        L3b:
            r5.putString(r9, r10)
            com.google.android.gms.internal.ads.zzakk r1 = com.google.android.gms.ads.internal.zzbv.zzek()
            com.google.android.gms.internal.ads.zzaqw r9 = r7.zzbnd
            com.google.android.gms.internal.ads.zzang r9 = r9.zztq()
            java.lang.String r3 = r9.zzcw
            java.lang.String r4 = "gmob-apps"
            r6 = 1
            r2 = r8
            r1.zza(r2, r3, r4, r5, r6)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzaqx.zzd(android.content.Context, java.lang.String, java.lang.String, java.lang.String):void");
    }

    /* JADX WARN: Code restructure failed: missing block: B:40:0x00e5, code lost:
    
        com.google.android.gms.ads.internal.zzbv.zzek();
     */
    /* JADX WARN: Code restructure failed: missing block: B:41:0x00ec, code lost:
    
        return com.google.android.gms.internal.ads.zzakk.zzb(r2);
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final android.webkit.WebResourceResponse zze(java.lang.String r8, java.util.Map<java.lang.String, java.lang.String> r9) throws java.io.IOException {
        /*
            Method dump skipped, instruction units count: 259
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzaqx.zze(java.lang.String, java.util.Map):android.webkit.WebResourceResponse");
    }

    private final void zzi(Uri uri) {
        String path = uri.getPath();
        List<com.google.android.gms.ads.internal.gmsg.zzv<? super zzaqw>> list = this.zzdbq.get(path);
        if (list == null) {
            String strValueOf = String.valueOf(uri);
            StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 32);
            sb.append("No GMSG handler found for GMSG: ");
            sb.append(strValueOf);
            zzakb.v(sb.toString());
            return;
        }
        com.google.android.gms.ads.internal.zzbv.zzek();
        Map<String, String> mapZzg = zzakk.zzg(uri);
        if (zzakb.isLoggable(2)) {
            String strValueOf2 = String.valueOf(path);
            zzakb.v(strValueOf2.length() != 0 ? "Received GMSG: ".concat(strValueOf2) : new String("Received GMSG: "));
            for (String str : mapZzg.keySet()) {
                String str2 = mapZzg.get(str);
                StringBuilder sb2 = new StringBuilder(String.valueOf(str).length() + 4 + String.valueOf(str2).length());
                sb2.append("  ");
                sb2.append(str);
                sb2.append(": ");
                sb2.append(str2);
                zzakb.v(sb2.toString());
            }
        }
        Iterator<com.google.android.gms.ads.internal.gmsg.zzv<? super zzaqw>> it2 = list.iterator();
        while (it2.hasNext()) {
            it2.next().zza(this.zzbnd, mapZzg);
        }
    }

    private final void zzuy() {
        if (this.zzdce == null) {
            return;
        }
        this.zzbnd.getView().removeOnAttachStateChangeListener(this.zzdce);
    }

    private final void zzvd() {
        if (this.zzdbr != null && ((this.zzdcb && this.zzdcd <= 0) || this.zzdcc)) {
            this.zzdbr.zze(!this.zzdcc);
            this.zzdbr = null;
        }
        this.zzbnd.zzup();
    }

    @Override // android.webkit.WebViewClient
    public final void onLoadResource(WebView webView, String str) {
        String strValueOf = String.valueOf(str);
        zzakb.v(strValueOf.length() != 0 ? "Loading resource: ".concat(strValueOf) : new String("Loading resource: "));
        Uri uri = Uri.parse(str);
        if ("gmsg".equalsIgnoreCase(uri.getScheme()) && "mobileads.google.com".equalsIgnoreCase(uri.getHost())) {
            zzi(uri);
        }
    }

    @Override // android.webkit.WebViewClient
    public final void onPageFinished(WebView webView, String str) {
        synchronized (this.mLock) {
            if (this.zzbnd.isDestroyed()) {
                zzakb.v("Blank page loaded, 1...");
                this.zzbnd.zzuk();
                return;
            }
            this.zzdcb = true;
            if (this.zzdbs != null) {
                this.zzdbs.zzly();
                this.zzdbs = null;
            }
            zzvd();
        }
    }

    @Override // android.webkit.WebViewClient
    public final void onReceivedError(WebView webView, int i, String str, String str2) {
        int i2;
        zzd(this.zzbnd.getContext(), "http_err", (i >= 0 || (i2 = (-i) + (-1)) >= zzdbo.length) ? String.valueOf(i) : zzdbo[i2], str2);
        super.onReceivedError(webView, i, str, str2);
    }

    @Override // android.webkit.WebViewClient
    public final void onReceivedSslError(WebView webView, SslErrorHandler sslErrorHandler, SslError sslError) {
        if (sslError != null) {
            int primaryError = sslError.getPrimaryError();
            zzd(this.zzbnd.getContext(), "ssl_err", (primaryError < 0 || primaryError >= zzdbp.length) ? String.valueOf(primaryError) : zzdbp[primaryError], com.google.android.gms.ads.internal.zzbv.zzem().zza(sslError));
        }
        super.onReceivedSslError(webView, sslErrorHandler, sslError);
    }

    public final void reset() {
        if (this.zzxd != null) {
            this.zzxd.zzpj();
            this.zzxd = null;
        }
        zzuy();
        synchronized (this.mLock) {
            this.zzdbq.clear();
            this.zzapt = null;
            this.zzbnc = null;
            this.zzdbr = null;
            this.zzdbs = null;
            this.zzbll = null;
            this.zzblm = null;
            this.zzdbu = false;
            this.zzaek = false;
            this.zzdbv = false;
            this.zzdby = false;
            this.zzbnb = null;
            this.zzdbt = null;
            if (this.zzbmx != null) {
                this.zzbmx.zzm(true);
                this.zzbmx = null;
            }
        }
    }

    @Override // android.webkit.WebViewClient
    @TargetApi(11)
    @Nullable
    public WebResourceResponse shouldInterceptRequest(WebView webView, String str) {
        return zzd(str, Collections.emptyMap());
    }

    @Override // android.webkit.WebViewClient
    public boolean shouldOverrideKeyEvent(WebView webView, KeyEvent keyEvent) {
        int keyCode = keyEvent.getKeyCode();
        if (keyCode == 79 || keyCode == 222) {
            return true;
        }
        switch (keyCode) {
            case 85:
            case 86:
            case 87:
            case 88:
            case 89:
            case 90:
            case 91:
                return true;
            default:
                switch (keyCode) {
                    case 126:
                    case 127:
                    case 128:
                    case GmsClientSupervisor.DEFAULT_BIND_FLAGS /* 129 */:
                    case 130:
                        return true;
                    default:
                        return false;
                }
        }
    }

    @Override // android.webkit.WebViewClient
    public final boolean shouldOverrideUrlLoading(WebView webView, String str) throws zzcj {
        String strValueOf = String.valueOf(str);
        zzakb.v(strValueOf.length() != 0 ? "AdWebView shouldOverrideUrlLoading: ".concat(strValueOf) : new String("AdWebView shouldOverrideUrlLoading: "));
        Uri uriZza = Uri.parse(str);
        if ("gmsg".equalsIgnoreCase(uriZza.getScheme()) && "mobileads.google.com".equalsIgnoreCase(uriZza.getHost())) {
            zzi(uriZza);
            return true;
        }
        if (this.zzdbu && webView == this.zzbnd.getWebView()) {
            String scheme = uriZza.getScheme();
            if ("http".equalsIgnoreCase(scheme) || "https".equalsIgnoreCase(scheme)) {
                if (this.zzapt != null) {
                    if (((Boolean) zzkb.zzik().zzd(zznk.zzaxf)).booleanValue()) {
                        this.zzapt.onAdClicked();
                        if (this.zzxd != null) {
                            this.zzxd.zzcf(str);
                        }
                        this.zzapt = null;
                    }
                }
                return super.shouldOverrideUrlLoading(webView, str);
            }
        }
        if (this.zzbnd.getWebView().willNotDraw()) {
            String strValueOf2 = String.valueOf(str);
            zzakb.zzdk(strValueOf2.length() != 0 ? "AdWebView unable to handle URL: ".concat(strValueOf2) : new String("AdWebView unable to handle URL: "));
            return true;
        }
        try {
            zzci zzciVarZzui = this.zzbnd.zzui();
            if (zzciVarZzui != null && zzciVarZzui.zzb(uriZza)) {
                uriZza = zzciVarZzui.zza(uriZza, this.zzbnd.getContext(), this.zzbnd.getView(), this.zzbnd.zzto());
            }
        } catch (zzcj unused) {
            String strValueOf3 = String.valueOf(str);
            zzakb.zzdk(strValueOf3.length() != 0 ? "Unable to append parameter to URL: ".concat(strValueOf3) : new String("Unable to append parameter to URL: "));
        }
        if (this.zzbmw == null || this.zzbmw.zzcy()) {
            zza(new com.google.android.gms.ads.internal.overlay.zzc("android.intent.action.VIEW", uriZza.toString(), null, null, null, null, null));
            return true;
        }
        this.zzbmw.zzs(str);
        return true;
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final void zza(int i, int i2, boolean z) {
        this.zzdbz.zzc(i, i2);
        if (this.zzbmx != null) {
            this.zzbmx.zza(i, i2, z);
        }
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final void zza(ViewTreeObserver.OnGlobalLayoutListener onGlobalLayoutListener, ViewTreeObserver.OnScrollChangedListener onScrollChangedListener) {
        synchronized (this.mLock) {
            this.zzdbv = true;
            this.zzbnd.zzuo();
            this.zzdbw = onGlobalLayoutListener;
            this.zzdbx = onScrollChangedListener;
        }
    }

    public final void zza(com.google.android.gms.ads.internal.overlay.zzc zzcVar) {
        boolean zZzuj = this.zzbnd.zzuj();
        zza(new AdOverlayInfoParcel(zzcVar, (!zZzuj || this.zzbnd.zzud().zzvs()) ? this.zzapt : null, zZzuj ? null : this.zzbnc, this.zzbnb, this.zzbnd.zztq()));
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final void zza(zzasd zzasdVar) {
        this.zzdbr = zzasdVar;
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final void zza(zzase zzaseVar) {
        this.zzdbs = zzaseVar;
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final void zza(zzasf zzasfVar) {
        this.zzdbt = zzasfVar;
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final void zza(zzasg zzasgVar) {
        this.zzdca = zzasgVar;
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final void zza(zzjd zzjdVar, com.google.android.gms.ads.internal.gmsg.zzb zzbVar, com.google.android.gms.ads.internal.overlay.zzn zznVar, com.google.android.gms.ads.internal.gmsg.zzd zzdVar, com.google.android.gms.ads.internal.overlay.zzt zztVar, boolean z, @Nullable com.google.android.gms.ads.internal.gmsg.zzz zzzVar, com.google.android.gms.ads.internal.zzx zzxVar, zzaam zzaamVar, @Nullable zzait zzaitVar) {
        com.google.android.gms.ads.internal.zzx zzxVar2 = zzxVar == null ? new com.google.android.gms.ads.internal.zzx(this.zzbnd.getContext(), zzaitVar, null) : zzxVar;
        this.zzbmx = new zzaab(this.zzbnd, zzaamVar);
        this.zzxd = zzaitVar;
        if (((Boolean) zzkb.zzik().zzd(zznk.zzayf)).booleanValue()) {
            zza("/adMetadata", new com.google.android.gms.ads.internal.gmsg.zza(zzbVar));
        }
        zza("/appEvent", new com.google.android.gms.ads.internal.gmsg.zzc(zzdVar));
        zza("/backButton", com.google.android.gms.ads.internal.gmsg.zzf.zzblx);
        zza("/refresh", com.google.android.gms.ads.internal.gmsg.zzf.zzbly);
        zza("/canOpenURLs", com.google.android.gms.ads.internal.gmsg.zzf.zzblo);
        zza("/canOpenIntents", com.google.android.gms.ads.internal.gmsg.zzf.zzblp);
        zza("/click", com.google.android.gms.ads.internal.gmsg.zzf.zzblq);
        zza("/close", com.google.android.gms.ads.internal.gmsg.zzf.zzblr);
        zza("/customClose", com.google.android.gms.ads.internal.gmsg.zzf.zzbls);
        zza("/instrument", com.google.android.gms.ads.internal.gmsg.zzf.zzbmb);
        zza("/delayPageLoaded", com.google.android.gms.ads.internal.gmsg.zzf.zzbmd);
        zza("/delayPageClosed", com.google.android.gms.ads.internal.gmsg.zzf.zzbme);
        zza("/getLocationInfo", com.google.android.gms.ads.internal.gmsg.zzf.zzbmf);
        zza("/httpTrack", com.google.android.gms.ads.internal.gmsg.zzf.zzblt);
        zza("/log", com.google.android.gms.ads.internal.gmsg.zzf.zzblu);
        zza("/mraid", new com.google.android.gms.ads.internal.gmsg.zzac(zzxVar2, this.zzbmx, zzaamVar));
        zza("/mraidLoaded", this.zzdbz);
        com.google.android.gms.ads.internal.zzx zzxVar3 = zzxVar2;
        zza("/open", new com.google.android.gms.ads.internal.gmsg.zzad(this.zzbnd.getContext(), this.zzbnd.zztq(), this.zzbnd.zzui(), zztVar, zzjdVar, zzbVar, zzdVar, zznVar, zzxVar2, this.zzbmx));
        zza("/precache", new zzaql());
        zza("/touch", com.google.android.gms.ads.internal.gmsg.zzf.zzblw);
        zza("/video", com.google.android.gms.ads.internal.gmsg.zzf.zzblz);
        zza("/videoMeta", com.google.android.gms.ads.internal.gmsg.zzf.zzbma);
        if (com.google.android.gms.ads.internal.zzbv.zzfh().zzs(this.zzbnd.getContext())) {
            zza("/logScionEvent", new com.google.android.gms.ads.internal.gmsg.zzab(this.zzbnd.getContext()));
        }
        if (zzzVar != null) {
            zza("/setInterstitialProperties", new com.google.android.gms.ads.internal.gmsg.zzy(zzzVar));
        }
        this.zzapt = zzjdVar;
        this.zzbnc = zznVar;
        this.zzbll = zzbVar;
        this.zzblm = zzdVar;
        this.zzbnb = zztVar;
        this.zzbmw = zzxVar3;
        this.zzbmy = zzaamVar;
        this.zzbmu = zzzVar;
        this.zzdbu = z;
    }

    public final void zza(String str, com.google.android.gms.ads.internal.gmsg.zzv<? super zzaqw> zzvVar) {
        synchronized (this.mLock) {
            List<com.google.android.gms.ads.internal.gmsg.zzv<? super zzaqw>> copyOnWriteArrayList = this.zzdbq.get(str);
            if (copyOnWriteArrayList == null) {
                copyOnWriteArrayList = new CopyOnWriteArrayList<>();
                this.zzdbq.put(str, copyOnWriteArrayList);
            }
            copyOnWriteArrayList.add(zzvVar);
        }
    }

    public final void zza(String str, Predicate<com.google.android.gms.ads.internal.gmsg.zzv<? super zzaqw>> predicate) {
        synchronized (this.mLock) {
            List<com.google.android.gms.ads.internal.gmsg.zzv<? super zzaqw>> list = this.zzdbq.get(str);
            if (list == null) {
                return;
            }
            ArrayList arrayList = new ArrayList();
            for (com.google.android.gms.ads.internal.gmsg.zzv<? super zzaqw> zzvVar : list) {
                if (predicate.apply(zzvVar)) {
                    arrayList.add(zzvVar);
                }
            }
            list.removeAll(arrayList);
        }
    }

    public final void zza(boolean z, int i) {
        zza(new AdOverlayInfoParcel((!this.zzbnd.zzuj() || this.zzbnd.zzud().zzvs()) ? this.zzapt : null, this.zzbnc, this.zzbnb, this.zzbnd, z, i, this.zzbnd.zztq()));
    }

    public final void zza(boolean z, int i, String str) {
        boolean zZzuj = this.zzbnd.zzuj();
        zza(new AdOverlayInfoParcel((!zZzuj || this.zzbnd.zzud().zzvs()) ? this.zzapt : null, zZzuj ? null : new zzarb(this.zzbnd, this.zzbnc), this.zzbll, this.zzblm, this.zzbnb, this.zzbnd, z, i, str, this.zzbnd.zztq()));
    }

    public final void zza(boolean z, int i, String str, String str2) {
        boolean zZzuj = this.zzbnd.zzuj();
        zza(new AdOverlayInfoParcel((!zZzuj || this.zzbnd.zzud().zzvs()) ? this.zzapt : null, zZzuj ? null : new zzarb(this.zzbnd, this.zzbnc), this.zzbll, this.zzblm, this.zzbnb, this.zzbnd, z, i, str, str2, this.zzbnd.zztq()));
    }

    public final void zzah(boolean z) {
        this.zzdbu = z;
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final void zzb(int i, int i2) {
        if (this.zzbmx != null) {
            this.zzbmx.zzb(i, i2);
        }
    }

    public final void zzb(String str, com.google.android.gms.ads.internal.gmsg.zzv<? super zzaqw> zzvVar) {
        synchronized (this.mLock) {
            List<com.google.android.gms.ads.internal.gmsg.zzv<? super zzaqw>> list = this.zzdbq.get(str);
            if (list == null) {
                return;
            }
            list.remove(zzvVar);
        }
    }

    @Nullable
    protected final WebResourceResponse zzd(String str, Map<String, String> map) {
        zzhi zzhiVarZza;
        try {
            String strZzb = zzajb.zzb(str, this.zzbnd.getContext());
            if (!strZzb.equals(str)) {
                return zze(strZzb, map);
            }
            zzhl zzhlVarZzaa = zzhl.zzaa(str);
            if (zzhlVarZzaa != null && (zzhiVarZza = com.google.android.gms.ads.internal.zzbv.zzeq().zza(zzhlVarZzaa)) != null && zzhiVarZza.zzhi()) {
                return new WebResourceResponse("", "", zzhiVarZza.zzhj());
            }
            if (zzamy.isEnabled()) {
                if (((Boolean) zzkb.zzik().zzd(zznk.zzazn)).booleanValue()) {
                    return zze(str, map);
                }
            }
            return null;
        } catch (Exception | NoClassDefFoundError e) {
            com.google.android.gms.ads.internal.zzbv.zzeo().zza(e, "AdWebViewClient.interceptRequest");
            return null;
        }
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final boolean zzfz() {
        boolean z;
        synchronized (this.mLock) {
            z = this.zzaek;
        }
        return z;
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final void zznk() {
        synchronized (this.mLock) {
            this.zzdbu = false;
            this.zzaek = true;
            zzaoe.zzcvy.execute(new Runnable(this) { // from class: com.google.android.gms.internal.ads.zzaqy
                private final zzaqx zzdcf;

                {
                    this.zzdcf = this;
                }

                @Override // java.lang.Runnable
                public final void run() {
                    this.zzdcf.zzvg();
                }
            });
        }
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final com.google.android.gms.ads.internal.zzx zzut() {
        return this.zzbmw;
    }

    public final boolean zzuu() {
        boolean z;
        synchronized (this.mLock) {
            z = this.zzdbv;
        }
        return z;
    }

    public final ViewTreeObserver.OnGlobalLayoutListener zzuv() {
        ViewTreeObserver.OnGlobalLayoutListener onGlobalLayoutListener;
        synchronized (this.mLock) {
            onGlobalLayoutListener = this.zzdbw;
        }
        return onGlobalLayoutListener;
    }

    public final ViewTreeObserver.OnScrollChangedListener zzuw() {
        ViewTreeObserver.OnScrollChangedListener onScrollChangedListener;
        synchronized (this.mLock) {
            onScrollChangedListener = this.zzdbx;
        }
        return onScrollChangedListener;
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final boolean zzux() {
        boolean z;
        synchronized (this.mLock) {
            z = this.zzdby;
        }
        return z;
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final void zzuz() {
        zzait zzaitVar = this.zzxd;
        if (zzaitVar != null) {
            WebView webView = this.zzbnd.getWebView();
            if (ViewCompat.isAttachedToWindow(webView)) {
                zza(webView, zzaitVar, 10);
                return;
            }
            zzuy();
            this.zzdce = new zzara(this, zzaitVar);
            this.zzbnd.getView().addOnAttachStateChangeListener(this.zzdce);
        }
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final void zzva() {
        synchronized (this.mLock) {
            this.zzdby = true;
        }
        this.zzdcd++;
        zzvd();
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final void zzvb() {
        this.zzdcd--;
        zzvd();
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final void zzvc() {
        this.zzdcc = true;
        zzvd();
    }

    public final zzasg zzve() {
        return this.zzdca;
    }

    @Override // com.google.android.gms.internal.ads.zzasc
    public final zzait zzvf() {
        return this.zzxd;
    }

    final /* synthetic */ void zzvg() {
        this.zzbnd.zzuo();
        com.google.android.gms.ads.internal.overlay.zzd zzdVarZzub = this.zzbnd.zzub();
        if (zzdVarZzub != null) {
            zzdVarZzub.zznk();
        }
        if (this.zzdbt != null) {
            this.zzdbt.zzdb();
            this.zzdbt = null;
        }
    }
}
