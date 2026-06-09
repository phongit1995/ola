package com.google.android.gms.ads.internal.overlay;

import android.app.Activity;
import android.content.Intent;
import android.content.res.Configuration;
import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.view.ViewCompat;
import android.view.View;
import android.webkit.WebChromeClient;
import android.widget.FrameLayout;
import android.widget.RelativeLayout;
import com.google.android.gms.ads.internal.zzbv;
import com.google.android.gms.common.util.PlatformVersion;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.dynamic.IObjectWrapper;
import com.google.android.gms.dynamic.ObjectWrapper;
import com.google.android.gms.internal.ads.zzaal;
import com.google.android.gms.internal.ads.zzaaq;
import com.google.android.gms.internal.ads.zzadh;
import com.google.android.gms.internal.ads.zzakb;
import com.google.android.gms.internal.ads.zzakk;
import com.google.android.gms.internal.ads.zzakq;
import com.google.android.gms.internal.ads.zzaqw;
import com.google.android.gms.internal.ads.zzkb;
import com.google.android.gms.internal.ads.zznk;
import java.util.Collections;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public class zzd extends zzaaq implements zzw {

    @VisibleForTesting
    private static final int zzbxm = Color.argb(0, 0, 0, 0);
    protected final Activity mActivity;

    @VisibleForTesting
    zzaqw zzbnd;

    @VisibleForTesting
    AdOverlayInfoParcel zzbxn;

    @VisibleForTesting
    private zzi zzbxo;

    @VisibleForTesting
    private zzo zzbxp;

    @VisibleForTesting
    private FrameLayout zzbxr;

    @VisibleForTesting
    private WebChromeClient.CustomViewCallback zzbxs;

    @VisibleForTesting
    private zzh zzbxv;
    private Runnable zzbxz;
    private boolean zzbya;
    private boolean zzbyb;

    @VisibleForTesting
    private boolean zzbxq = false;

    @VisibleForTesting
    private boolean zzbxt = false;

    @VisibleForTesting
    private boolean zzbxu = false;

    @VisibleForTesting
    private boolean zzbxw = false;

    @VisibleForTesting
    int zzbxx = 0;
    private final Object zzbxy = new Object();
    private boolean zzbyc = false;
    private boolean zzbyd = false;
    private boolean zzbye = true;

    public zzd(Activity activity) {
        this.mActivity = activity;
    }

    private final void zznl() {
        if (!this.mActivity.isFinishing() || this.zzbyc) {
            return;
        }
        this.zzbyc = true;
        if (this.zzbnd != null) {
            this.zzbnd.zzai(this.zzbxx);
            synchronized (this.zzbxy) {
                if (!this.zzbya && this.zzbnd.zzun()) {
                    this.zzbxz = new zzf(this);
                    zzakk.zzcrm.postDelayed(this.zzbxz, ((Long) zzkb.zzik().zzd(zznk.zzayq)).longValue());
                    return;
                }
            }
        }
        zznm();
    }

    private final void zzno() {
        this.zzbnd.zzno();
    }

    private final void zzs(boolean z) {
        int iIntValue = ((Integer) zzkb.zzik().zzd(zznk.zzben)).intValue();
        zzp zzpVar = new zzp();
        zzpVar.size = 50;
        zzpVar.paddingLeft = z ? iIntValue : 0;
        zzpVar.paddingRight = z ? 0 : iIntValue;
        zzpVar.paddingTop = 0;
        zzpVar.paddingBottom = iIntValue;
        this.zzbxp = new zzo(this.mActivity, zzpVar, this);
        RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(-2, -2);
        layoutParams.addRule(10);
        layoutParams.addRule(z ? 11 : 9);
        zza(z, this.zzbxn.zzbyr);
        this.zzbxv.addView(this.zzbxp, layoutParams);
    }

    /* JADX WARN: Removed duplicated region for block: B:14:0x0048  */
    /* JADX WARN: Removed duplicated region for block: B:47:0x00d0  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final void zzt(boolean r20) throws com.google.android.gms.ads.internal.overlay.zzg {
        /*
            Method dump skipped, instruction units count: 619
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.ads.internal.overlay.zzd.zzt(boolean):void");
    }

    public final void close() {
        this.zzbxx = 2;
        this.mActivity.finish();
    }

    @Override // com.google.android.gms.internal.ads.zzaap
    public final void onActivityResult(int i, int i2, Intent intent) {
    }

    @Override // com.google.android.gms.internal.ads.zzaap
    public final void onBackPressed() {
        this.zzbxx = 0;
    }

    @Override // com.google.android.gms.internal.ads.zzaap
    public void onCreate(Bundle bundle) {
        this.mActivity.requestWindowFeature(1);
        this.zzbxt = bundle != null ? bundle.getBoolean("com.google.android.gms.ads.internal.overlay.hasResumed", false) : false;
        try {
            this.zzbxn = AdOverlayInfoParcel.zzc(this.mActivity.getIntent());
            if (this.zzbxn == null) {
                throw new zzg("Could not get info for ad overlay.");
            }
            if (this.zzbxn.zzacr.zzcvf > 7500000) {
                this.zzbxx = 3;
            }
            if (this.mActivity.getIntent() != null) {
                this.zzbye = this.mActivity.getIntent().getBooleanExtra("shouldCallOnOverlayOpened", true);
            }
            if (this.zzbxn.zzbyw != null) {
                this.zzbxu = this.zzbxn.zzbyw.zzze;
            } else {
                this.zzbxu = false;
            }
            if (((Boolean) zzkb.zzik().zzd(zznk.zzbbg)).booleanValue() && this.zzbxu && this.zzbxn.zzbyw.zzzj != -1) {
                new zzj(this, null).zzqo();
            }
            if (bundle == null) {
                if (this.zzbxn.zzbyn != null && this.zzbye) {
                    this.zzbxn.zzbyn.zzcc();
                }
                if (this.zzbxn.zzbyu != 1 && this.zzbxn.zzbym != null) {
                    this.zzbxn.zzbym.onAdClicked();
                }
            }
            this.zzbxv = new zzh(this.mActivity, this.zzbxn.zzbyv, this.zzbxn.zzacr.zzcw);
            this.zzbxv.setId(1000);
            switch (this.zzbxn.zzbyu) {
                case 1:
                    zzt(false);
                    return;
                case 2:
                    this.zzbxo = new zzi(this.zzbxn.zzbyo);
                    zzt(false);
                    return;
                case 3:
                    zzt(true);
                    return;
                default:
                    throw new zzg("Could not determine ad overlay type.");
            }
        } catch (zzg e) {
            zzakb.zzdk(e.getMessage());
            this.zzbxx = 3;
            this.mActivity.finish();
        }
    }

    @Override // com.google.android.gms.internal.ads.zzaap
    public final void onDestroy() {
        if (this.zzbnd != null) {
            this.zzbxv.removeView(this.zzbnd.getView());
        }
        zznl();
    }

    @Override // com.google.android.gms.internal.ads.zzaap
    public final void onPause() {
        zznh();
        if (this.zzbxn.zzbyn != null) {
            this.zzbxn.zzbyn.onPause();
        }
        if (!((Boolean) zzkb.zzik().zzd(zznk.zzbem)).booleanValue() && this.zzbnd != null && (!this.mActivity.isFinishing() || this.zzbxo == null)) {
            zzbv.zzem();
            zzakq.zzi(this.zzbnd);
        }
        zznl();
    }

    @Override // com.google.android.gms.internal.ads.zzaap
    public final void onRestart() {
    }

    @Override // com.google.android.gms.internal.ads.zzaap
    public final void onResume() {
        if (this.zzbxn.zzbyn != null) {
            this.zzbxn.zzbyn.onResume();
        }
        if (((Boolean) zzkb.zzik().zzd(zznk.zzbem)).booleanValue()) {
            return;
        }
        if (this.zzbnd == null || this.zzbnd.isDestroyed()) {
            zzakb.zzdk("The webview does not exist. Ignoring action.");
        } else {
            zzbv.zzem();
            zzakq.zzj(this.zzbnd);
        }
    }

    @Override // com.google.android.gms.internal.ads.zzaap
    public final void onSaveInstanceState(Bundle bundle) {
        bundle.putBoolean("com.google.android.gms.ads.internal.overlay.hasResumed", this.zzbxt);
    }

    @Override // com.google.android.gms.internal.ads.zzaap
    public final void onStart() {
        if (((Boolean) zzkb.zzik().zzd(zznk.zzbem)).booleanValue()) {
            if (this.zzbnd == null || this.zzbnd.isDestroyed()) {
                zzakb.zzdk("The webview does not exist. Ignoring action.");
            } else {
                zzbv.zzem();
                zzakq.zzj(this.zzbnd);
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzaap
    public final void onStop() {
        if (((Boolean) zzkb.zzik().zzd(zznk.zzbem)).booleanValue() && this.zzbnd != null && (!this.mActivity.isFinishing() || this.zzbxo == null)) {
            zzbv.zzem();
            zzakq.zzi(this.zzbnd);
        }
        zznl();
    }

    public final void setRequestedOrientation(int i) {
        if (this.mActivity.getApplicationInfo().targetSdkVersion >= ((Integer) zzkb.zzik().zzd(zznk.zzbfs)).intValue()) {
            if (this.mActivity.getApplicationInfo().targetSdkVersion <= ((Integer) zzkb.zzik().zzd(zznk.zzbft)).intValue()) {
                if (Build.VERSION.SDK_INT >= ((Integer) zzkb.zzik().zzd(zznk.zzbfu)).intValue()) {
                    if (Build.VERSION.SDK_INT <= ((Integer) zzkb.zzik().zzd(zznk.zzbfv)).intValue()) {
                        return;
                    }
                }
            }
        }
        this.mActivity.setRequestedOrientation(i);
    }

    public final void zza(View view, WebChromeClient.CustomViewCallback customViewCallback) {
        this.zzbxr = new FrameLayout(this.mActivity);
        this.zzbxr.setBackgroundColor(ViewCompat.MEASURED_STATE_MASK);
        this.zzbxr.addView(view, -1, -1);
        this.mActivity.setContentView(this.zzbxr);
        this.zzbyb = true;
        this.zzbxs = customViewCallback;
        this.zzbxq = true;
    }

    public final void zza(boolean z, boolean z2) {
        boolean z3 = false;
        boolean z4 = ((Boolean) zzkb.zzik().zzd(zznk.zzays)).booleanValue() && this.zzbxn != null && this.zzbxn.zzbyw != null && this.zzbxn.zzbyw.zzzl;
        boolean z5 = ((Boolean) zzkb.zzik().zzd(zznk.zzayt)).booleanValue() && this.zzbxn != null && this.zzbxn.zzbyw != null && this.zzbxn.zzbyw.zzzm;
        if (z && z2 && z4 && !z5) {
            new zzaal(this.zzbnd, "useCustomClose").zzbw("Custom close has been disabled for interstitial ads in this ad slot.");
        }
        if (this.zzbxp != null) {
            zzo zzoVar = this.zzbxp;
            if (z5 || (z2 && !z4)) {
                z3 = true;
            }
            zzoVar.zzu(z3);
        }
    }

    @Override // com.google.android.gms.internal.ads.zzaap
    public final void zzax() {
        this.zzbyb = true;
    }

    public final void zznh() {
        if (this.zzbxn != null && this.zzbxq) {
            setRequestedOrientation(this.zzbxn.orientation);
        }
        if (this.zzbxr != null) {
            this.mActivity.setContentView(this.zzbxv);
            this.zzbyb = true;
            this.zzbxr.removeAllViews();
            this.zzbxr = null;
        }
        if (this.zzbxs != null) {
            this.zzbxs.onCustomViewHidden();
            this.zzbxs = null;
        }
        this.zzbxq = false;
    }

    @Override // com.google.android.gms.ads.internal.overlay.zzw
    public final void zzni() {
        this.zzbxx = 1;
        this.mActivity.finish();
    }

    @Override // com.google.android.gms.internal.ads.zzaap
    public final boolean zznj() {
        this.zzbxx = 0;
        if (this.zzbnd == null) {
            return true;
        }
        boolean zZzul = this.zzbnd.zzul();
        if (!zZzul) {
            this.zzbnd.zza("onbackblocked", Collections.emptyMap());
        }
        return zZzul;
    }

    public final void zznk() {
        this.zzbxv.removeView(this.zzbxp);
        zzs(true);
    }

    @VisibleForTesting
    final void zznm() {
        if (this.zzbyd) {
            return;
        }
        this.zzbyd = true;
        if (this.zzbnd != null) {
            this.zzbxv.removeView(this.zzbnd.getView());
            if (this.zzbxo != null) {
                this.zzbnd.zzbm(this.zzbxo.zzrt);
                this.zzbnd.zzai(false);
                this.zzbxo.parent.addView(this.zzbnd.getView(), this.zzbxo.index, this.zzbxo.zzbyi);
                this.zzbxo = null;
            } else if (this.mActivity.getApplicationContext() != null) {
                this.zzbnd.zzbm(this.mActivity.getApplicationContext());
            }
            this.zzbnd = null;
        }
        if (this.zzbxn == null || this.zzbxn.zzbyn == null) {
            return;
        }
        this.zzbxn.zzbyn.zzcb();
    }

    public final void zznn() {
        if (this.zzbxw) {
            this.zzbxw = false;
            zzno();
        }
    }

    public final void zznp() {
        this.zzbxv.zzbyh = true;
    }

    public final void zznq() {
        synchronized (this.zzbxy) {
            this.zzbya = true;
            if (this.zzbxz != null) {
                zzakk.zzcrm.removeCallbacks(this.zzbxz);
                zzakk.zzcrm.post(this.zzbxz);
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzaap
    public final void zzo(IObjectWrapper iObjectWrapper) {
        if (((Boolean) zzkb.zzik().zzd(zznk.zzbel)).booleanValue() && PlatformVersion.isAtLeastN()) {
            Configuration configuration = (Configuration) ObjectWrapper.unwrap(iObjectWrapper);
            zzbv.zzek();
            if (zzakk.zza(this.mActivity, configuration)) {
                this.mActivity.getWindow().addFlags(1024);
                this.mActivity.getWindow().clearFlags(2048);
            } else {
                this.mActivity.getWindow().addFlags(2048);
                this.mActivity.getWindow().clearFlags(1024);
            }
        }
    }
}
