package com.google.android.gms.internal.ads;

import android.support.annotation.Nullable;
import com.facebook.appevents.AppEventsConstants;
import com.facebook.internal.NativeProtocol;
import com.google.android.gms.common.util.CollectionUtils;
import java.util.HashMap;
import java.util.Map;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzarl extends zzlp {

    @GuardedBy("lock")
    private boolean zzatp;

    @GuardedBy("lock")
    private boolean zzatq;

    @GuardedBy("lock")
    private zzlr zzbuq;
    private final zzapw zzcyg;
    private final boolean zzded;
    private final boolean zzdee;
    private final float zzdef;

    @GuardedBy("lock")
    private int zzdeg;

    @GuardedBy("lock")
    private boolean zzdeh;

    @GuardedBy("lock")
    private float zzdej;

    @GuardedBy("lock")
    private float zzdek;
    private final Object lock = new Object();

    @GuardedBy("lock")
    private boolean zzdei = true;

    @GuardedBy("lock")
    private boolean zzato = true;

    public zzarl(zzapw zzapwVar, float f, boolean z, boolean z2) {
        this.zzcyg = zzapwVar;
        this.zzdef = f;
        this.zzded = z;
        this.zzdee = z2;
    }

    private final void zzf(String str, @Nullable Map<String, String> map) {
        final HashMap map2 = map == null ? new HashMap() : new HashMap(map);
        map2.put(NativeProtocol.WEB_DIALOG_ACTION, str);
        zzaoe.zzcvy.execute(new Runnable(this, map2) { // from class: com.google.android.gms.internal.ads.zzarm
            private final Map zzbjl;
            private final zzarl zzdel;

            {
                this.zzdel = this;
                this.zzbjl = map2;
            }

            @Override // java.lang.Runnable
            public final void run() {
                this.zzdel.zzo(this.zzbjl);
            }
        });
    }

    @Override // com.google.android.gms.internal.ads.zzlo
    public final float getAspectRatio() {
        float f;
        synchronized (this.lock) {
            f = this.zzdek;
        }
        return f;
    }

    @Override // com.google.android.gms.internal.ads.zzlo
    public final int getPlaybackState() {
        int i;
        synchronized (this.lock) {
            i = this.zzdeg;
        }
        return i;
    }

    /* JADX WARN: Removed duplicated region for block: B:12:0x0015  */
    @Override // com.google.android.gms.internal.ads.zzlo
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final boolean isClickToExpandEnabled() {
        /*
            r2 = this;
            boolean r0 = r2.isCustomControlsEnabled()
            java.lang.Object r1 = r2.lock
            monitor-enter(r1)
            if (r0 != 0) goto L15
            boolean r0 = r2.zzatq     // Catch: java.lang.Throwable -> L13
            if (r0 == 0) goto L15
            boolean r0 = r2.zzdee     // Catch: java.lang.Throwable -> L13
            if (r0 == 0) goto L15
            r0 = 1
            goto L16
        L13:
            r0 = move-exception
            goto L18
        L15:
            r0 = 0
        L16:
            monitor-exit(r1)     // Catch: java.lang.Throwable -> L13
            return r0
        L18:
            monitor-exit(r1)     // Catch: java.lang.Throwable -> L13
            throw r0
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzarl.isClickToExpandEnabled():boolean");
    }

    @Override // com.google.android.gms.internal.ads.zzlo
    public final boolean isCustomControlsEnabled() {
        boolean z;
        synchronized (this.lock) {
            z = this.zzded && this.zzatp;
        }
        return z;
    }

    @Override // com.google.android.gms.internal.ads.zzlo
    public final boolean isMuted() {
        boolean z;
        synchronized (this.lock) {
            z = this.zzdei;
        }
        return z;
    }

    @Override // com.google.android.gms.internal.ads.zzlo
    public final void mute(boolean z) {
        zzf(z ? "mute" : "unmute", null);
    }

    @Override // com.google.android.gms.internal.ads.zzlo
    public final void pause() {
        zzf("pause", null);
    }

    @Override // com.google.android.gms.internal.ads.zzlo
    public final void play() {
        zzf("play", null);
    }

    public final void zza(float f, final int i, final boolean z, float f2) {
        final boolean z2;
        final int i2;
        synchronized (this.lock) {
            this.zzdej = f;
            z2 = this.zzdei;
            this.zzdei = z;
            i2 = this.zzdeg;
            this.zzdeg = i;
            float f3 = this.zzdek;
            this.zzdek = f2;
            if (Math.abs(this.zzdek - f3) > 1.0E-4f) {
                this.zzcyg.getView().invalidate();
            }
        }
        zzaoe.zzcvy.execute(new Runnable(this, i2, i, z2, z) { // from class: com.google.android.gms.internal.ads.zzarn
            private final int zzcsi;
            private final int zzcsj;
            private final boolean zzdcp;
            private final boolean zzdcq;
            private final zzarl zzdel;

            {
                this.zzdel = this;
                this.zzcsi = i2;
                this.zzcsj = i;
                this.zzdcp = z2;
                this.zzdcq = z;
            }

            @Override // java.lang.Runnable
            public final void run() {
                this.zzdel.zza(this.zzcsi, this.zzcsj, this.zzdcp, this.zzdcq);
            }
        });
    }

    /* JADX WARN: Removed duplicated region for block: B:48:0x005a  */
    /* JADX WARN: Removed duplicated region for block: B:53:0x0068  */
    /* JADX WARN: Removed duplicated region for block: B:58:0x0076  */
    /* JADX WARN: Removed duplicated region for block: B:68:0x006a A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:70:0x005c A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:73:0x0078 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:75:0x004e A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    final /* synthetic */ void zza(int r7, int r8, boolean r9, boolean r10) {
        /*
            r6 = this;
            java.lang.Object r0 = r6.lock
            monitor-enter(r0)
            r1 = 0
            r2 = 1
            if (r7 == r8) goto L9
            r7 = 1
            goto La
        L9:
            r7 = 0
        La:
            boolean r3 = r6.zzdeh     // Catch: java.lang.Throwable -> L86
            if (r3 != 0) goto L12
            if (r8 != r2) goto L12
            r3 = 1
            goto L13
        L12:
            r3 = 0
        L13:
            if (r7 == 0) goto L19
            if (r8 != r2) goto L19
            r4 = 1
            goto L1a
        L19:
            r4 = 0
        L1a:
            if (r7 == 0) goto L21
            r5 = 2
            if (r8 != r5) goto L21
            r5 = 1
            goto L22
        L21:
            r5 = 0
        L22:
            if (r7 == 0) goto L29
            r7 = 3
            if (r8 != r7) goto L29
            r7 = 1
            goto L2a
        L29:
            r7 = 0
        L2a:
            if (r9 == r10) goto L2e
            r8 = 1
            goto L2f
        L2e:
            r8 = 0
        L2f:
            boolean r9 = r6.zzdeh     // Catch: java.lang.Throwable -> L86
            if (r9 != 0) goto L35
            if (r3 == 0) goto L36
        L35:
            r1 = 1
        L36:
            r6.zzdeh = r1     // Catch: java.lang.Throwable -> L86
            com.google.android.gms.internal.ads.zzlr r9 = r6.zzbuq     // Catch: java.lang.Throwable -> L86
            if (r9 != 0) goto L3e
            monitor-exit(r0)     // Catch: java.lang.Throwable -> L86
            return
        L3e:
            if (r3 == 0) goto L4c
            com.google.android.gms.internal.ads.zzlr r9 = r6.zzbuq     // Catch: android.os.RemoteException -> L46 java.lang.Throwable -> L86
            r9.onVideoStart()     // Catch: android.os.RemoteException -> L46 java.lang.Throwable -> L86
            goto L4c
        L46:
            r9 = move-exception
            java.lang.String r1 = "Unable to call onVideoStart()"
            com.google.android.gms.internal.ads.zzakb.zzc(r1, r9)     // Catch: java.lang.Throwable -> L86
        L4c:
            if (r4 == 0) goto L5a
            com.google.android.gms.internal.ads.zzlr r9 = r6.zzbuq     // Catch: android.os.RemoteException -> L54 java.lang.Throwable -> L86
            r9.onVideoPlay()     // Catch: android.os.RemoteException -> L54 java.lang.Throwable -> L86
            goto L5a
        L54:
            r9 = move-exception
            java.lang.String r1 = "Unable to call onVideoPlay()"
            com.google.android.gms.internal.ads.zzakb.zzc(r1, r9)     // Catch: java.lang.Throwable -> L86
        L5a:
            if (r5 == 0) goto L68
            com.google.android.gms.internal.ads.zzlr r9 = r6.zzbuq     // Catch: android.os.RemoteException -> L62 java.lang.Throwable -> L86
            r9.onVideoPause()     // Catch: android.os.RemoteException -> L62 java.lang.Throwable -> L86
            goto L68
        L62:
            r9 = move-exception
            java.lang.String r1 = "Unable to call onVideoPause()"
            com.google.android.gms.internal.ads.zzakb.zzc(r1, r9)     // Catch: java.lang.Throwable -> L86
        L68:
            if (r7 == 0) goto L76
            com.google.android.gms.internal.ads.zzlr r7 = r6.zzbuq     // Catch: android.os.RemoteException -> L70 java.lang.Throwable -> L86
            r7.onVideoEnd()     // Catch: android.os.RemoteException -> L70 java.lang.Throwable -> L86
            goto L76
        L70:
            r7 = move-exception
            java.lang.String r9 = "Unable to call onVideoEnd()"
            com.google.android.gms.internal.ads.zzakb.zzc(r9, r7)     // Catch: java.lang.Throwable -> L86
        L76:
            if (r8 == 0) goto L84
            com.google.android.gms.internal.ads.zzlr r7 = r6.zzbuq     // Catch: android.os.RemoteException -> L7e java.lang.Throwable -> L86
            r7.onVideoMute(r10)     // Catch: android.os.RemoteException -> L7e java.lang.Throwable -> L86
            goto L84
        L7e:
            r7 = move-exception
            java.lang.String r8 = "Unable to call onVideoMute()"
            com.google.android.gms.internal.ads.zzakb.zzc(r8, r7)     // Catch: java.lang.Throwable -> L86
        L84:
            monitor-exit(r0)     // Catch: java.lang.Throwable -> L86
            return
        L86:
            r7 = move-exception
            monitor-exit(r0)     // Catch: java.lang.Throwable -> L86
            throw r7
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzarl.zza(int, int, boolean, boolean):void");
    }

    @Override // com.google.android.gms.internal.ads.zzlo
    public final void zza(zzlr zzlrVar) {
        synchronized (this.lock) {
            this.zzbuq = zzlrVar;
        }
    }

    public final void zzb(zzmu zzmuVar) {
        synchronized (this.lock) {
            this.zzato = zzmuVar.zzato;
            this.zzatp = zzmuVar.zzatp;
            this.zzatq = zzmuVar.zzatq;
        }
        zzf("initialState", CollectionUtils.mapOf("muteStart", zzmuVar.zzato ? "1" : AppEventsConstants.EVENT_PARAM_VALUE_NO, "customControlsRequested", zzmuVar.zzatp ? "1" : AppEventsConstants.EVENT_PARAM_VALUE_NO, "clickToExpandRequested", zzmuVar.zzatq ? "1" : AppEventsConstants.EVENT_PARAM_VALUE_NO));
    }

    @Override // com.google.android.gms.internal.ads.zzlo
    public final float zzim() {
        return this.zzdef;
    }

    @Override // com.google.android.gms.internal.ads.zzlo
    public final float zzin() {
        float f;
        synchronized (this.lock) {
            f = this.zzdej;
        }
        return f;
    }

    @Override // com.google.android.gms.internal.ads.zzlo
    public final zzlr zzio() {
        zzlr zzlrVar;
        synchronized (this.lock) {
            zzlrVar = this.zzbuq;
        }
        return zzlrVar;
    }

    final /* synthetic */ void zzo(Map map) {
        this.zzcyg.zza("pubVideoCmd", (Map<String, ?>) map);
    }
}
