package com.google.android.gms.internal.ads;

import android.annotation.TargetApi;
import android.app.ActivityManager;
import android.app.KeyguardManager;
import android.content.Context;
import android.graphics.Rect;
import android.os.PowerManager;
import android.os.Process;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.widget.EditText;
import android.widget.TextView;
import com.google.android.gms.common.util.PlatformVersion;
import com.google.android.gms.common.util.VisibleForTesting;
import java.util.List;
import javax.annotation.ParametersAreNonnullByDefault;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@ParametersAreNonnullByDefault
@TargetApi(14)
@zzadh
public final class zzgk extends Thread {
    private final zzgf zzahz;
    private final zzadf zzaia;
    private boolean mStarted = false;
    private boolean zzahy = false;
    private boolean zzbm = false;
    private final Object mLock = new Object();
    private final int zzagx = ((Integer) zzkb.zzik().zzd(zznk.zzawl)).intValue();
    private final int zzaic = ((Integer) zzkb.zzik().zzd(zznk.zzawm)).intValue();
    private final int zzagz = ((Integer) zzkb.zzik().zzd(zznk.zzawn)).intValue();
    private final int zzaid = ((Integer) zzkb.zzik().zzd(zznk.zzawo)).intValue();
    private final int zzaie = ((Integer) zzkb.zzik().zzd(zznk.zzawr)).intValue();
    private final int zzaif = ((Integer) zzkb.zzik().zzd(zznk.zzawt)).intValue();
    private final int zzaig = ((Integer) zzkb.zzik().zzd(zznk.zzawu)).intValue();
    private final int zzaib = ((Integer) zzkb.zzik().zzd(zznk.zzawp)).intValue();
    private final String zzaih = (String) zzkb.zzik().zzd(zznk.zzaww);
    private final boolean zzaii = ((Boolean) zzkb.zzik().zzd(zznk.zzawy)).booleanValue();

    public zzgk(zzgf zzgfVar, zzadf zzadfVar) {
        this.zzahz = zzgfVar;
        this.zzaia = zzadfVar;
        setName("ContentFetchTask");
    }

    @VisibleForTesting
    private final zzgo zza(@Nullable View view, zzge zzgeVar) {
        boolean z;
        if (view == null) {
            return new zzgo(this, 0, 0);
        }
        boolean globalVisibleRect = view.getGlobalVisibleRect(new Rect());
        if ((view instanceof TextView) && !(view instanceof EditText)) {
            CharSequence text = ((TextView) view).getText();
            if (TextUtils.isEmpty(text)) {
                return new zzgo(this, 0, 0);
            }
            zzgeVar.zzb(text.toString(), globalVisibleRect, view.getX(), view.getY(), view.getWidth(), view.getHeight());
            return new zzgo(this, 1, 0);
        }
        if ((view instanceof WebView) && !(view instanceof zzaqw)) {
            zzgeVar.zzgs();
            WebView webView = (WebView) view;
            if (PlatformVersion.isAtLeastKitKat()) {
                zzgeVar.zzgs();
                webView.post(new zzgm(this, zzgeVar, webView, globalVisibleRect));
                z = true;
            } else {
                z = false;
            }
            return z ? new zzgo(this, 0, 1) : new zzgo(this, 0, 0);
        }
        if (!(view instanceof ViewGroup)) {
            return new zzgo(this, 0, 0);
        }
        ViewGroup viewGroup = (ViewGroup) view;
        int i = 0;
        int i2 = 0;
        for (int i3 = 0; i3 < viewGroup.getChildCount(); i3++) {
            zzgo zzgoVarZza = zza(viewGroup.getChildAt(i3), zzgeVar);
            i += zzgoVarZza.zzaiq;
            i2 += zzgoVarZza.zzair;
        }
        return new zzgo(this, i, i2);
    }

    @VisibleForTesting
    private static boolean zzgx() {
        List<ActivityManager.RunningAppProcessInfo> runningAppProcesses;
        try {
            Context context = com.google.android.gms.ads.internal.zzbv.zzen().getContext();
            if (context == null) {
                return false;
            }
            ActivityManager activityManager = (ActivityManager) context.getSystemService("activity");
            KeyguardManager keyguardManager = (KeyguardManager) context.getSystemService("keyguard");
            if (activityManager == null || keyguardManager == null || (runningAppProcesses = activityManager.getRunningAppProcesses()) == null) {
                return false;
            }
            for (ActivityManager.RunningAppProcessInfo runningAppProcessInfo : runningAppProcesses) {
                if (Process.myPid() == runningAppProcessInfo.pid) {
                    if (runningAppProcessInfo.importance != 100 || keyguardManager.inKeyguardRestrictedInputMode()) {
                        return false;
                    }
                    PowerManager powerManager = (PowerManager) context.getSystemService("power");
                    return powerManager == null ? false : powerManager.isScreenOn();
                }
            }
            return false;
        } catch (Throwable th) {
            com.google.android.gms.ads.internal.zzbv.zzeo().zza(th, "ContentFetchTask.isInForeground");
            return false;
        }
    }

    private final void zzgz() {
        synchronized (this.mLock) {
            this.zzahy = true;
            boolean z = this.zzahy;
            StringBuilder sb = new StringBuilder(42);
            sb.append("ContentFetchThread: paused, mPause = ");
            sb.append(z);
            zzakb.zzck(sb.toString());
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:43:0x007f A[EXC_TOP_SPLITTER, LOOP:1: B:43:0x007f->B:50:0x007f, LOOP_START, SYNTHETIC] */
    @Override // java.lang.Thread, java.lang.Runnable
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final void run() {
        /*
            r4 = this;
        L0:
            boolean r0 = zzgx()     // Catch: java.lang.Exception -> L68 java.lang.InterruptedException -> L76
            if (r0 == 0) goto L59
            com.google.android.gms.internal.ads.zzgg r0 = com.google.android.gms.ads.internal.zzbv.zzen()     // Catch: java.lang.Exception -> L68 java.lang.InterruptedException -> L76
            android.app.Activity r0 = r0.getActivity()     // Catch: java.lang.Exception -> L68 java.lang.InterruptedException -> L76
            if (r0 != 0) goto L19
            java.lang.String r0 = "ContentFetchThread: no activity. Sleeping."
            com.google.android.gms.internal.ads.zzakb.zzck(r0)     // Catch: java.lang.Exception -> L68 java.lang.InterruptedException -> L76
        L15:
            r4.zzgz()     // Catch: java.lang.Exception -> L68 java.lang.InterruptedException -> L76
            goto L5f
        L19:
            if (r0 == 0) goto L5f
            r1 = 0
            android.view.Window r2 = r0.getWindow()     // Catch: java.lang.Exception -> L3d java.lang.InterruptedException -> L76
            if (r2 == 0) goto L4c
            android.view.Window r2 = r0.getWindow()     // Catch: java.lang.Exception -> L3d java.lang.InterruptedException -> L76
            android.view.View r2 = r2.getDecorView()     // Catch: java.lang.Exception -> L3d java.lang.InterruptedException -> L76
            if (r2 == 0) goto L4c
            android.view.Window r0 = r0.getWindow()     // Catch: java.lang.Exception -> L3d java.lang.InterruptedException -> L76
            android.view.View r0 = r0.getDecorView()     // Catch: java.lang.Exception -> L3d java.lang.InterruptedException -> L76
            r2 = 16908290(0x1020002, float:2.3877235E-38)
            android.view.View r0 = r0.findViewById(r2)     // Catch: java.lang.Exception -> L3d java.lang.InterruptedException -> L76
            r1 = r0
            goto L4c
        L3d:
            r0 = move-exception
            com.google.android.gms.internal.ads.zzajm r2 = com.google.android.gms.ads.internal.zzbv.zzeo()     // Catch: java.lang.Exception -> L68 java.lang.InterruptedException -> L76
            java.lang.String r3 = "ContentFetchTask.extractContent"
            r2.zza(r0, r3)     // Catch: java.lang.Exception -> L68 java.lang.InterruptedException -> L76
            java.lang.String r0 = "Failed getting root view of activity. Content not extracted."
            com.google.android.gms.internal.ads.zzakb.zzck(r0)     // Catch: java.lang.Exception -> L68 java.lang.InterruptedException -> L76
        L4c:
            if (r1 == 0) goto L5f
            if (r1 == 0) goto L5f
            com.google.android.gms.internal.ads.zzgl r0 = new com.google.android.gms.internal.ads.zzgl     // Catch: java.lang.Exception -> L68 java.lang.InterruptedException -> L76
            r0.<init>(r4, r1)     // Catch: java.lang.Exception -> L68 java.lang.InterruptedException -> L76
            r1.post(r0)     // Catch: java.lang.Exception -> L68 java.lang.InterruptedException -> L76
            goto L5f
        L59:
            java.lang.String r0 = "ContentFetchTask: sleeping"
            com.google.android.gms.internal.ads.zzakb.zzck(r0)     // Catch: java.lang.Exception -> L68 java.lang.InterruptedException -> L76
            goto L15
        L5f:
            int r0 = r4.zzaib     // Catch: java.lang.Exception -> L68 java.lang.InterruptedException -> L76
            int r0 = r0 * 1000
            long r0 = (long) r0     // Catch: java.lang.Exception -> L68 java.lang.InterruptedException -> L76
            java.lang.Thread.sleep(r0)     // Catch: java.lang.Exception -> L68 java.lang.InterruptedException -> L76
            goto L7c
        L68:
            r0 = move-exception
            java.lang.String r1 = "Error in ContentFetchTask"
            com.google.android.gms.internal.ads.zzakb.zzb(r1, r0)
            com.google.android.gms.internal.ads.zzadf r1 = r4.zzaia
            java.lang.String r2 = "ContentFetchTask.run"
            r1.zza(r0, r2)
            goto L7c
        L76:
            r0 = move-exception
            java.lang.String r1 = "Error in ContentFetchTask"
            com.google.android.gms.internal.ads.zzakb.zzb(r1, r0)
        L7c:
            java.lang.Object r0 = r4.mLock
            monitor-enter(r0)
        L7f:
            boolean r1 = r4.zzahy     // Catch: java.lang.Throwable -> L91
            if (r1 == 0) goto L8e
            java.lang.String r1 = "ContentFetchTask: waiting"
            com.google.android.gms.internal.ads.zzakb.zzck(r1)     // Catch: java.lang.InterruptedException -> L7f java.lang.Throwable -> L91
            java.lang.Object r1 = r4.mLock     // Catch: java.lang.InterruptedException -> L7f java.lang.Throwable -> L91
            r1.wait()     // Catch: java.lang.InterruptedException -> L7f java.lang.Throwable -> L91
            goto L7f
        L8e:
            monitor-exit(r0)     // Catch: java.lang.Throwable -> L91
            goto L0
        L91:
            r1 = move-exception
            monitor-exit(r0)     // Catch: java.lang.Throwable -> L91
            throw r1
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzgk.run():void");
    }

    public final void wakeup() {
        synchronized (this.mLock) {
            this.zzahy = false;
            this.mLock.notifyAll();
            zzakb.zzck("ContentFetchThread: wakeup");
        }
    }

    @VisibleForTesting
    final void zza(zzge zzgeVar, WebView webView, String str, boolean z) {
        zzgeVar.zzgr();
        try {
            if (!TextUtils.isEmpty(str)) {
                String strOptString = new JSONObject(str).optString("text");
                if (this.zzaii || TextUtils.isEmpty(webView.getTitle())) {
                    zzgeVar.zza(strOptString, z, webView.getX(), webView.getY(), webView.getWidth(), webView.getHeight());
                } else {
                    String title = webView.getTitle();
                    StringBuilder sb = new StringBuilder(String.valueOf(title).length() + 1 + String.valueOf(strOptString).length());
                    sb.append(title);
                    sb.append("\n");
                    sb.append(strOptString);
                    zzgeVar.zza(sb.toString(), z, webView.getX(), webView.getY(), webView.getWidth(), webView.getHeight());
                }
            }
            if (zzgeVar.zzgn()) {
                this.zzahz.zzb(zzgeVar);
            }
        } catch (JSONException unused) {
            zzakb.zzck("Json string may be malformed.");
        } catch (Throwable th) {
            zzakb.zza("Failed to get webview content.", th);
            this.zzaia.zza(th, "ContentFetchTask.processWebViewContent");
        }
    }

    public final void zzgw() {
        synchronized (this.mLock) {
            if (this.mStarted) {
                zzakb.zzck("Content hash thread already started, quiting...");
            } else {
                this.mStarted = true;
                start();
            }
        }
    }

    public final zzge zzgy() {
        return this.zzahz.zzgv();
    }

    public final boolean zzha() {
        return this.zzahy;
    }

    @VisibleForTesting
    final void zzk(View view) {
        try {
            zzge zzgeVar = new zzge(this.zzagx, this.zzaic, this.zzagz, this.zzaid, this.zzaie, this.zzaif, this.zzaig);
            Context context = com.google.android.gms.ads.internal.zzbv.zzen().getContext();
            if (context != null && !TextUtils.isEmpty(this.zzaih)) {
                String str = (String) view.getTag(context.getResources().getIdentifier((String) zzkb.zzik().zzd(zznk.zzawv), "id", context.getPackageName()));
                if (str != null && str.equals(this.zzaih)) {
                    return;
                }
            }
            zzgo zzgoVarZza = zza(view, zzgeVar);
            zzgeVar.zzgt();
            if (zzgoVarZza.zzaiq == 0 && zzgoVarZza.zzair == 0) {
                return;
            }
            if (zzgoVarZza.zzair == 0 && zzgeVar.zzgu() == 0) {
                return;
            }
            if (zzgoVarZza.zzair == 0 && this.zzahz.zza(zzgeVar)) {
                return;
            }
            this.zzahz.zzc(zzgeVar);
        } catch (Exception e) {
            zzakb.zzb("Exception in fetchContentOnUIThread", e);
            this.zzaia.zza(e, "ContentFetchTask.fetchContent");
        }
    }
}
