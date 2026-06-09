package com.google.android.gms.internal.ads;

import android.annotation.TargetApi;
import android.content.Context;
import android.graphics.SurfaceTexture;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Build;
import android.view.Surface;
import android.view.TextureView;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
@TargetApi(14)
@zzadh
public final class zzaov extends zzapg implements MediaPlayer.OnBufferingUpdateListener, MediaPlayer.OnCompletionListener, MediaPlayer.OnErrorListener, MediaPlayer.OnInfoListener, MediaPlayer.OnPreparedListener, MediaPlayer.OnVideoSizeChangedListener, TextureView.SurfaceTextureListener {
    private static final Map<Integer, String> zzcwo = new HashMap();
    private final zzapx zzcwp;
    private final boolean zzcwq;
    private int zzcwr;
    private int zzcws;
    private MediaPlayer zzcwt;
    private Uri zzcwu;
    private int zzcwv;
    private int zzcww;
    private int zzcwx;
    private int zzcwy;
    private int zzcwz;
    private zzapu zzcxa;
    private boolean zzcxb;
    private int zzcxc;
    private zzapf zzcxd;

    static {
        if (Build.VERSION.SDK_INT >= 17) {
            zzcwo.put(-1004, "MEDIA_ERROR_IO");
            zzcwo.put(-1007, "MEDIA_ERROR_MALFORMED");
            zzcwo.put(-1010, "MEDIA_ERROR_UNSUPPORTED");
            zzcwo.put(-110, "MEDIA_ERROR_TIMED_OUT");
            zzcwo.put(3, "MEDIA_INFO_VIDEO_RENDERING_START");
        }
        zzcwo.put(100, "MEDIA_ERROR_SERVER_DIED");
        zzcwo.put(1, "MEDIA_ERROR_UNKNOWN");
        zzcwo.put(1, "MEDIA_INFO_UNKNOWN");
        zzcwo.put(700, "MEDIA_INFO_VIDEO_TRACK_LAGGING");
        zzcwo.put(701, "MEDIA_INFO_BUFFERING_START");
        zzcwo.put(702, "MEDIA_INFO_BUFFERING_END");
        zzcwo.put(800, "MEDIA_INFO_BAD_INTERLEAVING");
        zzcwo.put(801, "MEDIA_INFO_NOT_SEEKABLE");
        zzcwo.put(802, "MEDIA_INFO_METADATA_UPDATE");
        if (Build.VERSION.SDK_INT >= 19) {
            zzcwo.put(901, "MEDIA_INFO_UNSUPPORTED_SUBTITLE");
            zzcwo.put(902, "MEDIA_INFO_SUBTITLE_TIMED_OUT");
        }
    }

    public zzaov(Context context, boolean z, boolean z2, zzapv zzapvVar, zzapx zzapxVar) {
        super(context);
        this.zzcwr = 0;
        this.zzcws = 0;
        setSurfaceTextureListener(this);
        this.zzcwp = zzapxVar;
        this.zzcxb = z;
        this.zzcwq = z2;
        this.zzcwp.zzb(this);
    }

    private final void zza(float f) {
        if (this.zzcwt == null) {
            zzakb.zzdk("AdMediaPlayerView setMediaPlayerVolume() called before onPrepared().");
        } else {
            try {
                this.zzcwt.setVolume(f, f);
            } catch (IllegalStateException unused) {
            }
        }
    }

    private final void zzag(int i) {
        if (i == 3) {
            this.zzcwp.zztt();
            this.zzcxl.zztt();
        } else if (this.zzcwr == 3) {
            this.zzcwp.zztu();
            this.zzcxl.zztu();
        }
        this.zzcwr = i;
    }

    private final void zzag(boolean z) {
        zzakb.v("AdMediaPlayerView release");
        if (this.zzcxa != null) {
            this.zzcxa.zzti();
            this.zzcxa = null;
        }
        if (this.zzcwt != null) {
            this.zzcwt.reset();
            this.zzcwt.release();
            this.zzcwt = null;
            zzag(0);
            if (z) {
                this.zzcws = 0;
                this.zzcws = 0;
            }
        }
    }

    private final void zzsq() {
        zzakb.v("AdMediaPlayerView init MediaPlayer");
        SurfaceTexture surfaceTexture = getSurfaceTexture();
        if (this.zzcwu == null || surfaceTexture == null) {
            return;
        }
        zzag(false);
        try {
            com.google.android.gms.ads.internal.zzbv.zzfb();
            this.zzcwt = new MediaPlayer();
            this.zzcwt.setOnBufferingUpdateListener(this);
            this.zzcwt.setOnCompletionListener(this);
            this.zzcwt.setOnErrorListener(this);
            this.zzcwt.setOnInfoListener(this);
            this.zzcwt.setOnPreparedListener(this);
            this.zzcwt.setOnVideoSizeChangedListener(this);
            this.zzcwx = 0;
            if (this.zzcxb) {
                this.zzcxa = new zzapu(getContext());
                this.zzcxa.zza(surfaceTexture, getWidth(), getHeight());
                this.zzcxa.start();
                SurfaceTexture surfaceTextureZztj = this.zzcxa.zztj();
                if (surfaceTextureZztj != null) {
                    surfaceTexture = surfaceTextureZztj;
                } else {
                    this.zzcxa.zzti();
                    this.zzcxa = null;
                }
            }
            this.zzcwt.setDataSource(getContext(), this.zzcwu);
            com.google.android.gms.ads.internal.zzbv.zzfc();
            this.zzcwt.setSurface(new Surface(surfaceTexture));
            this.zzcwt.setAudioStreamType(3);
            this.zzcwt.setScreenOnWhilePlaying(true);
            this.zzcwt.prepareAsync();
            zzag(1);
        } catch (IOException | IllegalArgumentException | IllegalStateException e) {
            String strValueOf = String.valueOf(this.zzcwu);
            StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 36);
            sb.append("Failed to initialize MediaPlayer at ");
            sb.append(strValueOf);
            zzakb.zzc(sb.toString(), e);
            onError(this.zzcwt, 1, 0);
        }
    }

    private final void zzsr() {
        if (this.zzcwq && zzss() && this.zzcwt.getCurrentPosition() > 0 && this.zzcws != 3) {
            zzakb.v("AdMediaPlayerView nudging MediaPlayer");
            zza(0.0f);
            this.zzcwt.start();
            int currentPosition = this.zzcwt.getCurrentPosition();
            long jCurrentTimeMillis = com.google.android.gms.ads.internal.zzbv.zzer().currentTimeMillis();
            while (zzss() && this.zzcwt.getCurrentPosition() == currentPosition && com.google.android.gms.ads.internal.zzbv.zzer().currentTimeMillis() - jCurrentTimeMillis <= 250) {
            }
            this.zzcwt.pause();
            zzst();
        }
    }

    private final boolean zzss() {
        return (this.zzcwt == null || this.zzcwr == -1 || this.zzcwr == 0 || this.zzcwr == 1) ? false : true;
    }

    @Override // com.google.android.gms.internal.ads.zzapg
    public final int getCurrentPosition() {
        if (zzss()) {
            return this.zzcwt.getCurrentPosition();
        }
        return 0;
    }

    @Override // com.google.android.gms.internal.ads.zzapg
    public final int getDuration() {
        if (zzss()) {
            return this.zzcwt.getDuration();
        }
        return -1;
    }

    @Override // com.google.android.gms.internal.ads.zzapg
    public final int getVideoHeight() {
        if (this.zzcwt != null) {
            return this.zzcwt.getVideoHeight();
        }
        return 0;
    }

    @Override // com.google.android.gms.internal.ads.zzapg
    public final int getVideoWidth() {
        if (this.zzcwt != null) {
            return this.zzcwt.getVideoWidth();
        }
        return 0;
    }

    @Override // android.media.MediaPlayer.OnBufferingUpdateListener
    public final void onBufferingUpdate(MediaPlayer mediaPlayer, int i) {
        this.zzcwx = i;
    }

    @Override // android.media.MediaPlayer.OnCompletionListener
    public final void onCompletion(MediaPlayer mediaPlayer) {
        zzakb.v("AdMediaPlayerView completion");
        zzag(5);
        this.zzcws = 5;
        zzakk.zzcrm.post(new zzaoy(this));
    }

    @Override // android.media.MediaPlayer.OnErrorListener
    public final boolean onError(MediaPlayer mediaPlayer, int i, int i2) {
        String str = zzcwo.get(Integer.valueOf(i));
        String str2 = zzcwo.get(Integer.valueOf(i2));
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 38 + String.valueOf(str2).length());
        sb.append("AdMediaPlayerView MediaPlayer error: ");
        sb.append(str);
        sb.append(":");
        sb.append(str2);
        zzakb.zzdk(sb.toString());
        zzag(-1);
        this.zzcws = -1;
        zzakk.zzcrm.post(new zzaoz(this, str, str2));
        return true;
    }

    @Override // android.media.MediaPlayer.OnInfoListener
    public final boolean onInfo(MediaPlayer mediaPlayer, int i, int i2) {
        String str = zzcwo.get(Integer.valueOf(i));
        String str2 = zzcwo.get(Integer.valueOf(i2));
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 37 + String.valueOf(str2).length());
        sb.append("AdMediaPlayerView MediaPlayer info: ");
        sb.append(str);
        sb.append(":");
        sb.append(str2);
        zzakb.v(sb.toString());
        return true;
    }

    /* JADX WARN: Code restructure failed: missing block: B:15:0x004a, code lost:
    
        if ((r5.zzcwv * r7) > (r5.zzcww * r6)) goto L16;
     */
    /* JADX WARN: Code restructure failed: missing block: B:16:0x004c, code lost:
    
        r1 = (r5.zzcww * r6) / r5.zzcwv;
     */
    /* JADX WARN: Code restructure failed: missing block: B:36:0x008b, code lost:
    
        if (r1 > r6) goto L16;
     */
    /* JADX WARN: Removed duplicated region for block: B:42:0x0097  */
    /* JADX WARN: Removed duplicated region for block: B:45:0x00a2  */
    /* JADX WARN: Removed duplicated region for block: B:56:? A[RETURN, SYNTHETIC] */
    @Override // android.view.View
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected final void onMeasure(int r6, int r7) {
        /*
            r5 = this;
            int r0 = r5.zzcwv
            int r0 = getDefaultSize(r0, r6)
            int r1 = r5.zzcww
            int r1 = getDefaultSize(r1, r7)
            int r2 = r5.zzcwv
            if (r2 <= 0) goto L8e
            int r2 = r5.zzcww
            if (r2 <= 0) goto L8e
            com.google.android.gms.internal.ads.zzapu r2 = r5.zzcxa
            if (r2 != 0) goto L8e
            int r0 = android.view.View.MeasureSpec.getMode(r6)
            int r6 = android.view.View.MeasureSpec.getSize(r6)
            int r1 = android.view.View.MeasureSpec.getMode(r7)
            int r7 = android.view.View.MeasureSpec.getSize(r7)
            r2 = 1073741824(0x40000000, float:2.0)
            if (r0 != r2) goto L55
            if (r1 != r2) goto L55
            int r0 = r5.zzcwv
            int r0 = r0 * r7
            int r1 = r5.zzcww
            int r1 = r1 * r6
            if (r0 >= r1) goto L42
            int r6 = r5.zzcwv
            int r6 = r6 * r7
            int r0 = r5.zzcww
            int r0 = r6 / r0
            r6 = r0
            goto L90
        L42:
            int r0 = r5.zzcwv
            int r0 = r0 * r7
            int r1 = r5.zzcww
            int r1 = r1 * r6
            if (r0 <= r1) goto L90
        L4c:
            int r7 = r5.zzcww
            int r7 = r7 * r6
            int r0 = r5.zzcwv
            int r1 = r7 / r0
            goto L8f
        L55:
            r3 = -2147483648(0xffffffff80000000, float:-0.0)
            if (r0 != r2) goto L67
            int r0 = r5.zzcww
            int r0 = r0 * r6
            int r2 = r5.zzcwv
            int r0 = r0 / r2
            if (r1 != r3) goto L65
            if (r0 <= r7) goto L65
            goto L90
        L65:
            r7 = r0
            goto L90
        L67:
            if (r1 != r2) goto L77
            int r1 = r5.zzcwv
            int r1 = r1 * r7
            int r2 = r5.zzcww
            int r1 = r1 / r2
            if (r0 != r3) goto L75
            if (r1 <= r6) goto L75
            goto L90
        L75:
            r6 = r1
            goto L90
        L77:
            int r2 = r5.zzcwv
            int r4 = r5.zzcww
            if (r1 != r3) goto L87
            if (r4 <= r7) goto L87
            int r1 = r5.zzcwv
            int r1 = r1 * r7
            int r2 = r5.zzcww
            int r1 = r1 / r2
            goto L89
        L87:
            r1 = r2
            r7 = r4
        L89:
            if (r0 != r3) goto L75
            if (r1 <= r6) goto L75
            goto L4c
        L8e:
            r6 = r0
        L8f:
            r7 = r1
        L90:
            r5.setMeasuredDimension(r6, r7)
            com.google.android.gms.internal.ads.zzapu r0 = r5.zzcxa
            if (r0 == 0) goto L9c
            com.google.android.gms.internal.ads.zzapu r0 = r5.zzcxa
            r0.zzh(r6, r7)
        L9c:
            int r0 = android.os.Build.VERSION.SDK_INT
            r1 = 16
            if (r0 != r1) goto Lb9
            int r0 = r5.zzcwy
            if (r0 <= 0) goto Laa
            int r0 = r5.zzcwy
            if (r0 != r6) goto Lb2
        Laa:
            int r0 = r5.zzcwz
            if (r0 <= 0) goto Lb5
            int r0 = r5.zzcwz
            if (r0 == r7) goto Lb5
        Lb2:
            r5.zzsr()
        Lb5:
            r5.zzcwy = r6
            r5.zzcwz = r7
        Lb9:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzaov.onMeasure(int, int):void");
    }

    @Override // android.media.MediaPlayer.OnPreparedListener
    public final void onPrepared(MediaPlayer mediaPlayer) {
        zzakb.v("AdMediaPlayerView prepared");
        zzag(2);
        this.zzcwp.zzsv();
        zzakk.zzcrm.post(new zzaox(this));
        this.zzcwv = mediaPlayer.getVideoWidth();
        this.zzcww = mediaPlayer.getVideoHeight();
        if (this.zzcxc != 0) {
            seekTo(this.zzcxc);
        }
        zzsr();
        int i = this.zzcwv;
        int i2 = this.zzcww;
        StringBuilder sb = new StringBuilder(62);
        sb.append("AdMediaPlayerView stream dimensions: ");
        sb.append(i);
        sb.append(" x ");
        sb.append(i2);
        zzakb.zzdj(sb.toString());
        if (this.zzcws == 3) {
            play();
        }
        zzst();
    }

    @Override // android.view.TextureView.SurfaceTextureListener
    public final void onSurfaceTextureAvailable(SurfaceTexture surfaceTexture, int i, int i2) {
        zzakb.v("AdMediaPlayerView surface created");
        zzsq();
        zzakk.zzcrm.post(new zzapa(this));
    }

    @Override // android.view.TextureView.SurfaceTextureListener
    public final boolean onSurfaceTextureDestroyed(SurfaceTexture surfaceTexture) {
        zzakb.v("AdMediaPlayerView surface destroyed");
        if (this.zzcwt != null && this.zzcxc == 0) {
            this.zzcxc = this.zzcwt.getCurrentPosition();
        }
        if (this.zzcxa != null) {
            this.zzcxa.zzti();
        }
        zzakk.zzcrm.post(new zzapc(this));
        zzag(true);
        return true;
    }

    @Override // android.view.TextureView.SurfaceTextureListener
    public final void onSurfaceTextureSizeChanged(SurfaceTexture surfaceTexture, int i, int i2) {
        zzakb.v("AdMediaPlayerView surface changed");
        boolean z = false;
        boolean z2 = this.zzcws == 3;
        if (this.zzcwv == i && this.zzcww == i2) {
            z = true;
        }
        if (this.zzcwt != null && z2 && z) {
            if (this.zzcxc != 0) {
                seekTo(this.zzcxc);
            }
            play();
        }
        if (this.zzcxa != null) {
            this.zzcxa.zzh(i, i2);
        }
        zzakk.zzcrm.post(new zzapb(this, i, i2));
    }

    @Override // android.view.TextureView.SurfaceTextureListener
    public final void onSurfaceTextureUpdated(SurfaceTexture surfaceTexture) {
        this.zzcwp.zzc(this);
        this.zzcxk.zza(surfaceTexture, this.zzcxd);
    }

    @Override // android.media.MediaPlayer.OnVideoSizeChangedListener
    public final void onVideoSizeChanged(MediaPlayer mediaPlayer, int i, int i2) {
        StringBuilder sb = new StringBuilder(57);
        sb.append("AdMediaPlayerView size changed: ");
        sb.append(i);
        sb.append(" x ");
        sb.append(i2);
        zzakb.v(sb.toString());
        this.zzcwv = mediaPlayer.getVideoWidth();
        this.zzcww = mediaPlayer.getVideoHeight();
        if (this.zzcwv == 0 || this.zzcww == 0) {
            return;
        }
        requestLayout();
    }

    @Override // android.view.View
    protected final void onWindowVisibilityChanged(final int i) {
        StringBuilder sb = new StringBuilder(58);
        sb.append("AdMediaPlayerView window visibility changed to ");
        sb.append(i);
        zzakb.v(sb.toString());
        zzakk.zzcrm.post(new Runnable(this, i) { // from class: com.google.android.gms.internal.ads.zzaow
            private final int zzcsi;
            private final zzaov zzcxe;

            {
                this.zzcxe = this;
                this.zzcsi = i;
            }

            @Override // java.lang.Runnable
            public final void run() {
                this.zzcxe.zzah(this.zzcsi);
            }
        });
        super.onWindowVisibilityChanged(i);
    }

    @Override // com.google.android.gms.internal.ads.zzapg
    public final void pause() {
        zzakb.v("AdMediaPlayerView pause");
        if (zzss() && this.zzcwt.isPlaying()) {
            this.zzcwt.pause();
            zzag(4);
            zzakk.zzcrm.post(new zzape(this));
        }
        this.zzcws = 4;
    }

    @Override // com.google.android.gms.internal.ads.zzapg
    public final void play() {
        zzakb.v("AdMediaPlayerView play");
        if (zzss()) {
            this.zzcwt.start();
            zzag(3);
            this.zzcxk.zzsw();
            zzakk.zzcrm.post(new zzapd(this));
        }
        this.zzcws = 3;
    }

    @Override // com.google.android.gms.internal.ads.zzapg
    public final void seekTo(int i) {
        StringBuilder sb = new StringBuilder(34);
        sb.append("AdMediaPlayerView seek ");
        sb.append(i);
        zzakb.v(sb.toString());
        if (!zzss()) {
            this.zzcxc = i;
        } else {
            this.zzcwt.seekTo(i);
            this.zzcxc = 0;
        }
    }

    @Override // com.google.android.gms.internal.ads.zzapg
    public final void setVideoPath(String str) {
        Uri uri = Uri.parse(str);
        zzhl zzhlVarZzd = zzhl.zzd(uri);
        if (zzhlVarZzd != null) {
            uri = Uri.parse(zzhlVarZzd.url);
        }
        this.zzcwu = uri;
        this.zzcxc = 0;
        zzsq();
        requestLayout();
        invalidate();
    }

    @Override // com.google.android.gms.internal.ads.zzapg
    public final void stop() {
        zzakb.v("AdMediaPlayerView stop");
        if (this.zzcwt != null) {
            this.zzcwt.stop();
            this.zzcwt.release();
            this.zzcwt = null;
            zzag(0);
            this.zzcws = 0;
        }
        this.zzcwp.onStop();
    }

    @Override // android.view.View
    public final String toString() {
        String name = getClass().getName();
        String hexString = Integer.toHexString(hashCode());
        StringBuilder sb = new StringBuilder(String.valueOf(name).length() + 1 + String.valueOf(hexString).length());
        sb.append(name);
        sb.append("@");
        sb.append(hexString);
        return sb.toString();
    }

    @Override // com.google.android.gms.internal.ads.zzapg
    public final void zza(float f, float f2) {
        if (this.zzcxa != null) {
            this.zzcxa.zzb(f, f2);
        }
    }

    @Override // com.google.android.gms.internal.ads.zzapg
    public final void zza(zzapf zzapfVar) {
        this.zzcxd = zzapfVar;
    }

    final /* synthetic */ void zzah(int i) {
        if (this.zzcxd != null) {
            this.zzcxd.onWindowVisibilityChanged(i);
        }
    }

    @Override // com.google.android.gms.internal.ads.zzapg
    public final String zzsp() {
        String strValueOf = String.valueOf(this.zzcxb ? " spherical" : "");
        return strValueOf.length() != 0 ? "MediaPlayer".concat(strValueOf) : new String("MediaPlayer");
    }

    @Override // com.google.android.gms.internal.ads.zzapg, com.google.android.gms.internal.ads.zzaqa
    public final void zzst() {
        zza(this.zzcxl.getVolume());
    }
}
