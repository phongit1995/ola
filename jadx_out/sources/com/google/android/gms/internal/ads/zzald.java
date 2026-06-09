package com.google.android.gms.internal.ads;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Handler;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import android.util.Log;
import android.view.MotionEvent;
import android.view.ViewConfiguration;
import android.view.WindowManager;
import com.google.ads.AdRequest;
import com.google.android.gms.common.util.VisibleForTesting;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzald {
    private Handler handler;
    private final Context mContext;
    private int state;
    private String zzaej;
    private final float zzbwx;

    @Nullable
    private String zzchz;
    private String zzcrx;
    private float zzcry;
    private float zzcrz;
    private float zzcsa;
    private int zzcsb;
    private float zzcsc;
    private float zzcsd;
    private float zzcse;
    private float zzcsf;
    private Runnable zzcsg;
    private String zzye;

    public zzald(Context context) {
        this.state = 0;
        this.zzcsg = new Runnable(this) { // from class: com.google.android.gms.internal.ads.zzale
            private final zzald zzcsh;

            {
                this.zzcsh = this;
            }

            @Override // java.lang.Runnable
            public final void run() {
                this.zzcsh.zzrv();
            }
        };
        this.mContext = context;
        this.zzbwx = context.getResources().getDisplayMetrics().density;
        this.zzcsb = ViewConfiguration.get(this.mContext).getScaledTouchSlop();
        com.google.android.gms.ads.internal.zzbv.zzez().zzsa();
        this.handler = com.google.android.gms.ads.internal.zzbv.zzez().getHandler();
    }

    public zzald(Context context, String str) {
        this(context);
        this.zzcrx = str;
    }

    private static int zza(List<String> list, String str, boolean z) {
        if (!z) {
            return -1;
        }
        list.add(str);
        return list.size() - 1;
    }

    @VisibleForTesting
    private final void zza(int i, float f, float f2) {
        if (i == 0) {
            this.state = 0;
            this.zzcry = f;
            this.zzcrz = f2;
            this.zzcsa = f2;
            return;
        }
        if (this.state == -1) {
            return;
        }
        if (i != 2) {
            if (i == 1 && this.state == 4) {
                showDialog();
                return;
            }
            return;
        }
        if (f2 > this.zzcrz) {
            this.zzcrz = f2;
        } else if (f2 < this.zzcsa) {
            this.zzcsa = f2;
        }
        if (this.zzcrz - this.zzcsa > this.zzbwx * 30.0f) {
            this.state = -1;
            return;
        }
        if (this.state == 0 || this.state == 2 ? f - this.zzcry >= this.zzbwx * 50.0f : !((this.state != 1 && this.state != 3) || f - this.zzcry > this.zzbwx * (-50.0f))) {
            this.zzcry = f;
            this.state++;
        }
        if (this.state == 1 || this.state == 3) {
            if (f > this.zzcry) {
                this.zzcry = f;
            }
        } else {
            if (this.state != 2 || f >= this.zzcry) {
                return;
            }
            this.zzcry = f;
        }
    }

    private final boolean zza(float f, float f2, float f3, float f4) {
        return Math.abs(this.zzcsc - f) < ((float) this.zzcsb) && Math.abs(this.zzcsd - f2) < ((float) this.zzcsb) && Math.abs(this.zzcse - f3) < ((float) this.zzcsb) && Math.abs(this.zzcsf - f4) < ((float) this.zzcsb);
    }

    /* JADX WARN: Removed duplicated region for block: B:15:0x006f  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final void zzrs() {
        /*
            r5 = this;
            android.content.Context r0 = r5.mContext
            boolean r0 = r0 instanceof android.app.Activity
            if (r0 != 0) goto Lc
            java.lang.String r0 = "Can not create dialog without Activity Context"
            com.google.android.gms.internal.ads.zzakb.zzdj(r0)
            return
        Lc:
            java.lang.String r0 = r5.zzcrx
            boolean r1 = android.text.TextUtils.isEmpty(r0)
            if (r1 != 0) goto L6f
            java.lang.String r1 = "\\+"
            java.lang.String r2 = "%20"
            java.lang.String r0 = r0.replaceAll(r1, r2)
            android.net.Uri$Builder r1 = new android.net.Uri$Builder
            r1.<init>()
            android.net.Uri$Builder r0 = r1.encodedQuery(r0)
            android.net.Uri r0 = r0.build()
            java.lang.StringBuilder r1 = new java.lang.StringBuilder
            r1.<init>()
            com.google.android.gms.ads.internal.zzbv.zzek()
            java.util.Map r0 = com.google.android.gms.internal.ads.zzakk.zzg(r0)
            java.util.Set r2 = r0.keySet()
            java.util.Iterator r2 = r2.iterator()
        L3d:
            boolean r3 = r2.hasNext()
            if (r3 == 0) goto L60
            java.lang.Object r3 = r2.next()
            java.lang.String r3 = (java.lang.String) r3
            r1.append(r3)
            java.lang.String r4 = " = "
            r1.append(r4)
            java.lang.Object r3 = r0.get(r3)
            java.lang.String r3 = (java.lang.String) r3
            r1.append(r3)
            java.lang.String r3 = "\n\n"
            r1.append(r3)
            goto L3d
        L60:
            java.lang.String r0 = r1.toString()
            java.lang.String r0 = r0.trim()
            boolean r1 = android.text.TextUtils.isEmpty(r0)
            if (r1 != 0) goto L6f
            goto L71
        L6f:
            java.lang.String r0 = "No debug information"
        L71:
            android.app.AlertDialog$Builder r1 = new android.app.AlertDialog$Builder
            android.content.Context r2 = r5.mContext
            r1.<init>(r2)
            r1.setMessage(r0)
            java.lang.String r2 = "Ad Information"
            r1.setTitle(r2)
            java.lang.String r2 = "Share"
            com.google.android.gms.internal.ads.zzalg r3 = new com.google.android.gms.internal.ads.zzalg
            r3.<init>(r5, r0)
            r1.setPositiveButton(r2, r3)
            java.lang.String r0 = "Close"
            android.content.DialogInterface$OnClickListener r2 = com.google.android.gms.internal.ads.zzalh.zzcsl
            r1.setNegativeButton(r0, r2)
            android.app.AlertDialog r0 = r1.create()
            r0.show()
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzald.zzrs():void");
    }

    public final void setAdUnitId(String str) {
        this.zzye = str;
    }

    public final void showDialog() {
        try {
            if (!((Boolean) zzkb.zzik().zzd(zznk.zzbec)).booleanValue()) {
                if (!((Boolean) zzkb.zzik().zzd(zznk.zzbeb)).booleanValue()) {
                    zzrs();
                    return;
                }
            }
            if (!(this.mContext instanceof Activity)) {
                zzakb.zzdj("Can not create dialog without Activity Context");
                return;
            }
            String str = !TextUtils.isEmpty(com.google.android.gms.ads.internal.zzbv.zzeu().zzrw()) ? "Creative Preview (Enabled)" : "Creative Preview";
            String str2 = com.google.android.gms.ads.internal.zzbv.zzeu().zzrx() ? "Troubleshooting (Enabled)" : "Troubleshooting";
            ArrayList arrayList = new ArrayList();
            final int iZza = zza((List<String>) arrayList, "Ad Information", true);
            final int iZza2 = zza(arrayList, str, ((Boolean) zzkb.zzik().zzd(zznk.zzbeb)).booleanValue());
            final int iZza3 = zza(arrayList, str2, ((Boolean) zzkb.zzik().zzd(zznk.zzbec)).booleanValue());
            AlertDialog.Builder builder = new AlertDialog.Builder(this.mContext, com.google.android.gms.ads.internal.zzbv.zzem().zzrq());
            builder.setTitle("Select a Debug Mode").setItems((CharSequence[]) arrayList.toArray(new String[0]), new DialogInterface.OnClickListener(this, iZza, iZza2, iZza3) { // from class: com.google.android.gms.internal.ads.zzalf
                private final zzald zzcsh;
                private final int zzcsi;
                private final int zzcsj;
                private final int zzcsk;

                {
                    this.zzcsh = this;
                    this.zzcsi = iZza;
                    this.zzcsj = iZza2;
                    this.zzcsk = iZza3;
                }

                @Override // android.content.DialogInterface.OnClickListener
                public final void onClick(DialogInterface dialogInterface, int i) {
                    this.zzcsh.zza(this.zzcsi, this.zzcsj, this.zzcsk, dialogInterface, i);
                }
            });
            builder.create().show();
        } catch (WindowManager.BadTokenException e) {
            if (zzakb.zzqp()) {
                Log.v(AdRequest.LOGTAG, "", e);
            }
        }
    }

    final /* synthetic */ void zza(int i, int i2, int i3, DialogInterface dialogInterface, int i4) {
        if (i4 == i) {
            zzrs();
            return;
        }
        if (i4 == i2) {
            if (((Boolean) zzkb.zzik().zzd(zznk.zzbeb)).booleanValue()) {
                zzakb.zzck("Debug mode [Creative Preview] selected.");
                zzaki.zzb(new Runnable(this) { // from class: com.google.android.gms.internal.ads.zzali
                    private final zzald zzcsh;

                    {
                        this.zzcsh = this;
                    }

                    @Override // java.lang.Runnable
                    public final void run() {
                        this.zzcsh.zzru();
                    }
                });
                return;
            }
        }
        if (i4 == i3) {
            if (((Boolean) zzkb.zzik().zzd(zznk.zzbec)).booleanValue()) {
                zzakb.zzck("Debug mode [Troubleshooting] selected.");
                zzaki.zzb(new Runnable(this) { // from class: com.google.android.gms.internal.ads.zzalj
                    private final zzald zzcsh;

                    {
                        this.zzcsh = this;
                    }

                    @Override // java.lang.Runnable
                    public final void run() {
                        this.zzcsh.zzrt();
                    }
                });
            }
        }
    }

    final /* synthetic */ void zza(String str, DialogInterface dialogInterface, int i) {
        com.google.android.gms.ads.internal.zzbv.zzek();
        zzakk.zza(this.mContext, Intent.createChooser(new Intent("android.intent.action.SEND").setType("text/plain").putExtra("android.intent.extra.TEXT", str), "Share via"));
    }

    public final void zzda(String str) {
        this.zzaej = str;
    }

    public final void zzdb(String str) {
        this.zzcrx = str;
    }

    public final void zzdc(String str) {
        this.zzchz = str;
    }

    public final void zze(MotionEvent motionEvent) {
        if (!((Boolean) zzkb.zzik().zzd(zznk.zzbed)).booleanValue()) {
            int historySize = motionEvent.getHistorySize();
            for (int i = 0; i < historySize; i++) {
                zza(motionEvent.getActionMasked(), motionEvent.getHistoricalX(0, i), motionEvent.getHistoricalY(0, i));
            }
            zza(motionEvent.getActionMasked(), motionEvent.getX(), motionEvent.getY());
            return;
        }
        int actionMasked = motionEvent.getActionMasked();
        int historySize2 = motionEvent.getHistorySize();
        int pointerCount = motionEvent.getPointerCount();
        if (actionMasked == 0) {
            this.state = 0;
            this.zzcsc = motionEvent.getX();
            this.zzcsd = motionEvent.getY();
            return;
        }
        if (this.state != -1) {
            boolean z = true;
            if (this.state == 0 && actionMasked == 5) {
                this.state = 5;
                this.zzcse = motionEvent.getX(1);
                this.zzcsf = motionEvent.getY(1);
                this.handler.postDelayed(this.zzcsg, ((Long) zzkb.zzik().zzd(zznk.zzbee)).longValue());
                return;
            }
            if (this.state == 5) {
                if (pointerCount == 2) {
                    if (actionMasked == 2) {
                        boolean z2 = false;
                        for (int i2 = 0; i2 < historySize2; i2++) {
                            if (!zza(motionEvent.getHistoricalX(0, i2), motionEvent.getHistoricalY(0, i2), motionEvent.getHistoricalX(1, i2), motionEvent.getHistoricalY(1, i2))) {
                                z2 = true;
                            }
                        }
                        if (zza(motionEvent.getX(), motionEvent.getY(), motionEvent.getX(1), motionEvent.getY(1))) {
                            z = z2;
                        }
                    } else {
                        z = false;
                    }
                }
                if (z) {
                    this.state = -1;
                    this.handler.removeCallbacks(this.zzcsg);
                }
            }
        }
    }

    final /* synthetic */ void zzrt() {
        com.google.android.gms.ads.internal.zzbv.zzeu().zza(this.mContext, this.zzye, this.zzaej, this.zzchz);
    }

    final /* synthetic */ void zzru() {
        com.google.android.gms.ads.internal.zzbv.zzeu().zzg(this.mContext, this.zzye, this.zzaej);
    }

    final /* synthetic */ void zzrv() {
        this.state = 4;
        showDialog();
    }
}
